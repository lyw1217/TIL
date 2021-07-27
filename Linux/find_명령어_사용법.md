# find 명령어 사용법

## find 명령어란?

_**walk a file hierarchy**_

특정 조건을 만족하는 파일들을 찾을 때 사용한다.

## find 명령어 사용법
    find [-H | -L | -P] [-EXdsx] [-f path] path ... [expression]

아무것도 없이 명령어만 실행하면 현재 디렉토리 하위의 모든 디렉토리 및 파일을 출력해준다.

## find 명령어 옵션

옵션 너무 많다

	-empty
		 빈 디렉토리나 크기가 0인 파일 검색

    -ctime n[smhdw]
	     (change time)
		 파일의 내용 및 속성이 변경된 시간을 기준으로 파일 검색

    -exec utility [argument ...] ;
	     검색된 파일들에 대해서 명령(utility) 실행
		 
    -name pattern
	     이름이 pattern에 해당하는 파일 검색

    -size n[ckMGTP]
	     파일의 크기로 검색
		 k	     kilobytes (1024 bytes)
	     M	     megabytes (1024 kilobytes)
	     G	     gigabytes (1024 megabytes)
	     T	     terabytes (1024 gigabytes)
	     P	     petabytes (1024 terabytes)

    -type t
	     지정한 파일 타입에 해당하는 파일 검색
	     b	     block special
	     c	     character special
	     d	     directory
	     f	     regular file
	     l	     symbolic link
	     p	     FIFO
	     s	     socket

이외에 많은 옵션이 있다.


## find 명령어 사용 예시

     find / \! -name "*.c" -print
	     파일명이 '.c'로 끝나는 파일을 제외한(\!) 모든 파일들의 목록 출력

     find / -newer ttt -user wnj -print
	     "wnj" 라는 이름의 유저가 소유권을 가졌으며, "ttt" 라는 파일보다 더 최근에 생성된 파일들의 목록 출력 

     find / \! \( -newer ttt -user wnj \) -print
	     "wnj" 유저가 소유하지도 않았고 (and) "ttt" 라는 파일보다 더 최근에 생성되지도 않은 모든 파일들의 목록 출력

     find / \( -newer ttt -or -user wnj	\) -print
	     "wnj" 유저가 소유했거나 (or)  "ttt" 라는 파일보다 더 최근에 생성된 모든 파일들의 목록 출력

     find / -newerct '1	minute ago' -print
	     inode 변경 시간이 현재 시간에서 1분을 뺀 시간보다 최근인 모든 파일들의 목록 출력 

     find / -type f -exec echo {} \;
	     모든 파일들(-type f)의 목록을 echo 명령어의 입력값으로 사용

     find -L /usr/ports/packages -type l -exec rm -- {}	+
	     /usr/ports/packages 디렉토리에 있는 모든 심볼릭 링크 중 broken symbolic links(이동되었거나 존재하지 않는 대상을 가리키는 링크)들을 삭제(rm 명령어의 입력값으로 사용)

## 참고 자료
- [BSD Manual Page](https://www.freebsd.org/cgi/man.cgi?find(1))
- [find(1) - Linux man page](https://linux.die.net/man/1/find)