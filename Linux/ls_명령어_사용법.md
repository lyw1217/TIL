# `ls` 명령어 사용법

## ls 명령어란?

File들(기본적으로 현재 디렉토리)에 대한 정보를 나열한다. 따로 옵션이 없는 경우 알파벳 순으로 정렬한다.

## ls 명령어 사용법

```bash
ls [OPTION]... [FILE]...
```

FILE 에 대한 정보를 OPTION 에 따라 나열한다.

## ls 명령어 옵션
ls 명령어에도 수많은 옵션이 있다. 그 중 중요하다고 생각하는 몇 가지만 추려봤다.

```bash
ls [OPTION]... [FILE]...
    -a, --all               : . 으로 시작되는 파일들(숨은 파일)까지 전부 출력
    -l                      : 구체적인 파일 목록 출력
    -h, --human-readable    : -l 과 함께 쓰이며, 파일 사이즈를 읽기 쉽게 보여준다. (e.g., 1K 234M 2G)
    -r, --reverse           : 정렬 순서를 반대로(오름차순->내림차순 등)
    -R, --recursive         : 재귀적으로 디렉토리 내부 목록을 출력
    -S                      : 파일 사이즈 순으로 정렬
    -t                      : 수정 시간 순으로 정렬, 최신이 가장 위에 출력됨
```

다른 옵션은 ls의 man page를 참고.

## ls 명령어 사용 예시

아마존 리눅스가 설치된 서버에서 ls 명령어를 실행해서 아래와 같은 결과가 나왔다.

![ls 명령어 옵션 없이 사용한 결과](images/ls_1.png)

현재 내가 위치한 `/home/ec2-user` 디렉토리 내부에 `app`, `Download` 라는 파일이 있음을 확인할 수 있다.

여기서 좀 더 구체적인 정보를 원한다면 `-l` 옵션을 추가하면 된다.

![ls 명령어에 -l 옵션을 사용한 결과](images/ls_2.png)

명령어 실행 결과 `app`, `Download` 는 디렉토리였음을 확인할 수 있고
각각 'Mar 28', 'Dec 27' 에 생성되었음을 알 수 있다.

여기서 `-a` 옵션을 추가해 `-al` 옵션으로 명령어를 수행한다면 어떤 결과가 나타날까?

![ls 명령어에 -al 옵션을 사용한 결과](images/ls_3.png)

이전까지는 `app`, `Download` 디렉토리밖에 없는 것처럼 보였지만 `-a` 옵션으로 인해 숨은 파일까지 전부 볼 수 있게 되었다.