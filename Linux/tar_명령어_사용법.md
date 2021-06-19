## 1. `tar` 명령어란?

tar 명령어는 여러 개의 파일을 하나의 파일로 묶거나 풀 때 사용한다.

여러 개의 파일을 묶을 때, 윈도우나 맥에서 보통 압축을 하기 때문에 tar 도 '압축한다' 라고 말하는 경우가 많은데,

정확하게 말하면 tar 명령어 자체는 '압축' 을 하지 않고 여러 개의 파일을 하나로 묶는 동작만 수행한다.

<p align="center"><img src="images/tar_1.png" alt="예를 들면 이런 식"></p>
<p align="center">예를 들면 이런 식?</p>

그렇지만 tar 명령어를 이용해서 gzip이나 bzip2 와 같은 압축 방식을 이용하여 파일들을 하나로 묶을 수 있는데, 그래서 tar 명령어는 '압축한다' 라고 말해도 틀린 말은 아니다.

## 2. `tar` 명령어 사용법

    tar [OPTION...] [FILE]...

    tar -cf archive.tar foo bar
        # foo 와 bar 파일을 묶어서 archive.tar 파일 생성

    tar -tvf archive.tar
        # archive.tar 파일 안의 모든 파일의 리스트 출력 (묶인 파일들이 풀리지는 않는다)

    tar -xf archive.tar
        # archive.tar 파일 안의 모든 파일을 현재 디렉토리에 풀기

tar 명령어의 자세한 사용법은 사용 예시를 참고.

## 3. `tar` 명령어 옵션

tar 명령어의 옵션도 매우 많지만 자주 사용하는 옵션 위주로 나열했다.

    -c, --create
        파일들을 하나로 묶을 때 사용

    -t, --list
        어떤 파일들이 묶여 있는지 확인

    -x, --extract, --get
        아카이브로부터 추출 (묶인 파일을 풀 때 사용)

    -f, --file=ARCHIVE
        아카이브 파일 지정 (default로 포함되는 옵션이라고 생각하면 된다)

    -j, --bzip2
        bzip2 압축 방식 적용

    -z, --gzip
        gzip 압축 방식 적용

    --exclude=PATTERN
        파일을 묶을 때 제외할 파일들 지정할 때 사용

    -v, --verbose
        진행 과정을 출력

    -w, --interactive, --confirmation
        모든 진행 과정에 대해 확인 요청

    -C, --directory=DIR
        디렉토리 지정

## 4. tar 명령어 사용 예시

### 4-1. 현재 디렉토리의 모든 파일 및 디렉토리를 tar로 묶기

<p align="center"><img src="images/tar_2.png" alt="현재 디렉토리에 있는 모든 파일 및 디렉토리들"></p>
<p align="center">현재 디렉토리에 있는 모든 파일 및 디렉토리들</p>

현재 `~/Doc/Blog` 라는 디렉토리에 있는 파일 및 디렉토리는 사진에서 보이는 것처럼

_디렉토리 2개 : TEST, TEST1_

_파일 3개 : example.txt, text.txt, wiki.txt_

가 있다.

여기에서 `archive.tar` 라는 이름으로 5개 전부 하나의 파일로 묶는 명령어는 아래와 같다.

    tar -cvf archive.tar *        # 현재 디렉토리에 있는 모든(*)것들을 archive.tar로 묶기

    # c 옵션을 통해 하나로 묶이게 되며
    # v 옵션을 통해 진행 상황이 출력될 것이고
    # f 옵션을 통해 archive.tar 라는 파일로 지정할 수 있게 되었다.

<p align="center"><img src="images/tar_3.png" alt="명령어 실행 결과 archive.tar 생성"></p>
<p align="center">명령어 실행 결과 archive.tar 생성</p>

결과에서 보이는 것처럼 `archive.tar` 라는 파일이 생성된 것을 확인할 수 있다.

여기서 주의사항은 `archive.tar` 라는 파일이 이미 존재한다면 바로 overwrite 되기 때문에 항상 주의해서 명령어를 수행하자.

#### 4-2. 파일 또는 디렉토리를 지정해서 tar로 묶기

<p align="center"><img src="images/tar_4.png" alt="현재 디렉토리에 있는 모든 파일 및 디렉토리들"></p>
<p align="center">현재 디렉토리에 있는 모든 파일 및 디렉토리들</p>

이번엔 여기에서 디렉토리인 `TEST`, `TEST1` 을 제외하고

- _example.txt_
- _text.txt_
- _wiki.txt_

이 세가지 파일만 `text_files.tar` 라는 이름으로 묶어보겠다.

    tar -cvf text_files.tar example.txt text.txt wiki.txt

    # example.txt, text.txt, wiki.txt 파일들을 text_files.tar 라는 이름으로 묶기

<p align="center"><img src="images/tar_5.png" alt="명령어 실행 결과 text_files.tar 생성"></p>
<p align="center">명령어 실행 결과 text_files.tar 생성</p>

사진과 같이 `text_files.tar` 파일이 생성된 것을 확인할 수 있다.

추가적으로, 이번에 묶은 파일들은 전부 `.txt` 파일이다.

이런 경우 하나하나 지정해줄 필요 없이 아래와 같은 명령어로 한 번에 여러 파일을 지정해줄 수 있다.

    tar -cvf text_files.tar *.txt
    # 현재 디렉토리 내 모든 파일 중 파일명 뒤에 '.txt' 가 붙은 파일들은 모두 선택된다.

결과는 위와 동일하다.

### 4-3. `tar`로 묶인 파일을 현재 디렉토리에 풀기

그럼 이번엔 위에서 묶었던 파일들을 풀어보자

아래처럼 명령어를 수행하면 현재 디렉토리에 tar로 묶었던 파일들을 풀 수 있다.

    tar -xvf archive.tar
    # 현재 디렉토리에 archive.tar 로 묶인 파일들을 풀어낸다.

<p align="center"><img src="images/tar_6.png" alt="묶었던 파일들이 그대로 있는데 동일한 위치에 풀면 어떻게 될까"></p>
<p align="center">묶었던 파일들이 그대로 있는데 동일한 위치에 풀면 어떻게 될까</p>

그런데 사진처럼, [4-1](#4-1-현재-디렉토리의-모든-파일-및-디렉토리를-tar로-묶기), [4-2](#4-2-파일-또는-디렉토리를-지정해서-tar로-묶기) 묶은 `archive.tar`, `text_files.tar` 안의 내용물들이 같은 디렉토리에 있기 때문에

tar 명령어를 이용해 묶인 걸 풀더라도 overwrite 되고 실제로 풀린 건지 알기 어렵다.

때문에, `TEST` 디렉토리로 묶인 파일들을 옮겨놓고, `TEST` 디렉토리로 이동 후 풀어보겠다.

<p align="center"><img src="images/tar_7.png" alt="TEST 디렉토리에 파일들이 풀렸다"></p>
<p align="center">TEST 디렉토리에 파일들이 풀렸다</p>

`TEST` 디렉토리에 `archive.tar`로 묶인 파일들이 전부 생성된 것을 알 수 있다.

### 4-4. `tar`로 묶인 파일을 원하는 위치에 풀기

[4-3](#4-3-tar로-묶인-파일을-현재-디렉토리에-풀기) 의 방법은 `.tar` 파일을 원하는 디렉토리로 옮겨서 풀어야 한다는 단점이 있다.

tar 파일을 옮기지 않고 제자리에서 내가 원하는 디렉토리에 파일들을 풀고 싶을 땐 C 옵션을 이용하면 된다.

    tar -xvf archive.tar -C ./TEST1
    # TEST1 이라는 디렉토리 안에 archive.tar 로 묶인 파일들을 풀어낸다.

<p align="center"><img src="images/tar_8.png" alt="TEST1 디렉토리 안에 파일들이 풀렸다."></p>
<p align="center">TEST1 디렉토리 안에 파일들이 풀렸다.</p>

### 4-5. `tar`로 묶인 파일의 내용물 확인하기

풀기 전에 어떤 파일들이 있는지 알고 싶을 때에는 t 옵션을 이용하면 된다.

    tar -tvf archive.tar
    # archive.tar 로 묶인 파일들의 목록을 출력한다.

<p align="center"><img src="images/tar_9.png" alt="archive.tar 안의 내용물이 보인다"></p>
<p align="center">archive.tar 안의 내용물이 보인다</p>

이 경우엔 실제로 묶인 파일들이 풀리지는 않고, 목록만 보인다.

#### 4-6. `gzip` 으로 압축하기

tar 명령어는 기본적으로 압축을 하는 것은 아니다. 그러나 여러 옵션을 통해 파일을 묶으면서 압축해서 용량을 절약할 수 있다.

먼저, gzip 이라는 방식을 이용해 압축하기 위해서는 z 옵션을 이용하면 된다.

예시로, text 파일 3개를 그냥 묶고, gzip으로 묶어서 용량을 비교해보겠다.

    tar -zcvf archive.tar.gz *

    # gzip 방식을 이용하여, 현재 디렉토리의 모든 파일을 archive.tar.gz 로 묶고 압축한다.
    # .tar.gz == .tgz 로 줄여서 사용 가능하다.

<p align="center"><img src="images/tar_10.png" alt="그냥 묶은 것과, gzip으로 압축한 것"></p>
<p align="center">그냥 묶은 것과, gzip으로 압축한 것</p>

tar 로 묶인 파일은 _7680_ byte, 거기에 `gzip`으로 압축된 파일은 _2460_ byte로 용량이 대폭 감소한 것을 확인할 수 있다.

파일의 종류마다 압축되는 비율은 다르니 참고하자.