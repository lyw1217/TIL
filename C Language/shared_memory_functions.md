# 공유 메모리 함수 (Shared Memory Functions)

## 공유 메모리(Shared Memory)란? 
공유 메모리(Shared memory)는 컴퓨터 환경에서 여러 프로그램이 동시에 접근할 수 있는 메모리이다. 과다한 복사를 피하거나 해당 프로그램 간 통신을 위해 고안되었다. 환경에 따라 프로그램은 하나의 프로세서에서나 여러 개의 프로세서에서 실행할 수 있다. (예를 들어 여러 개의 스레드 간에) 하나의 프로그램 안에서 통신을 위해 메모리를 사용하는 일은 일반적으로 공유 메모리로 부르지 않는다. [wikipedia](https://ko.wikipedia.org/wiki/%EA%B3%B5%EC%9C%A0_%EB%A9%94%EB%AA%A8%EB%A6%AC)

멀티 프로세스 환경에서, 프로세스간 통신(Inter-Process Communication, IPC)을 위한 방법은 여러가지가 존재하며 그 중 하나가 바로 공유 메모리 방법이다.

공유 메모리 방법은 IPC 방법 중에서도 가장 빠른 수행속도를 보여주는데, 하나의 메모리를 여러 프로세스에서 공유해서 접근하기 때문에 데이터 복사 등과 같은 불필요한 오버헤드가 발생하지 않기 때문이다.

그러나 하나의 메모리를 여러 프로세스에서 접근하면 모든 병렬 환경에서 그렇듯 동시성 문제가 발생하기에 Semaphore, Mutex와 같은 도구를 활용하는데, 여기서는 공유 메모리를 활용하기 위한 함수에 대해서만 다루도록 하겠다.

## 공유 메모리에 관련된 함수들
    #include <sys/ipc.h>
    #include <sys/shm.h>
    
    int shmget(key_t key, size_t size, int shmflg);             : 공유메모리 get
    int shmctl(int shmid, int cmd, struct shmid_ds *buf);       : 공유메모리 control
    ----------------------------------------------------------
    #include <sys/types.h>
    #include <sys/shm.h>

    void *shmat(int shmid, const void *shmaddr, int shmflg);    : 공유메모리 attach
    int shmdt(const void *shmaddr);                             : 공유메모리 detach


## _**shmget()**_ - 공유 메모리를 생성하거나 접근하기 위한 함수
    #include <sys/ipc.h>
    #include <sys/shm.h>

    int shmget(key_t key, size_t size, int shmflg);
첫 번째 인자로 전달되는 고유한 key 값으로 공유메모리를 얻고 공유메모리의 id를 리턴한다.


## _**shmat()**_ - 공유 메모리를 프로세스에서 사용할 수 있게 하는 함수
    #include <sys/types.h>
    #include <sys/shm.h>

    void *shmat(int shmid, const void *shmaddr, int shmflg);
생성된 공유 메모리의 id를 이용해서 프로세스가 공유 메모리를 사용 가능하도록 붙인다.


## _**shmctl()**_ - 공유 메모리를 제어하기 위한 함수
    #include <sys/ipc.h>
    #include <sys/shm.h>

    int shmctl(int shmid, int cmd, struct shmid_ds *buf);
두 번째 인자로 전달되는 command 를 통해, 첫 번째 인자인 shmid 가 가리키는 공유 메모리를 제어한다.

## _**shmdt()**_ - 공유 메모리를 프로세스에서 분리시키기 위한 함수
    #include <sys/types.h>
    #include <sys/shm.h>

    int shmdt(const void *shmaddr);
프로세스가 더 이상 공유 메모리를 사용할 필요가 없을 경우 프로세스와 공유 메모리를 분리시키기 위해 사용한다.

좀 더 깊게 팔 예정

## 참고 자료
- [랄라라 - [공유 메모리 (shared memory)]](https://unabated.tistory.com/entry/%EA%B3%B5%EC%9C%A0-%EB%A9%94%EB%AA%A8%EB%A6%AC-shared-memory)
- [Mint&Latte - [공유메모리 생성 및 관리 :: shmget(), shmat(), shmdt(), shmctl()]](https://mintnlatte.tistory.com/27)
- Linux manual page
  - [shmget](https://man7.org/linux/man-pages/man2/shmget.2.html#NAME)
  - [shmat](https://man7.org/linux/man-pages/man2/shmat.2.html)
  - [shmctl](https://man7.org/linux/man-pages/man2/shmctl.2.html)
  - [shmdt](https://man7.org/linux/man-pages/man2/shmctl.2.html)