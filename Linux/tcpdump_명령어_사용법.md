# `tcpdump` 명령어 사용법

## `tcpdump` 명령어란?

[위키백과](https://ko.wikipedia.org/wiki/Tcpdump)

tcpdump는 CLI 환경에서 실행하는 일반적인 패킷 가로채기 소프트웨어이다.

사용자가 TCP/IP 뿐 아니라, 컴퓨터에 부착된 네트워크를 통해 송수신되는 기타 패킷을 가로채고 표시할 수 있게 도와준다.

## `tcpdump` 명령어 사용법

    tcpdump [ -AbdDefhHIJKlLnNOpqRStuUvxX ] [ -B buffer_size ] [ -c count ]
            [ -C file_size ] [ -G rotate_seconds ] [ -F file ]
            [ -i interface ] [ -j tstamp_type ] [ -m module ] [ -M secret ]
            [ -P in|out|inout ]
            [ -r file ] [ -V file ] [ -s snaplen ] [ -T type ] [ -w file ]
            [ -W filecount ]
            [ -E spi@ipaddr algo:secret,...  ]
            [ -y datalinktype ] [ -z postrotate-command ] [ -Z user ]
            [ expression ]

네트워크 프로토콜(TCP/IP), 네트워크 인터페이스에 대한 기본적인 지식이 있어야 사용법을 이해할 수 있다.

tcpdump를 원하는 인터페이스나 포트를 지정하여 조건에 만족하는 패킷들을 출력해주는 명령어(프로그램)이다.


## `tcpdump` 명령어 옵션

자주 사용하는 옵션만 정리했다.

더 자세한 옵션은 [tcpdump(8) - Linux man page](https://linux.die.net/man/8/tcpdump)를 참고

| 옵션    | 설명                                                                                                                                                              |
| ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-A`    | Print each packet (minus its link level header) in ASCII.  Handy for capturing web pages.                                                                         |
| `-C`    | 캡쳐한 패킷을 저장할 때, `file_size`만큼의 크기로 갱신한다. `-w` flag로 지정된 파일명을 이용해 1부터 하나씩 늘어난다. file_size의 기본 크기는 MB(1,000,000 bytes) |
| `-D`    | tcpdump로 패킷을 캡쳐할 수 있는 네트워크 인터페이스 목록을 출력해준다. 이 옵션으로 출력된 인터페이스들을 `-i` 옵션을 통해 지정할 수 있다.                         |
| `-f`    | 외부 IPv4 주소를 되도록 숫자로 표현한다.                                                                                                                          |
| `-G`    | 캡쳐한 패킷을 저장할 때, `rotate_seconds`만큼의 주기로 갱신한다. `-w` flag로 지정된 파일명을 이용해 `strftime(3)`에 정의된 time format으로 지정할 수 있다.        |
| `-i`    | 캡쳐할 네트워크 인터페이스를 지정한다. 따로 지정하지 않으면 시스템 인터페이스 목록에서 가장 낮은 숫자를 골라 캡쳐한다.(loopback 제외)                             |
| `-nn`   | 대중적인 프로토콜과 포트번호를 이름으로 변환하지 않고 숫자 그대로 보여준다.                                                                                       |
| `-tttt` | 캡쳐한 각 패킷 행에 날짜 기본 형식으로 timestamp를 출력한다.                                                                                                      |
| `-vvv`  | 패킷의 모든 정보를 보여준다(TTL 포함)                                                                                                                             |
| `-w`    | 캡쳐한 패킷을 파일(`.pcap`)로 저장한다.                                                                                                                           |
| `-Z`    | 저장한 파일의 권한을 root 권한이 아닌 다른 User로 주고 싶을 때 사용한다.                                                                                          |


## `tcpdump` 조건식(expression)

옵션의 가장 마지막인 조건식(`[ expression ]`)은 어떤 패킷들을 dump할지 선택하는데 사용된다. 

조건식들은 몇 개의 primitives로 이루어져 있는데, [pcap-filter(7) - Linux man page](https://linux.die.net/man/7/pcap-filter)에 자세한 내용이 나와있다.

여기선 많이 사용하는 `host`, `port` 에 대해서만 설명하겠다.

| 옵션 | 설명                                                                          |
| ---- | ----------------------------------------------------------------------------- |
| host | dst(목적지), src(출발지)와 관계 없이 지정된 host 정보를 가진 패킷만 캡쳐한다. |
| port | dst(목적지), src(출발지)와 관계 없이 지정된 port 정보를 가진 패킷만 캡쳐한다. |
|      | dst, src를 따로 지정해줄 수도 있다.                                           |

## `tcpdump` 명령어 사용 예시

내가 이 명령어를 정리하는 계기가 된 예시

- ens3f1 인터페이스의 80번 포트에서 주고 받는 패킷들을 rest_dump.pcap 파일로 저장

```shell
(root)
tcpdump -nn -vvv -tttt -X -A -w rest_dump.pcap -i ens3f1 port 80 
```

## 저장한 `.pcap` 파일 보는 방법

- 와이어샤크(WireShark)를 지원하는 OS라면 와이어샤크를 설치 후 pcap 파일을 실행하면 볼 수 있다.
- CLI 환경에서는 아래 커맨드로 확인 가능하다.

```shell
tcpdump -qns 0 -A -r [pcap 파일 경로]
```

## 참고 자료
- [나비와꽃기린 - 리눅스 tcpdump 사용방법 및 명령어 정리 / tcpdump 파일로 저장하는 방법](https://mkil.tistory.com/482)
- [기억보단 기록을 - tcpdump 기본 사용법](https://jojoldu.tistory.com/316)
- [tcpdump(8) - Linux man page](https://linux.die.net/man/8/tcpdump)
- [pcap-filter(7) - Linux man page](https://linux.die.net/man/7/pcap-filter)
- [권용철 - TCPDUMP User Guide](http://coffeenix.net/doc/misc/tcpdump.html)
