# podman-compose runtimeerror: missing networks: privnet 발생 시 해결 방법

podman-compose 를 사용하다 위와 같은 에러가 발생할 수 있다.

이는 최신버전(1.0.4)에서 해결된 문제로, 아래와 같은 명령어로 최신버전을 설치하여 사용하면 된다.

```shell
pip3 install https://github.com/containers/podman-compose/archive/devel.tar.gz
```

### 참고 자료
- https://github.com/containers/podman-compose/issues/463