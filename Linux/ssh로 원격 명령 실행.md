# ssh로 원격으로 명령어 실행하는 방법

## 기본 방법
    
ssh 명령어의 manpage에서, 아래와 같은 Synopsis를 확인할 수 있다.

    ssh [-afgknqstvxACNTX1246] [-b bind_address] [-m mac_spec] 
     [-c cipher_spec] [-e escape_char] [-i identity_file] 
     [-i PKCS#11-URI]
     [-l login_name] [-F configfile] [-o option] [-p port] 
     [-L [bind_address:]port:host:hostport]
     [-R [bind_address:]port:host:hostport]
     [-D [bind_address:]port] hostname | user@hostname [command]
    
여기서 맨 윗 줄과 아랫 줄만 빼서 보면 아래와 같이 줄일 수 있다.

    ssh [user@hostname] [command]

즉, 아래와 같은 명령어를 사용하면

    ssh root@192.168.2.100 ls -al

`192.168.2.100` 원격지에서, `root` 계정의 홈 디렉토리에서, `ls -al` 명령어를 수행한 결과를 현재의 터미널에 출력해준다. 


## 한 줄로 여러 개 명령어 원격 실행

    ssh [user@hostname] "command_1;command_2;"

명령어를 따옴표로 묶고, 각각의 명령어를 세미콜론(`;`)으로 구분지어주면 된다.

### 예시

    ssh user@server_ip "ls -a; df"

`server_ip` 원격지에서, `user` 계정의 홈 디렉토리에서, `ls -al` 명령어를 수행한 결과와 `df` 명령어를 수행한 결과를 현재의 터미널에 출력해준다.

## 스크립트로 실행하는 방법

### 별도의 쉘스크립트를 만들고 원격에 스크립트 해석기를 실행시키고 파이프나 리다이렉션으로 보내는 방법
    
    test_script.sh

    #!/bin/sh
    ls -la
    df

cat test_script.sh | ssh myserver sh
또는
ssh myserver sh < test_script.sh

### 여러 서버에 루프를 돌면서 지정한 스크립트를 실행하는 스크립트

    #!/bin/sh
    SERVERS="
    myserver1
    myserver2
    "
    for m in $SERVERS
    do
        ssh $m sh < test_script.sh  # 순차 실행
        # ssh $m sh < test_script.sh > $m.log &  # 백그라운드 실행
    done

## 참고 자료
- [ssh 원격 명령 실행](https://doitnow-man.tistory.com/2)
- [SSH로 많은 서버에 동시에 같은 명령내리기](http://aero.sarang.net/blog/2008/11/ssh.html)