# IMS 서비스

## 1. IMS?
IP Multimedia Service(IMS)

IP 기반 멀티미디어(IM) 서비스

이동가입자에게 하부에 IP 전송 프로토콜을 기반으로 하는 다양한 형태의 패킷 서비스들을 동시에 제공하는 것

이를 위해 3GPP에서 제시하고 있는 논리적인 ALL IP 망 구조는 IM CN 서브시스템을 포함하고 있는데, IM CN 서브시스템의 중요한 기능 요소로는 Call Session Control Function(CSCF)와 Home Subscriber
Server(HSS) 등이 있다. 

CSCF는 가입자가 위치하고 있는 망에 따라서 가입자의 세션과 서비스를 제어한다. 

HSS는 가입자의 마스터 데이터베이스로 기존의 3G HLR의 모든 기능과 User Mobility Server(UMS) 기능을 가진다. 

가입자가 기존의 음성, 영상 등의 실시간 서비스는 물론 파일전송, 이메일, 단문 메시지 등의 비 실시간 서비스를 동시에 사용할 수 있게 하거나 또는 이들 서비스를 이용한 새로운 서비스, 예를 들면 Video Phone, Instant Messaging, Emergency Call, Location 서비스, Presence 서비스 등을 이용할 수 있게 하는 것을 의미한다.

## 2. IMS 주요 구성 요소

1. CSCF(Call Sesstion Control Function)

    CSCF는 가입자가 위치하고 있는 망에 따라서 수행하는 기능이 다르므로 그 위치와 역할을 기준으로 해서 Proxy-CSCF, Interrogating CSCF, Serving CSCF로 논리적으로 구분할 수 있다.

   1. P-CSCF
        
        - 사용자(UE)가 IMS망에 접속하는 최초 Contact Point 역할
        - UE로부터 수신한 SIP Regi 요청 메시지를 홈 I-CSCF에게 전달
        - Emergency session을 검출하여 이를 처리할 S-CSCF를 선택
   
   2. I-CSCF

        - 하나의 사업자 망(홈 망)에 대한 Contact Point 역할
        - UE의 SIP Regi을 수행하는 S-CSCF의 주소를 HSS(UDM)로부터 수신한 후 실제 Regi을 담당할 S-CSCF를 할당
        - 타 망으로부터 수신한 SIP 메시지를 S-CSCF로 라우팅

   3. S-CSCF
   
        - UE의 세션을 제어하는 서버임을 HSS에 등록하고, 이후 UE의 가입자 정보를 받아 저장 (HSS로부터 사용자 프로파일을 다운로드하고 업로드)
        - Registered User에 대한 Session 제어 및 Session 상태 관리
        - UE Regi 시에 HSS로부터 수신한 인증정보를 가지고 인증을 수행

2. HSS(Home Subscriber Server)
   
    - 호/세션 제어를 위한 가입자의 모든 정보들에 대한 책임을 지고 있는 마스터 데이터베이스
    - 가입자 식별자, 가입자 보안 정보(인증), 가입자 위치 정보, 가입자 서비스 프로파일 정보 등

3. Mw Interface(CSCF간, SIP 프로토콜)
    
    - CSCF 사이의 인터페이스   

4. Cx Interface(CSCF와 HSS간, Diameter 프로토콜)

    - I-CSCF/S-CSCF 와 HSS 사이의 인터페이스
    - 가입자의 등록/등록 해제와 가입자의 IM 서브시스템 망의 접근 가능 여부의 권한 검증 및 위치 정보 관리를 위한 메시지(UAR/UAA, SAR/SAA, LIR/LIA, RTR/RTA)
    - 가입자의 프로파일 다운로드 및 가입자 정보 갱신을 위한 메시지(PPR/PPA, SAR/SAA)
    - 가입자 인증 수행을 위한 메시지(MAR/MAA)

### IMS Diameter 메시지
|Command Name|Src|Dest|Abbr|
|------------|---|----|----|
|User-Authorisation-Req|I-CSCF|HSS|UAR|
|User-Authorisation-Ans|HSS|I-CSCF|UAA|
|Server-Assigment-Req|S-CSCF|HSS|SAR|
|Server-Assigment-Ans|HSS|S-CSCF|SAA|
|Location-Info-Req|I-CSCF|HSS|LIR|
|Location-Info-Ans|HSS|I-CSCF|LIA|
|Multimdeia-Authentication-Req|S-CSCF|HSS|MAR|
|Multimdeia-Authentication-Ans|HSS|S-CSCF|MAA|
|Registration-Termination-Req|HSS|S-CSCF|RTR|
|Registration-Termination-Ans|S-CSCF|HSS|RTA|
|Push-Profile-Req|HSS|S-CSCF|PPR|
|Push-Profile-Ans|S-CSCF|HSS|PPA|

## 참고 자료
- [김창기, 신재승, 신연승, 조철회, [3GPP IP 멀티미디어 서비스를 위한 핵심망 구조 분석]](https://ettrends.etri.re.kr/ettrends/75/0905000333/)
- [이운영, KT 플랫폼연구소, [유무선통합 IMS플랫폼 기술]](../Moblie/documents/유무선통합%20ims플랫폼%20기술.pdf)