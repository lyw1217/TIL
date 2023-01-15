# jenkins alpine 리눅스 Publish over SSH Auth Error

> jenkins에서 Publish over SSH 설정하는 중에 Auth 에러가 아무리해도 해결되지 않았는데, 대충 원인을 찾아서 기록합니다.

## 에러가 발생한 곳

jenkins에서 Publish over SSH 설정 중, SSH Server를 등록하는 과정

## 에러 내용

1. Publish over SSH를 위해 jenkins container에 `ssh-keygen -t rsa` 를 이용해 키를 생성함
2. target container`(alpine3.15 linux base)`의 `~/.ssh/authorized_keys`에 생성한 `id_rsa.pub`를 등록함(`~`, `.ssh` 권한 700, `~/.ssh/authorized_keys` 권한 600)
3. jenkins container에서 target container로 id_rsa를 이용한 ssh 접속이 잘 됨을 확인
4. 그런데 jenkins 설정에서 `Test Configuration` 실행 시 아래와 같은 에러 발생

```
Failed to connect and initialize SSH connection. Message: [Failed to connect session for config [ojeommu]. Message [Auth fail]]
```

key를 다시 생성해보고, PEM으로도 생성해보고, Passphrase를 등록해서 생성해보기도.. 등등 며칠동안 여러가지 생각나는 것들은 전부 해보았는데 jenkins container에서 `ssh root@target_container` 명령어로 ssh 접속은 잘 되지만 `Test Configuration`은 실패. 동일한 에러가 발생했다.

## 에러 해결?

불현듯 `alpine3.15`의 문제인가 싶어서 target container의 base image를 `debian-slim`으로 변경 후 다시 시도해보았고 결과는 바로 Success가 나왔다.

동일한 Key를 이용했는데 왜 `alpine`에서는 안되고 `debian-slim`에서는 되는 것일까..

## 에러 원인

원인은 아직 모르겠다. 

[https://stackoverflow.com/questions/70970025/connecting-via-ssh-when-building-app-with-jenkins](https://stackoverflow.com/questions/70970025/connecting-via-ssh-when-building-app-with-jenkins)

이 질문이 가장 근접해보이지만 사실 잘 이해가 가지 않는다..