# docker ubuntu apt update 시 "Release file is not valid yet"

dockerfile을 아래와 같이 구성하고

```dockerfile
FROM ubuntu
RUN apt-get update -y
```

`docker build` 했을 때, 아래와 같은 결과가 발생했다.


    [root@node1 test]# docker build -t test .
    Sending build context to Docker daemon  2.048kB
    Step 1/2 : FROM ubuntu
    ---> ba6acccedd29
    Step 2/2 : RUN apt-get update -y
    ---> Running in 1ade374880f5
    Get:1 http://archive.ubuntu.com/ubuntu focal InRelease [265 kB]
    Get:2 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
    Get:3 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
    Get:4 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
    Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 Packages [1275 kB]
    Get:6 http://archive.ubuntu.com/ubuntu focal/multiverse amd64 Packages [177 kB]
    Get:7 http://archive.ubuntu.com/ubuntu focal/restricted amd64 Packages [33.4 kB]
    Get:8 http://archive.ubuntu.com/ubuntu focal/universe amd64 Packages [11.3 MB]
    Reading package lists...
    E: Release file for http://security.ubuntu.com/ubuntu/dists/focal-security/InRelease is not valid yet (invalid for another 2h 38min 30s). Updates for this repository will not be applied.
    E: Release file for http://archive.ubuntu.com/ubuntu/dists/focal-updates/InRelease is not valid yet (invalid for another 2h 39min 2s). Updates for this repository will not be applied.
    E: Release file for http://archive.ubuntu.com/ubuntu/dists/focal-backports/InRelease is not valid yet (invalid for another 2h 39min 46s). Updates for this repository will not be applied.
    The command '/bin/sh -c apt-get update -y' returned a non-zero code: 100
    [root@node1 test]# 

### "Release file is not valid yet" 에러 발생

## 문제 원인

### 시스템 시간과 실제 시간이 일치하지 않기 때문

모든 저장소의 파일은 특정 날짜에 서명되어 있고 이는 릴리즈 파일을 보면 확인할 수 있다.

    root@ddd20648d110:/# head /var/lib/apt/lists/security.ubuntu.com_ubuntu_dists_focal-security_InRelease 
    -----BEGIN PGP SIGNED MESSAGE-----
    Hash: SHA512

    Origin: Ubuntu
    Label: Ubuntu
    Suite: focal-security
    Version: 20.04
    Codename: focal
    Date: Thu, 09 Dec 2021  4:01:42 UTC
    Architectures: amd64 arm64 armhf i386 ppc64el riscv64 s390x

docker에서 run된 우분투 시스템의 시간이 어떤 이유에서인지 실제 시간과 다르게 되어있었고 apt-get update 하는 과정에서 릴리즈 파일이 유효하지 않다고 에러메시지를 띄운 것이다.

(왜 다르게 되었는지는 좀 더 찾아봐야겠다)

## 해결 방법

### 첫 번째 방법, docker 재기동

> `systemctl restart docker`

host의 docker 를 재기동해준다.

https://askubuntu.com/questions/1096930/sudo-apt-update-error-release-file-is-not-yet-valid

1번으로 해결이 안된다면 2번 방법을 시도해본다.

### 두 번째 방법, Dockerfile에서 apt-get update 전 아래 명령어를 수행하도록 한다.

```
RUN echo "Acquire::Check-Valid-Until \"false\";\nAcquire::Check-Date \"false\";" | cat > /etc/apt/apt.conf.d/10no--check-valid-until
```

이 방법은 apt 명령어의 설정에 유효 기간을 체크하는 동작을 하지 않도록 설정하는 것이다.

이렇게 하면 만료된 릴리즈 파일도 받게될 수 도 있어서 좋은 방법은 아니다.

- https://unix.stackexchange.com/questions/2544/how-to-work-around-release-file-expired-problem-on-a-local-mirror


더 좋은 방법을 찾게되면 내용을 추가해야겠다.

### 참고 자료
- https://stackoverflow.com/questions/63526272/release-file-is-not-valid-yet-docker
- https://askubuntu.com/questions/1096930/sudo-apt-update-error-release-file-is-not-yet-valid
- https://itsfoss.com/fix-repository-not-valid-yet-error-ubuntu/