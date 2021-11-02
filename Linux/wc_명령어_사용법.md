# `wc` 명령어 사용법

## 1. `wc` 명령어란?

'word count'

입력으로 받은 파일의 문자, 줄, 바이트를 출력해준다.

    wc - print newline, word, and byte counts for each file

    Print newline, word, and byte counts for each FILE, and a total line if more than one FILE is specified.  With no FILE, or when FILE is -, read standard input.  A word is a non-zero-length sequence of characters delimited by white space.  The options below may be used to select which counts are printed, always in the following order: newline, word, character, byte, maximum line length.

## 2. `wc` 명령어 사용법

    wc [OPTION]... [FILE]...

`wc` 명령어 뒤에 옵션과 카운트할 파일을 입력해주면 된다.

파일을 아무것도 입력하지 않으면 안된다. `Ctrl + c`로 빠져나오자.

옵션을 아무것도 주어주지 않는다면 -l(라인) -w(단어) -c(바이트) 순으로 출력한다.

![wc_1](images/wc_1.png)

## 3. `wc` 명령어 옵션

    -c, --bytes
            print the byte counts
            파일의 바이트 수를 출력한다.

    -m, --chars
            print the character counts
            파일의 문자(character) 수를 출력한다.

    -l, --lines
            print the newline counts
            파일의 줄(newline) 수를 출력한다.

    --files0-from=F
            read input from the files specified by NUL-terminated names in file F; If F is - then read names from standard input

    -L, --max-line-length
            print the length of the longest line
            파일에서 가장 긴 라인의 길이를 출력한다.

    -w, --words
            print the word counts
            파일의 단어 수를 출력한다.

    --help display this help and exit

    --version
            output version information and exit


## 4. wc 명령어 사용 예시

### 4.1. wc 명령어만 사용하기

- 파일의 바이트 수 세기(`-c`, `--bytes`)
- 파일의 문자들의 수 세기(`-m`, `--chars`)
  - ASCII text는 문자 당 1 byte
- 파일의 줄(라인) 수 세기(`-l`, `--lines`)
- 파일의 단어 수 세기(`-w`, `--words`)

![wc_2](images/wc_2.png)

### 4.2. 다른 명령어와 혼합해서 파일의 개수 세기

`find` 또는 `ls -l` 명령어와 혼합하여 사용하면 파일의 개수를 셀 수 있다.

![wc_3](images/wc_3.png)

## 참고 자료
- [wc(1) - Linux man page](https://linux.die.net/man/1/wc)
- [TWpower's Tech Blog - [Linux] wc 명령어로 바이트, 문자, 단어 그리고 줄(라인) 수 세기](https://twpower.github.io/193-print-num-of-bytes-characters-words-lines-using-wc)