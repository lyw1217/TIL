# find 명령어 사용법

## find 명령어란?

_**walk a file hierarchy**_

특정 조건을 만족하는 파일들을 찾을 때 사용한다.

## find 명령어 사용법
    find [-H | -L | -P] [-EXdsx] [-f path] path ... [expression]

아무 것도 없이 명령어만 실행하면 현재 디렉토리 하위의 모든 디렉토리 및 파일을 출력해준다.

## find 명령어 옵션

옵션 너무 많다

	-empty
		 빈 디렉토리나 크기가 0인 파일 검색

    -ctime n[smhdw]
	     (change time)
		 파일의 내용 및 속성이 변경된 시간을 기준으로 파일 검색

    -exec utility [argument ...] ;
	     검색 된 파일들에 대해서 명렁(utility) 실행
		 
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
	     Print out a list of all the files whose names do not end in .c.

     find / -newer ttt -user wnj -print
	     Print out a list of all the files owned by	user "wnj" that	are
	     newer than	the file ttt.

     find / \! \( -newer ttt -user wnj \) -print
	     Print out a list of all the files which are not both newer	than
	     ttt and owned by "wnj".

     find / \( -newer ttt -or -user wnj	\) -print
	     Print out a list of all the files that are	either owned by	"wnj"
	     or	that are newer than ttt.

     find / -newerct '1	minute ago' -print
	     Print out a list of all the files whose inode change time is more
	     recent than the current time minus	one minute.

     find / -type f -exec echo {} \;
	     Use the echo(1) command to	print out a list of all	the files.

     find -L /usr/ports/packages -type l -exec rm -- {}	+
	     Delete all	broken symbolic	links in /usr/ports/packages.

     find /usr/src -name CVS -prune -o -depth +6 -print
	     Find files	and directories	that are at least seven	levels deep in
	     the working directory /usr/src.

     find /usr/src -name CVS -prune -o -mindepth 7 -print
	     Is	not equivalent to the previous example,	since -prune is	not
	     evaluated below level seven.

## 참고 자료
- [BSD Manual Page](https://www.freebsd.org/cgi/man.cgi?find(1))
- [find(1) - Linux man page](https://linux.die.net/man/1/find)