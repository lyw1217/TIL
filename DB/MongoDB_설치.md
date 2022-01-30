# Mongo DB(4.4) 설치(Red Hat or CentOS)

## Overview

몽고DB 4.4 커뮤니티 에디션을 CentOS에서 `yum`을 이용하여 설치하는 방법

### 주의

WSL 에서는 아직 지원되지 않는다고 한다.

## 설치 방법

### 1. 패키지 매니저 `yum` 설정하기

`/etc/yum.repos.d/` 경로에 `mongodb-org-4.4.repo` 파일을 생성한다음 아래 내용을 입력하여 저장해준다.

```
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
```

`yum repolist` 명령어를 수행하여 MongoDB Repository가 정상적으로 추가되었는지 확인해보자.

### 2. MongoDB 패키지 설치하기

- 최신 stable 버전을 설치하려면
    ```
    sudo yum install -y mongodb-org
    ```

- 원하는 버전(여기서는 4.4.11)을 설치하려면

    ```
    sudo yum install -y mongodb-org-4.4.11 mongodb-org-server-4.4.11 mongodb-org-shell-4.4.11 mongodb-org-mongos-4.4.11 mongodb-org-tools-4.4.11
    ```

패키지를 업그레이드할 때,(yum upgrade 등) 자동으로 최신 버전이 업그레이드 될 수 있다.

그런 현상을 방지하고자 할 때는, `/etc/yum.conf` 파일에 아래 `exclude` 구문을 추가해주면 된다.

```
exclude=mongodb-org,mongodb-org-server,mongodb-org-shell,mongodb-org-mongos,mongodb-org-tools
```

### 설치 끝!

## MongoDB 실행하기

### 전제 조건

대부분의 유닉스 시스템들은 시스템 리소스에 제한을 둔다. 이 제한은 MongoDB 작업에 부정적인 영향을 끼칠 수 있으므로 조정해주어야 한다. 조정이 안되어있다면 MongoDB를 실행했을 때 에러를 볼 수 있다.

### ulimit 설정 관련 참고 자료
- [UNIX ulimit Settings](https://docs.mongodb.com/v4.4/reference/ulimit/)
- [How to Install and Configure MongoDB on CentOS 7](https://www.howtoforge.com/tutorial/how-to-install-and-configure-mongodb-on-centos-7/)


### 디렉토리 경로

Default 설정으로, MongoDB는 `mongod` 계정에서 아래 경로에 있는 디렉토리를 이용한다.

- `/var/lib/mongo` (the data directory)
- `/var/log/mongodb` (the log directory)

위 설치 방법대로 `yum` 패키지 매니저를 이용하여 설치하였다면 해당 경로에 디렉토리가 자동으로 생성되어있을 것이다.

만약, 원하는 경로로 변경하고 싶다면 [여기](https://docs.mongodb.com/v4.4/tutorial/install-mongodb-on-red-hat/#to-use-non-default-directories)를 참고하자.

### SELinux 설정

만약, SELinux가 동작 중이라면, 아래 두 가지(cgroup, nestat)에 대한 접근을 허용해줘야한다.

- `cgroup`에 대한 접근 허용하기
  
    SELinux는 MongoDB 프로세스가 `/sys/fs/cgroup` 에 대한 접근을 허용하지 않는다. (사용 가능한 메모리를 결정하는데 필요하다.)

    아래 방법대로 정책을 변경해주자.

    1. `checkpolicy` 패키지 설치
        
        아래 명령어로 `checkpolicy` 패키지를 설치하자.
        ```
        sudo yum install checkpolicy
        ```

    2. `mongodb_cgroup_memory.te` 파일 생성

        터미널에 아래 코드를 그대로 복사하여 `mongodb_cgroup_memory.te` 파일을 생성하자.

        ```
        cat > mongodb_cgroup_memory.te <<EOF
        module mongodb_cgroup_memory 1.0;

        require {
            type cgroup_t;
            type mongod_t;
            class dir search;
            class file { getattr open read };
        }

        #============= mongod_t ==============
        allow mongod_t cgroup_t:dir search;
        allow mongod_t cgroup_t:file { getattr open read };
        EOF
        ```

    3. 파일이 생성되었다면, 아래 3가지 명령어를 이용해서 정책을 컴파일하고 적용해주자.

        ```
        checkmodule -M -m -o mongodb_cgroup_memory.mod mongodb_cgroup_memory.te
        semodule_package -o mongodb_cgroup_memory.pp -m mongodb_cgroup_memory.mod
        sudo semodule -i mongodb_cgroup_memory.pp
        ```

- `netstat`에 대한 접근 허용하기
  
    SELinux는 MongoDB 프로세스가 `/proc/net/netstat` 에 대한 접근을 허용하지 않는다. ([FTDC(Full Time Diagnostic Data Capture)](https://docs.mongodb.com/v4.4/administration/analyzing-mongodb-performance/#std-label-ftdc-stub)에 필요하다.)

    아래 방법대로 정책을 변경해주자.

    1. `checkpolicy` 패키지 설치
        
        아래 명령어로 `checkpolicy` 패키지를 설치하자.
        ```
        sudo yum install checkpolicy
        ```

    2. `mongodb_cgroup_memory.te` 파일 생성

        터미널에 아래 코드를 그대로 복사하여 `mongodb_cgroup_memory.te` 파일을 생성하자.

        ```
        cat > mongodb_proc_net.te <<EOF
        module mongodb_proc_net 1.0;

        require {
            type proc_net_t;
            type mongod_t;
            class file { open read };
        }

        #============= mongod_t ==============
        allow mongod_t proc_net_t:file { open read };
        EOF
        ```

    3. 파일이 생성되었다면, 아래 3가지 명령어를 이용해서 정책을 컴파일하고 적용해주자.

        ```
        checkmodule -M -m -o mongodb_proc_net.mod mongodb_proc_net.te
        semodule_package -o mongodb_proc_net.pp -m mongodb_proc_net.mod
        sudo semodule -i mongodb_proc_net.pp
        ```

### 드디어 실행

- `mongod` 프로세스 시작하기

    ```
    sudo systemctl start mongod
    ```

    만약, `Failed to start mongod.service: Unit mongod.service not found.` 에러가 발생한다면 아래와 같은 커맨드를 먼저 수행하자.

    ```
    sudo systemctl daemon-reload
    ```
    
    그 다음, 다시 start 해보자

- MongoDB 접속하기

    `mongod`가 실행중인 호스트에서 아래 명령어로 접속할 수 있다.
    ```
    mongo
    ```

- 실행 중인지 확인하기

    ```
    sudo systemctl status mongod
    ```

### Configuration 파일

`yum` 과 같은 패키지 매니저로 MongoDB를 설치한 경우, 아래 경로에 Configuration 파일이 존재한다.

```
/etc/mongod.conf
```

설정 파일은 `yaml` 형식으로 되어있으며, 여러 옵션들은 [여기](https://docs.mongodb.com/v4.4/reference/configuration-options/#configuration-file-options)를 참고하자.


### 참고 자료
- [MongoDB Documentation](https://docs.mongodb.com/)
- [MongoDB Manual Version 4.4](https://docs.mongodb.com/v4.4/)