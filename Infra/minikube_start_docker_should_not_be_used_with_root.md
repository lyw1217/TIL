# `minikube start` 수행 시 The "docker" driver should not be used with root privileges 에러 발생

`minikube start` 명령어를 수행했을 때

    Exiting due to DRV_AS_ROOT: The "docker" driver should not be used with root privileges.

라는 오류가 발생했다.

![사진](images/minikube_start_docker_should_not_be_used_with_root.png)

language를 한국으로 하니 에러가 아래처럼 나온다

    ❌  Exiting due to DRV_AS_ROOT: "docker" 드라이버는 root 권한으로 실행되면 안 됩니다

## 해결 방법

minikube issue (https://github.com/kubernetes/minikube/issues/7903)

### Running minikube with root user is not allowed

root가 아닌 새로운 유저를 만들고(아니면 기존 유저에다가) 도커가 그 유저에서 관리되도록 설정해주면 된다.

방법은 https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user 참고

### 왜 root 계정에서 docker driver가 실행되면 안될까?

https://stackoverflow.com/questions/68984450/minikube-why-the-docker-driver-should-not-be-used-with-root-privileges

>Docker allows you to share a directory between the Docker host and a guest container; and it allows you to do so without limiting the access rights of the container. This means that you can start a container where the /host directory is the / directory on your host; and the container can alter your host filesystem without any restriction.

