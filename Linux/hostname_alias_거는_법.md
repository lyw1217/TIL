# hostname(domain)을 alias 설정하는 방법

`/etc/hosts` 를 이용하면 IP를 domain과 연결해줄 수 있다.

```bash
# /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

192.168.0.15   realdomain
```

위 내용은 `fakedomain` 이라는 도메인이 `192.168.0.15` IP에 연결되어있다는 의미이다.

그렇다면 `fakedomain` 이라는 도메인을 `realdomain` 과 연결하고 싶다면 어떻게 해야할까?

## 방법 1

로컬 DNS 서버를 구축해서 CNAME 레코드를 추가한다.

난 다행히 방법 2에서 가능한 함수를 사용 중이어서 방법 2로 시도했다.

## 방법 2 (getaddrinfo(3) 또는 gethostbyname(3) 을 사용하는 경우에만 사용 가능)

```
echo "fakedomain  realdomain" > /etc/host.aliases
echo "export HOSTALIASES=/etc/host.aliases" >> /etc/profile
. /etc/profile
```

`/etc/host.aliases` 라는 파일을 생성해서, `HOSTALIASES` 라는 환경변수에 등록해준다.

파일의 이름이나 위치는 굳이 중요하지 않아보인다.

그렇게 되면 `fakedomain` 도메인에 연결하면 `realdomain` 로 연결할 수 있게 된다.

(테스트 환경 : centos7.5)

## 왜 필요했을까

쿠버네티스에서 서비스의 fqdn을 특정 domain으로 연결하고 싶었다.

예를 들면, `mariadb.mariadb.svc.cluster.local` 라는 fqdn을 `test-ipc1` 라는 이름으로도 사용할 수 있게 해야했다.

- 쿠버네티스 DNS를 이용하면 방법 1로 사용 가능해보이지만, 방법 2로 더 간단히 사용할 수 있어서 일단은 그렇게 했다.

## 주의사항

테스트 중 `test-ipc1` 은 정상적으로 작동 했으나 `test.ipc1` 은 인식하지 못해서 찾아봤더니

[여기](https://man7.org/linux/man-pages/man3/gethostbyname.3.html)를 보면 

> If the name consists of a single component, that is, contains no dot, and if the environment variable HOSTALIASES is set to the name of a file, that file is searched for any string matching the input hostname. 

점(dot)이 포함되지 않은 이름이어야 한다고 나와있다.


### 참고 자료
- https://serverfault.com/questions/65199/is-it-possible-to-alias-a-hostname-in-linux
- https://man7.org/linux/man-pages/man3/gethostbyname.3.html
- https://man7.org/linux/man-pages/man7/hostname.7.html