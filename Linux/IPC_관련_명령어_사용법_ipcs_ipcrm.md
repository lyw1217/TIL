# IPC 관련 명령어 사용법(`ipcs`, `ipcrm`)

## IPC (Inter-Process Communication)

프로세스 간 통신

프로세스들 사이에 서로 데이터를 주고받는 행위 또는 그에 대한 방법이나 경로를 뜻한다.

여러 IPC 방식이 있지만, ipcs/ipcrm 명령어에서 확인 가능한 자원은 메시지큐(Message Queue), [공유메모리(Shared Memory)](https://github.com/lyw1217/TIL/blob/main/C/shared_memory_functions.md), 세마포어(Semaphore)이다.

## 1. `ipcs` 명령어란?

IPC 자원에 대한 정보를 제공한다.

### `ipcs` 명령어 사용법

    ipcs [resource-option] [output-format]
    ipcs [resource-option] -i id

### `ipcs` 명령어 옵션

    OPTIONS
       -i, --id id
              Print details only on the resource identified by id.
              id에 해당하는 자원만 보여준다.

       -h, --help
              Display a help text and exit.

       -V, --version
              Display version information and exit.

    Resource options
       -q, --queues
              Write information about active message queues.
              메시지 큐 자원에 대한 정보를 조회한다.

       -m, --shmems
              Write information about active shared memory segments.
              공유 메모리 자원에 대한 정보를 조회한다.

       -s, --semaphores
              Write information about active semaphore sets.
              세마포어 자원에 대한 정보를 조회한다.

       -a, --all
              Write information about all three resources (default).
              모든 IPC 자원(message queue, shared memory, semaphore)을 조회한다.

    Output formats
       Of these options only one takes effect: the last one specified.

       -c, --creator
              Show creator and owner.
              생성자와 소유자에 대한 정보를 보여준다.

       -l, --limits
              Show resource limits.
              각 자원에 대한 limits(max value)를 보여준다.

       -p, --pid
              Show PIDs of creator and last operator.
              생성자와 마지막 operator(마지막으로 IPC 자원에 대한 접근을 한)의 PID를 보여준다.

       -t, --time
              Write  time  information.   The  time of the last control operation that changed the access permissions for all facilities, the time of the last msgsnd() and msgrcv() operations on message queues, the time of the last
              shmat() and shmdt() operations on shared memory, and the time of the last semop() operation on semaphores.
              각 자원에 대한 시간 정보를 보여준다. (언제 attached 되었는지, detached 되었는지, changed 되었는지 등등)

       -u, --summary
              Show status summary.
              상태 정보를 요약해서 보여준다.

## 2. `ipcrm` 명령어란?

[`ipcs`](#1-ipcs-명령어란) 명령어로 확인 가능한 IPC 자원을 삭제한다.

자원을 삭제하려면 superuser, creator, owner 중 하나여야 한다.

Message Queue, Semaphore 자원은 즉시 삭제할 수 있지만, Shared Memory 자원은 모든 프로세스가 해당 자원을 detach([shmdt()](https://github.com/lyw1217/TIL/blob/main/C/shared_memory_functions.md)) 한 뒤에 삭제된다.

### `ipcrm` 명령어 사용법

    ipcrm [options]
    ipcrm {shm|msg|sem} id...

### `ipcrm` 명령어 옵션

    -M, --shmem-key shmkey
            removes the shared memorysegment created with shmkey after the last detach is performed.
            지정된 키로 공유 메모리 세그먼트를 제거한다.

    -m, --shmem-id shmid
            removes the shared memory segment identified by shmid after the last detach is performed.
            지정된 ID로 공유 메모리 세그먼트를 제거한다.

    -Q, --queue-key msgkey
            removes the message queue created with msgkey.
            지정된 키로 메시지 큐를 제거한다.

    -q, --queue-id msgid
            removes the message queue identified by msgid.
            지정된 ID로 메시지 큐를 제거한다.

    -S, --semaphore-key semkey
            removes the semaphore created with semkey.
            지정된 키로 세마포어 세트를 제거한다.

    -s, --semaphore-id semid
            removes the semaphore identified by semid.
            지정된 ID로 세마포어 세트를 제거한다.

    -a, --all [shm msg sem]
            Remove  all resources. When option argument is provided the removal is performed only to for the specified resource types. Warning! Do not use -a if you are unsure how the software using resources might react on miss-
            ing objects. Some programs create these resources at start up and may not have any code to deal unexpected disappearance.
            모든 IPC 자원을 제거한다. 옵션이 부여된 경우 지정된 타입의 자원에 대해서만 제거된다.
            경고! 해당 자원을 사용하는 프로세스가 그 자원이 삭제된 경우 어떻게 반응할 수 있는지 모르는 경우 -a 옵션을 사용하면 안된다. 예기치 않은 일이 발생할 수 있다.

## 참고 자료

- [ipcs(1) - Linux man page](https://linux.die.net/man/1/ipcs)
- [ipcrm(1) - Linux man page](https://linux.die.net/man/1/ipcrm)
- [위키백과 - 프로세스 간 통신](https://ko.wikipedia.org/wiki/%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4_%EA%B0%84_%ED%86%B5%EC%8B%A0)
- [[명령어] IPC 관련 명령어 - ipcs, ipcrm](https://blueyikim.tistory.com/1301)