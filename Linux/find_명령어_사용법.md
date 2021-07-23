# find 명령어 사용법

## find 명령어란?

_**walk a file hierarchy**_

특정 조건을 만족하는 파일들을 찾을 때 사용한다.

## find 명령어 사용법
    find [-H | -L | -P] [-EXdsx] [-f path] path ... [expression]

아무 것도 없이 명령어만 실행하면 현재 디렉토리 하위의 모든 디렉토리 및 파일을 출력해준다.

## find 명령어 옵션

옵션 너무 많다

    -ctime n[smhdw]
	     If	no units are specified,	this primary evaluates to true if the
	     difference	between	the time of last change	of file	status infor-
	     mation and	the time find was started, rounded up to the next full
	     24-hour period, is	n 24-hour periods.

	     If	units are specified, this primary evaluates to true if the
	     difference	between	the time of last change	of file	status infor-
	     mation and	the time find was started is exactly n units.  Please
	     refer to the -atime primary description for information on	sup-
	     ported time units.

    -depth  Always true; same as the non-portable -d option.  Cause find to
	     perform a depth-first traversal, i.e., directories	are visited in
	     post-order	and all	entries	in a directory will be acted on	before
	     the directory itself.  By default,	find visits directories	in
	     pre-order,	i.e., before their contents.  Note, the	default	is not
	     a breadth-first traversal.

	     The -depth	primary	can be useful when find	is used	with cpio(1)
	     to	process	files that are contained in directories	with unusual
	     permissions.  It ensures that you have write permission while you
	     are placing files in a directory, then sets the directory's per-
	     missions as the last thing.

     -depth n
	     True if the depth of the file relative to the starting point of
	     the traversal is n.

    -exec utility [argument ...] ;
	     True if the program named utility returns a zero value as its
	     exit status.  Optional arguments may be passed to the utility.
	     The expression must be terminated by a semicolon (";").  If you
	     invoke find from a	shell you may need to quote the	semicolon if
	     the shell would otherwise treat it	as a control operator.	If the
	     string "{}" appears anywhere in the utility name or the arguments
	     it	is replaced by the pathname of the current file.  Utility will
	     be	executed from the directory from which find was	executed.
	     Utility and arguments are not subject to the further expansion of
	     shell patterns and	constructs.

     -exec utility [argument ...] {} +
	     Same as -exec, except that	"{}" is	replaced with as many path-
	     names as possible for each	invocation of utility.	This behaviour
	     is	similar	to that	of xargs(1).  The primary always returns true;
	     if	at least one invocation	of utility returns a non-zero exit
	     status, find will return a	non-zero exit status.

    -name pattern
	     True if the last component	of the pathname	being examined matches
	     pattern.  Special shell pattern matching characters ("[", "]",
	     "*", and "?") may be used as part of pattern.  These characters
	     may be matched explicitly by escaping them	with a backslash
	     ("\").

    -size n[ckMGTP]
	     True if the file's	size, rounded up, in 512-byte blocks is	n.  If
	     n is followed by a	c, then	the primary is true if the file's size
	     is	n bytes	(characters).  Similarly if n is followed by a scale
	     indicator then the	file's size is compared	to n scaled as:

	     k	     kilobytes (1024 bytes)
	     M	     megabytes (1024 kilobytes)
	     G	     gigabytes (1024 megabytes)
	     T	     terabytes (1024 gigabytes)
	     P	     petabytes (1024 terabytes)

    -type t
	     True if the file is of the	specified type.	 Possible file types
	     are as follows:

	     b	     block special
	     c	     character special
	     d	     directory
	     f	     regular file
	     l	     symbolic link
	     p	     FIFO
	     s	     socket

수없이 알짜배기 옵션들이 많다.


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