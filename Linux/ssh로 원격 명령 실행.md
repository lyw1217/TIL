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


## 한 줄로 명령어 여러 개 원격 실행

    ssh [user@hostname] "command_1;command_2;"

명령어를 따옴표로 묶고, 각각의 명령어를 세미콜론(`;`)으로 구분지어주면 된다.

### 예시

    ssh

## 스크립트로 실행하는 방법


## 참고 자료
- [ssh 원격 명령 실행](https://doitnow-man.tistory.com/2)