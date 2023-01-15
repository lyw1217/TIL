# jenkins Github SSH 에러 (No ECDSA host key...)

```
No ECDSA host key is known for github.com and you have requested strict checking.
Host key verification failed.
```

jenkins와 Github를 이용하여 빌드 환경 구성 중 Github에 키 값을 추가하였는데도 위와 같은 에러가 발생했다.

문제 원인은 known_hosts에 등록되지 않았던 것이었다.

```bash
jenkins@ea1f0b09c539:~$ git ls-remote -h git@github.com:lyw1217/OJeomMu.git HEAD
The authenticity of host 'github.com (20.200.245.247)' can't be established.
ECDSA key fingerprint is SHA256:-/-/-.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com,20.200.245.247' (ECDSA) to the list of known hosts.
```

위와 같이 `git ls-remote -h git@github.com:lyw1217/OJeomMu.git HEAD` 명령어를 수행하니

새로운 HOST에 SSH를 통해 접속할 때 발생하는 경고 메시지가 나왔고

`yes` 를 입력해줌으로써 known_hosts에 github에 대한 내용을 추가해주었다.

### 참고 자료
- [https://stackoverflow.com/questions/15174194/jenkins-host-key-verification-failed](https://stackoverflow.com/questions/15174194/jenkins-host-key-verification-failed)