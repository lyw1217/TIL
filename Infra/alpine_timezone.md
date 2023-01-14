# alpine 리눅스에서 timezone 설정하기(docker container)

alpine 리눅스는 워낙 경량 이미지다보니 `TZ` 환경변수를 설정해주는 것만으로는 timezone이 정상적으로 변경되지 않는다.

`KST`로 timezone을 설정하는 방법은 [Alpine Linux WiKi](https://wiki.alpinelinux.org/wiki/Setting_the_timezone)에서 확인할 수 있다.

이를 활용해서 Dockerfile에서는 아래처럼 적용하면 된다.

```Dockerfile
# Dockerfile
ENV TZ=Asia/Seoul
    
RUN apk --no-cache add tzdata && \
	cp /usr/share/zoneinfo/$TZ /etc/localtime && \
	echo $TZ > /etc/timezone \
	apk del tzdata
```

- 환경변수 `TZ` 를 `"Asia/Seoul"`로 설정
- `apk` 패키지 매니저를 이용하여 `tzdata` 추가
- 추가한 timezone들 중 환경변수 `TZ`로 설정한 timezone을 `/etc/localtime` 에 복사
- `/etc/timezone` 에 timezone을 명시
- 추가했던 `tzdata` 를 삭제

### 참고자료 
- [https://wiki.alpinelinux.org/wiki/Setting_the_timezone](https://wiki.alpinelinux.org/wiki/Setting_the_timezone)
- [https://stackoverflow.com/questions/68996420/how-to-set-timezone-inside-alpine-base-docker-image](https://stackoverflow.com/questions/68996420/how-to-set-timezone-inside-alpine-base-docker-image)
- [https://findstar.pe.kr/2021/07/25/timezone-pkg-on-alpine-linux/](https://findstar.pe.kr/2021/07/25/timezone-pkg-on-alpine-linux/