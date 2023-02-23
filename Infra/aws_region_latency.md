# Bash Script로 AWS 리전별 응답 시간 체크하기

AWS는 세계 각지 여러 곳에서 호스팅되고 있다. 세계 곳곳에 데이터 센터를 짓고 서비스를 제공하는 것인데 각각의 데이터 센터를 가용 영역이라고 하고, 2개 이상의 가용 영역을 묶어 리전이라고 한다.

리전의 실제 물리적인 위치가 세계 곳곳에 퍼져있다보니 AWS의 서비스를 사용하는 내 위치와 리전간의 거리가 멀수록 응답 시간 또한 늦어지게 된다.

그렇다면 AWS의 수많은 리전들 중 어떤 리전이 가장 나랑 빠르게 통신할 수 있을까?

이를 확인하기 위한 AWS 리전별 ping 테스트를 해주는 웹사이트들이 많다.

- [https://cloudpingtest.com/aws](https://cloudpingtest.com/aws)
- [https://www.cloudping.cloud/aws](https://www.cloudping.cloud/aws)
- [https://www.cloudping.info/](https://www.cloudping.info/)

난 이걸 쉘 스크립트로도 제작해보려고 한다.

## 1. AWS 서비스별 Endpoints 확인

AWS는 여러 서비스를 제공하고, 그 서비스마다 실제 사용자가 접근할 수 있는 endpoint들이 있다. 그리고 그 endpoint들은 아래 링크에서 확인할 수 있다.

- [https://docs.aws.amazon.com/general/latest/gr/aws-service-information.html](https://docs.aws.amazon.com/general/latest/gr/aws-service-information.html)

나는 EC2의 endpoints를 통해 응답 시간을 체크할 것이기 때문에 EC2의 endpoints만 발췌했다.

### Amazon EC2 endpoints

[https://docs.aws.amazon.com/general/latest/gr/ec2-service.html](https://docs.aws.amazon.com/general/latest/gr/ec2-service.html)

| Region Name               | Region         | Endpoint                         | Protocol       |
| ------------------------- | -------------- | -------------------------------- | -------------- |
| US East (Ohio)            | us-east-2      | ec2.us-east-2.amazonaws.com      | HTTP and HTTPS |
| US East (N. Virginia)     | us-east-1      | ec2.us-east-1.amazonaws.com      | HTTP and HTTPS |
| US West (N. California)   | us-west-1      | ec2.us-west-1.amazonaws.com      | HTTP and HTTPS |
| US West (Oregon)          | us-west-2      | ec2.us-west-2.amazonaws.com      | HTTP and HTTPS |
| Africa (Cape Town)        | af-south-1     | ec2.af-south-1.amazonaws.com     | HTTP and HTTPS |
| Asia Pacific (Hong Kong)  | ap-east-1      | ec2.ap-east-1.amazonaws.com      | HTTP and HTTPS |
| Asia Pacific (Hyderabad)  | ap-south-2     | ec2.ap-south-2.amazonaws.com     | HTTP and HTTPS |
| Asia Pacific (Jakarta)    | ap-southeast-3 | ec2.ap-southeast-3.amazonaws.com | HTTP and HTTPS |
| Asia Pacific (Melbourne)  | ap-southeast-4 | ec2.ap-southeast-4.amazonaws.com | HTTP and HTTPS |
| Asia Pacific (Mumbai)     | ap-south-1     | ec2.ap-south-1.amazonaws.com     | HTTP and HTTPS |
| Asia Pacific (Osaka)      | ap-northeast-3 | ec2.ap-northeast-3.amazonaws.com | HTTP and HTTPS |
| Asia Pacific (Seoul)      | ap-northeast-2 | ec2.ap-northeast-2.amazonaws.com | HTTP and HTTPS |
| Asia Pacific (Singapore)  | ap-southeast-1 | ec2.ap-southeast-1.amazonaws.com | HTTP and HTTPS |
| Asia Pacific (Sydney)     | ap-southeast-2 | ec2.ap-southeast-2.amazonaws.com | HTTP and HTTPS |
| Asia Pacific (Tokyo)      | ap-northeast-1 | ec2.ap-northeast-1.amazonaws.com | HTTP and HTTPS |
| Canada (Central)          | ca-central-1   | ec2.ca-central-1.amazonaws.com   | HTTP and HTTPS |
| Europe (Frankfurt)        | eu-central-1   | ec2.eu-central-1.amazonaws.com   | HTTP and HTTPS |
| Europe (Ireland)          | eu-west-1      | ec2.eu-west-1.amazonaws.com      | HTTP and HTTPS |
| Europe (London)           | eu-west-2      | ec2.eu-west-2.amazonaws.com      | HTTP and HTTPS |
| Europe (Milan)            | eu-south-1     | ec2.eu-south-1.amazonaws.com     | HTTP and HTTPS |
| Europe (Paris)            | eu-west-3      | ec2.eu-west-3.amazonaws.com      | HTTP and HTTPS |
| Europe (Spain)            | eu-south-2     | ec2.eu-south-2.amazonaws.com     | HTTP and HTTPS |
| Europe (Stockholm)        | eu-north-1     | ec2.eu-north-1.amazonaws.com     | HTTP and HTTPS |
| Europe (Zurich)           | eu-central-2   | ec2.eu-central-2.amazonaws.com   | HTTP and HTTPS |
| Middle East (Bahrain)     | me-south-1     | ec2.me-south-1.amazonaws.com     | HTTP and HTTPS |
| Middle East (UAE)         | me-central-1   | ec2.me-central-1.amazonaws.com   | HTTP and HTTPS |
| South America (São Paulo) | sa-east-1      | ec2.sa-east-1.amazonaws.com      | HTTP and HTTPS |
| AWS GovCloud (US-East)    | us-gov-east-1  | ec2.us-gov-east-1.amazonaws.com  | HTTPS          |
| AWS GovCloud (US-West)    | us-gov-west-1  | ec2.us-gov-west-1.amazonaws.com  | HTTPS          |


## 2. 응답 시간 체크 방법(curl 이용)

endpoint의 `/ping` 경로에 HTTP 또는 HTTPS GET 요청을 하면 현재 endpoint의 상태를 응답받을 수 있는데, 이 것을 이용해서 서버 상태와 응답 시간을 확인하려고 한다.

예시 : [https://ec2.us-east-2.amazonaws.com/ping](https://ec2.us-east-2.amazonaws.com/ping)

`curl`은 여러 프로토콜로 특정 URL에 데이터를 송수신할 수 있는 command-line 툴이다. 

- [https://github.com/curl/curl/](https://github.com/curl/curl/)

`curl`의 수많은 기능 중 `-w, --write-out <format>` 옵션은 `curl`을 통한 송수신 과정에서 발생하는 여러 정보를 출력할 수 있게 해준다.

여기엔 여러가지 변수들을 사용할 수 있는데, 아래와 같이 `시간`과 관련된 변수들도 있다.

| 변수명             | 설명          |
| ------------------ | -------------|
| time_appconnect    | The time, in seconds, it took from the start until the SSL/SSH/etc connect/handshake to the remote host was completed. |
| time_connect       | The time, in seconds, it took from the start until the TCP connect to the remote host (or proxy) was completed. |
| time_namelookup    | The time, in seconds, it took from the start until the name resolving was completed. |
| time_pretransfer   | The time, in seconds, it took from the start until the file transfer was just about to begin. This includes all pre-transfer commands and negotiations that are specific to the particular protocol(s) involved. |
| time_redirect      | The time, in seconds, it took for all redirection steps including name lookup, connect, pretransfer and transfer before the final transaction was started. time_redirect shows the complete execution time for multiple redirections. |
| time_starttransfer | The time, in seconds, it took from the start until the first byte was just about to be transferred. This includes time_pretransfer and also the time the server needed to calculate the result. |
| __time_total__         | __The total time, in seconds, that the full operation lasted.__  |

- [curl man page](https://curl.se/docs/manpage.html)

`time_total` 이라는 변수는 전체 과정이 지난 뒤의 시간을 초(seconds)단위로 나타내준다. 이를 이용해서 응답 시간을 확인해보자.

> 보통 ICMP를 이용한 `ping`을 사용하여 네트워크 상태를 파악하지만, 나는 리전별 응답시간을 비교하는 것이 목적이기 때문에 `ping`을 사용하지 않더라도 내가 원하는 결과값을 얻어낼 수 있을 것이다.

그런데 쉘 스크립트를 작성하다보니 `ping`으로도 하는게 좋을 것 같아서 옵션을 주어 `ping`으로도 확인이 가능하도록 했다.

## 3. 쉘 스크립트 작성

[여기](https://github.com/lyw1217/TIL/blob/main/Infra/src/check_latency_of_aws_regions.sh) 에 스크립트 전체가 올라가있다.

`ping` / `curl` 모두 이용하여 latency 및 health 상태를 확인하며, 실행 시 옵션을 주어 선택할 수 있다.

스크립트와 동일 경로에 `health.txt`, `latency.txt` 파일이 생성되며, 데이터 정렬 및 출력에 활용한다.

### 스크립트 작성하면서 고민한 부분들

- 모든 endpoints에 순서대로 `curl`/`ping` 요청을 보내면 시간이 너무 오래 걸려서 백그라운드로 동작시켰다.
  - `&`를 이용하면 서브쉘을 생성해서 백그라운드로 동작한다.
  - 서브쉘은 부모쉘에 영향을 줄 수 없기 때문에 백그라운드로 얻어온 데이터를 활용하기 어려웠다.
  - 그래서 가져온 데이터를 파일로 저장하고 부모쉘에서 다시 그 파일을 읽어들이는 방식을 사용했다.
- 결과를 출력할 때 응답시간 순으로 정렬하고 싶었는데 `associative array`는 정렬하는 방법이 마땅치 않았다.
  - bash에서, `associative array`(dictionary, map)는 순서를 보장하지 않는다.
  - 참고 : [https://stackoverflow.com/questions/29161323/how-to-keep-associative-array-order](https://stackoverflow.com/questions/29161323/how-to-keep-associative-array-order)
  - 그래서 결과를 구분자($sep)로 구분하여 파일로 저장하고 `sort` 명령어를 이용하여 파일을 정렬했다
- 터미널 너비에 상관없이 좌우 꽉차게 출력하고 싶다.
  - `tput cols`를 이용해서 터미널의 열을 가져왔다.
  - `\033[${col}G`는 ANSI Escape 코드로, 터미널에서 커서를 이동시키는 데 사용된다. ("Cursor Horizontal Absolute" (CHA))
    - 참고 : [https://ko.wikipedia.org/wiki/ANSI_%EC%9D%B4%EC%8A%A4%EC%BC%80%EC%9D%B4%ED%94%84_%EC%BD%94%EB%93%9C](https://ko.wikipedia.org/wiki/ANSI_%EC%9D%B4%EC%8A%A4%EC%BC%80%EC%9D%B4%ED%94%84_%EC%BD%94%EB%93%9C)
    - `${col}`열로 커서를 이동해준다.
  - 이를 이용해서 터미널 크기에 상관없이 좌우 꽉채워서 출력할 수 있었다.

## 4. 출력 확인 및 다른 사이트와 비교

### - `curl`을 이용한 latency 확인

![curl](images/latency_curl.jpg)

### - `ping`을 이용한 latency 확인

![ping](images/latency_ping.jpg)

### - [https://cloudpingtest.com/aws](https://cloudpingtest.com/aws) 에서 확인

여러 사이트들 중 이 곳이 HTML 코드 상 aws ec2에 요청하는 것 같았다.

![site](images/latency_site.jpg)

측정된 값은 다를지라도 latency 순으로 정렬하면 정렬된 순서는 얼추 비슷했다.

지역적인 거리 뿐만 아니라 네트워크 상태에 따라 latency가 다르게 측정될 수 있는 것을 감안하면 나름 만족스럽게 만들어진 것 같다.