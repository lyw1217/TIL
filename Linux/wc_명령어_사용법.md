# `wc` 명령어 사용법

## 1. `wc` 명령어란?

'word count'

    wc - print newline, word, and byte counts for each file

    Print newline, word, and byte counts for each FILE, and a total line if more than one FILE is specified.  With no FILE, or when FILE is -, read standard input.  A word is a non-zero-length sequence of characters delimited by white space.  The options below may be used to select which counts are printed, always in the following order: newline, word, character, byte, maximum line length.

## 2. `wc` 명령어 사용법

    wc [OPTION]... [FILE]...


## 3. `wc` 명령어 옵션

    -c, --bytes
            print the byte counts

    -m, --chars
            print the character counts

    -l, --lines
            print the newline counts

    --files0-from=F
            read input from the files specified by NUL-terminated names in file F; If F is - then read names from standard input

    -L, --max-line-length
            print the length of the longest line

    -w, --words
            print the word counts

    --help display this help and exit

    --version
            output version information and exit


## 4. wc 명령어 사용 예시

### 4.1. wc 명령어만 사용하기

- 파일의 바이트 수 세기

- 파일의 문자들의 수 세기

- 파일의 줄(라인) 수 세기

- 파일의 단어 수 세기

### 4.2. 다른 명령어와 혼합해서 파일의 개수 세기

`ls -l` 명령어와 혼합하여 사용하면 파일의 개수를 셀 수 있다.

## 참고 자료
- [wc(1) - Linux man page](https://linux.die.net/man/1/wc)
- [TWpower's Tech Blog - [Linux] wc 명령어로 바이트, 문자, 단어 그리고 줄(라인) 수 세기](https://twpower.github.io/193-print-num-of-bytes-characters-words-lines-using-wc)