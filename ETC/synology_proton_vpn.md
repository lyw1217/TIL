# Synology NAS에서 Proton VPN(free) 적용하기 (+ DDNS)

시놀로지 NAS에서 Proton VPN Free 적용하고 DDNS 서비스도 활성화하는 방법.

VPN 서비스를 제공하는 곳은 많다.

그 중 무료임에도 사용량 제한이 없고 일본 서버가 있어 속도도 나쁘지 않은 Proton VPN Free를 NAS에 적용해보았다.

## 사용 환경

- Synology NAS DS720+
- DSM 7.1.1

## 주의사항

원격에서 작업하면 작업 도중 연결이 끊기고 재접속이 불가능할 수 있다.

> 로컬에서 작업하자.

## 1. Proton VPN Free 가입하기

[![register](images/synology_proton_vpn_1.png)](https://protonvpn.com/)

이미지를 클릭하면 proton vpn 홈페이지로 이동합니다.

Proton VPN 홈페이지에서 `Create free account` 를 클릭

![get vpn free](images/synology_proton_vpn_2.png)

그리고 `Get VPN Free` 클릭해서 계정을 생성합니다.


## 2. Proton VPN Free OpenVPN 설정 파일 다운로드 받기

계정을 생성한 후 로그인 하면 Dashboard로 들어갈 수 있습니다.

그러면 왼쪽 `Downloads` 탭에서 `OpenVPN configuration files`를 다운로드 받을 수 있습니다.

![configuration file](images/synology_proton_vpn_3.png)

- platform은 `Android`
- protocol은 `UDP`
- config file은 `Free server configs`

를 선택하고 아래 `Japan` 서버들 중 하나를 골라 오른쪽의 `Download` 버튼을 클릭해서 `.ovpn` 파일을 다운로드 받습니다.

## 3. OpenVPN username/password 가져오기

![id pw](images/synology_proton_vpn_4.png)

왼쪽 `Account` 탭의 `OpenVPN / IKEv2 username` 항목으로 가서 username과 password를 메모장에 복사해놓습니다.

## 4. DSM에서 VPN 프로파일 생성

> DSM - 제어판 - 네트워크 - 네트워크 인터페이스 - 생성 - VPN 프로파일 생성

![vpn profile](images/synology_proton_vpn_5.png)

![vpn profile](images/synology_proton_vpn_6.png)

![vpn profile](images/synology_proton_vpn_7.png)

DSM에 접속해서 VPN을 설정합니다.

`사용자 이름`과 `암호`는 [3번](#3-openvpn-usernamepassword-가져오기)에서 확인한 정보를 붙여넣으면 됩니다.

`프로파일 이름`, `사용자 이름`, `암호`, `.ovpn 파일 가져오기` 항목만 채워넣으면 되고 나머지 항목은 비워놓고 `다음` 을 누릅니다.

![vpn profile](images/synology_proton_vpn_8.png)

고급 설정에서는 이미지처럼 체크한 뒤 완료를 누릅니다.

## 4-1. 공유기 포트포워딩

![port fowarding](images/synology_proton_vpn_12.png)

Proton OpenVPN의 UDP는 `114`, TCP는 `443` port를 기본값으로 사용합니다.

([Proton VPN - What is the difference between UDP and TCP?](https://protonvpn.com/support/udp-tcp/)을 참고)

그렇기 때문에 공유기에서 NAS로 `114`번 포트를 포트포워딩 해줘야 VPN을 정상적으로 사용할 수 있습니다.

## 5. VPN 연결 및 서비스 순서 변경

![vpn profile](images/synology_proton_vpn_9.png)

네트워크 인터페이스에 VPN이 추가되었으면, 우클릭하여 `연결`을 클릭합니다.

(저는 이미 VPN을 설정한 상태여서 2개가 보입니다.)

![vpn profile](images/synology_proton_vpn_10.png)

![vpn profile](images/synology_proton_vpn_11.png)

그리고 `관리` - `서비스 순서`에서 `VPN`을 드래그하여 최상단으로 옮기고 확인을 누릅니다.

[주의 사항](#주의사항), 원격에서 작업중이라면 여기에서부터 접속이 되지 않을 수 있습니다. 로컬에서 작업하세요.

## 6. DNS 서버 수동 구성

제어판 - 네트워크 - 일반 탭에서 기본 게이트웨이가 `VPN`으로 변경되었는지 확인합니다.

그리고 `DNS 서버 수동 구성`을 체크한 뒤 `기본 DNS 서버`에 `10.1.0.1`을 입력하고 대체 DNS 서버는 비워둡니다.

[Synology DDNS를 외부 접속할 수 있게 설정하기](#7-synology-ddns를-외부-접속할-수-있게-설정하기)를 원한다면, 아래 `고급 설정`을 눌러 `다중 게이트웨이 활성화`를 체크합니다.

![dns server](images/synology_proton_vpn_13.png)

> 이제 NAS에 VPN이 적용되었습니다!

### 참고 링크

- [https://protonvpn.com/support/synology/](https://protonvpn.com/support/synology/)

## 7. Synology DDNS를 외부 접속할 수 있게 설정하기

> 여기서는 DDNS 및 인증서를 설치하는 방법은 설명하지 않겠습니다.

일반적으로 VPN을 사용하면 DDNS를 이용한 외부접속이 불가능합니다.

그렇지만 위 [6번](#6-dns-서버-수동-구성)에서 `다중 게이트웨이 활성화`에 체크했기 때문에 DDNS를 LAN과 연결(라우팅)시킬 수 있습니다.

![static routing](images/synology_proton_vpn_15.png)

제어판 - 네트워크 - 정적 라우팅 탭에서 `생성`을 누르고 아래 목록의 IP 주소를 모두 규칙에 추가합니다.

- 네트워크 대상 : 목록의 IP
- 넷마스크 : 255.255.255.255
- 게이트웨이 : LAN 게이트웨이의 IP주소 ([5번 항목](#5-vpn-연결-및-서비스-순서-변경)에서 확인할 수 있습니다.)
- 인터페이스 : LAN 포트

### IP 목록 (Synology DDNS)
- 44.239.77.234
- 44.240.201.191
- 44.236.224.47
- 52.10.31.158
- 44.241.103.184
- 44.239.15.20
- 159.89.129.146
- 142.93.81.166
- 138.68.28.244
- 165.227.63.200
- 104.248.79.120
- 159.89.142.52
- 159.65.77.153
- 206.189.214.49

이렇게 설정하면 Synology 서비스에서 사용하는 IP들은 VPN이 아닌 LAN으로 사용할 수 있게 됩니다.

![ddns](images/synology_proton_vpn_14.png)

제어판 - 외부 액세스 - DDNS 탭에서 `지금 업데이트` 버튼을 눌러 외부 주소를 업데이트 합니다.

> 이제 DNS가 전파될 때까지 잠시 기다렸다가 DDNS를 통해 NAS에 접속해봅시다!

### 참고 링크

- [https://github.com/twardakm/synology-ddns-vpn](https://github.com/twardakm/synology-ddns-vpn)