# 도커 컨테이너에서 호스트에 있는 명령어를 실행하는 방법

출처의 내용을 한글로 번역하였습니다.   

출처 : [https://stackoverflow.com/questions/32163955/how-to-run-shell-script-on-host-from-docker-container](https://stackoverflow.com/questions/32163955/how-to-run-shell-script-on-host-from-docker-container)

---

도커 컨테이너에서 호스트에 있는 명령어를 호스트가 직접 실행하게 하고 싶다.

네임드 파이프(Named Pipe, 명명된 파이프)를 이용하여 컨테이너와 호스트 간 통신을 하여 구현할 것이다.

파이프란 프로세스간 통신을 할 때 사용하는 방법 중 하나이다.

- 리눅스 파이프 관련 자료 참고
  - [https://gracefulprograming.tistory.com/92](https://gracefulprograming.tistory.com/92)
  - [https://velog.io/@t1won/Unix-pipe](https://velog.io/@t1won/Unix-pipe)
  - [https://reakwon.tistory.com/80](https://reakwon.tistory.com/80)


# 방법

## 1. 호스트에서 파이프 생성해보기

호스트에서, named pipe를 원하는 위치에 아래 명령어로 생성한다.

```bash
mkfifo /path/to/pipe/mypipe
```

Type이 p인 파일이 생성된다.

```bash
ls -l /path/to/pipe/mypipe
prw-r--r-- 1 root root 0  5월 18 15:08 /path/to/pipe/mypipe
```

터미널을 2개 열어서, 파이프로 메시지를 수신/송신 해보자.

터미널 1에서 파이프에서 메시지를 수신하도록 한다.

```bash
# 터미널 1
tail -f /path/to/pipe/mypipe
```

터미널 2에서 파이프로 메시지를 송신한다.

```bash
# 터미널 2
echo "hello world!" > /path/to/pipe/mypipe
```

터미널 1에서 "hello world!" 가 정상적으로 출력되는지 확인한다.

`Ctrl + C`를 입력하여 빠져나올 수 있다. 

## 2. 생성한 파이프를 통해 명령어 수행해보기

터미널 1에서 `tail -f` 대신 아래 명령어로 파이프에서 읽은 메시지를 수행하도록 한다.

```bash
# 터미널 1
eval "$(cat /path/to/pipe/mypipe)"
```

터미널 2에서 `ls -l` 명령어를 파이프로 송신한다.

```bash
# 터미널 2
echo "ls -l" > /path/to/pipe/mypipe
```

터미널 1에서 `ls -l` 명령어의 수행 결과가 출력되는지 확인한다.

## 3. 호스트에서 파이프를 계속 읽도록 하기

[2번](#2-생성한-파이프를-통해-명령어-수행해보기) 방법에선 하나의 명령어를 수신한 뒤 멈추기 때문에, 아래 명령어로 계속 수신하게 한다.

```bash
# 터미널 1
while true; do eval "$(cat /path/to/pipe/mypipe)"; done
```

이제 터미널 2에서 파이프로 여러 번 명령어를 송신해도 처음 수신 후 멈추지 않고 계속해서 명령어를 수신받는 것을 확인한다.

`Ctrl + C`를 입력하여 빠져나올 수 있다. 

## 4. reboot 시에도 스크립트가 실행되도록 하기

아래 내용을 스크립트로 작성한다.

```bash
#!/bin/bash
while true; do eval "$(cat /path/to/pipe/mypipe)"; done
```

만약 파이프로 전송된 메시지 수행한 기록을 파일로 남기고 싶다면 아래 내용으로 스크립트를 작성한다.

```bash
#!/bin/bash
while true; do eval "$(cat /path/to/pipe/mypipe)" &> /somepath/output.txt; done
# /somepath/output.txt 파일에 기록이 남는다.
# &>> 로 변경하면 덮어쓰지 않고 뒤에 붙여쓴다.
```


작성한 스크립트를 `chmod +x` 로 실행권한을 준다.

그리고 crontab에 reboot 시 스크립트가 실행되도록 추가한다.

```bash
crontab -e
```

```
# 아래 내용을 추가
@reboot /path/to/pipe/exec_pipe.sh
```

## 5. 컨테이너에서 호스트의 파이프 마운트하기(VOLUME)

dockerfile 또는 컨테이너를 실행할 때, 생성한 파이프 파일을 마운트하도록 volumn을 설정한다.

호스트의 `/path/to/pipe` 디렉토리를 컨테이너의 `/hostpipe` 디렉토리에 마운트한다.

```dockerfile
# dockerfile 에서 설정
volumes:
   - /path/to/pipe:/hostpipe
```

```bash
# 컨테이너 실행 시 설정
docker run test -d --name <container> -v /path/to/pipe:/hostpipe ubuntu:20.04 bash
```

## 6. 컨테이너에서 파이프를 통해 호스트에서 명령어 실행하게 하기

컨테이너에 접속해서 파이프에 명령어를 송신해보자.

컨테이너에 접속한다.

```bash
docker exec -it <container> bash
```

컨테이너에 호스트의 파이프가 마운트 된 것을 확인할 수 있다.

```bash
cd /hostpipe && ls -l
```

컨테이너에서 파이프로 명령어를 송신한다.

```bash
echo "touch this_file_was_created_on_main_host_from_a_container.txt" > /hostpipe/mypipe
```

파이프를 통해 `this_file_was_created_on_main_host_from_a_container.txt` 파일이 호스트에 생성되었음을 확인해보자.

## 주의사항

리눅스 host, 리눅스 container에서 정상 작동한다.

macOS 또는 Windows 기반의 시스템에서는 정상 작동하지 않을 수 있다.

