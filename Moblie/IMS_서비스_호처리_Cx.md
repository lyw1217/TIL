# IMS 서비스 호처리(Cx)

##### _틀린 부분이 있을 수 있습니다. 지적 부탁드립니다._

### IMS Diameter 메시지
| Command Name                  | Src    | Dest   | Abbr |
| ----------------------------- | ------ | ------ | ---- |
| **Cx Interface**              |        |        |      |
| User-Authorisation-Req        | I-CSCF | HSS    | UAR  |
| User-Authorisation-Ans        | HSS    | I-CSCF | UAA  |
| Server-Assigment-Req          | S-CSCF | HSS    | SAR  |
| Server-Assigment-Ans          | HSS    | S-CSCF | SAA  |
| Location-Info-Req             | I-CSCF | HSS    | LIR  |
| Location-Info-Ans             | HSS    | I-CSCF | LIA  |
| Multimdeia-Authentication-Req | S-CSCF | HSS    | MAR  |
| Multimdeia-Authentication-Ans | HSS    | S-CSCF | MAA  |
| Registration-Termination-Req  | HSS    | S-CSCF | RTR  |
| Registration-Termination-Ans  | S-CSCF | HSS    | RTA  |
| Push-Profile-Req              | HSS    | S-CSCF | PPR  |
| Push-Profile-Ans              | S-CSCF | HSS    | PPA  |

## 1. Cx Interface 절차의 기능 분류

1. 위치 관리 절차

    - 위치 등록 및 등록 취소 관련 작업
    - 위치 검색(retrieval) 작업

2. User Data Handling 절차

    - 등록 중에 사용자 정보를 다운로드하고 복구 메커니즘을 지원하는 작업
    - 사용자 데이터의 업데이트와 복구 메커니즘을 지원하는 작업

3. User 인증 절차

4. S-CSCF 서비스 interruption을 지원하는 IMS Restoration 절차

## 2. 가입자 권한 검증(Cx / User-Authorization Req/Ans , UAR/UAA)

> User registration status query

- SIP registrations 중에 I-CSCF 와 HSS 사이에서 사용되는 절차
- Cx-Query 및 Cx-Select-Pull
- distinct Public User Identity의 등록을 인증하려면, multimedia subsystem 접근 권한 및 로밍 계약을 확인
- 메시지의 distinct Public User Identity가 메시지에서 보낸 Private User Identity와 연관되는지 여부를 확인하기 위해서 첫 번째 보안 검사를 수행
- distinct Public User Identity가 등록 또는 등록 취소된 S-CSCF 또는 S-CSCF가 지원해야하는 capability들의 목록을 얻음

### 2.1. Request 주요 AVPs

1. `Public-Identity`

        - Public User Identity to be registered

2. `Visited-Network-Identifier`

        - Identifier that allows the home network to identify the visited network

3. `User-Authorization-Type`

        - Type of authorization requested by the I-CSCF.

4. `User-Name`

        - Private User Identity


### 2.2. Response 주요 AVPs

1. `Server-Capabilities`

        - Required capabilities of the S-CSCF to be assigned to the IMS Subscription. 

2. `Server-Name`

        - Name of the assigned S-CSCF.


## 3. 가입자 인증(Cx / Multimedia-Auth Req/Ans , MAR/MAA)

> Authentication procedures

- End User와 Home IMS Network 간의 인증을 위한 정보를 교환하기 위해 S-CSCF 와 HSS 사이에서 사용되는 절차
- Cx-AV-Req 및 Cx-AV-Req-Resp
- HSS 에서 인증 벡터(authentication vectors)를 검색(retrieve)
- 이 기능을 지원하는 인증 방식(예, IMS-AKA)을 위해 UE와 HSS의 sequence numbers 간의 동기화 실패를 해결
- NASS-level의 인증 결과를 IMS level로 승격(promote)합니다.
- HSS에서 GPRS-IMS-Bundled Authentication(GIBA)에 대한 IP 주소 보안 바인딩 정보를 검색합니다.

<details>
<summary>접기/펼치기</summary>

This procedure is used between the S-CSCF and the HSS to exchange information to support the authentication between the end user and the home IMS network. 

The procedure is invoked by the S-CSCF, corresponds to the combination of the operations Cx-AV-Req and Cx-AV-Req-Resp (see  TS 33.203 [3]) and is used:

-	To retrieve authentication vectors from the HSS.

-	To resolve synchronization failures between the sequence numbers in the UE and the HSS for authentication schemes that support this capability (e.g. IMS-AKA).

-	To promote the result of the NASS-level authentication to the IMS level.

-	To retrieve the IP-address secure binding information for GPRS-IMS-Bundled Authentication (GIBA) from the HSS.

This procedure is mapped to the commands Multimedia-Auth-Request/Answer in the Diameter application specified in  TS 29.229 [5]. Tables 6.3.1 through 6.3.7 detail the involved information elements.
</details><br>

### 3.1. Request 주요 AVPs

1. `Public-Identity`

        - This information element contains the Distinct Public User Identity of the user

2. `User-Name`

        - This information element contains the Private User Identity

3. `SIP-Number-Auth-Items`

        - This information element indicates the number of authentication vectors requested. Certain authentication schemes do not support more than one set of authentication vectors (e.g. SIP Digest, GIBA).

4. `SIP-Auth-Data-Item`

   1. `SIP-Authentication-Scheme`

        - This information element indicates the authentication scheme.
        - See 3GPP TS 29.229 [5] for a list of values 


   2. `SIP-Authentication-Context`

        - This information element shall contain authentication-related information relevant for performing the authentication.
        - It shall be absent for IMS-AKA authentication schemes.


   1. `SIP-Authorization`

        - This information element shall only be present for a request due to an IMS-AKA synchronization failure.
        - If present, only IMS-AKA authentication schemes are allowed.


5. `Server-Name`

        - This information element contains the name (SIP URL) of the S-CSCF.

### 3.2. Response 주요 AVPs

1. `Public-Identity`

        - Public User Identity. It shall be present when the result is DIAMETER_SUCCESS.

2. `User-Name`

        - Private User Identity. It shall be present when the result is DIAMETER_SUCCESS.

3. `SIP-Number-Auth-Items`

        - This information element indicates the number of authentication vectors delivered in the Authentication Data information element.
        - It shall be present when the result is DIAMETER_SUCCESS.
        - For SIP Digest, NASS Bundled authentication and GIBA this AVP shall be set to a value of 1.


4. `SIP-Auth-Data-Item`

        - If the SIP-Number-Auth-Items AVP is equal to zero or it is not present, then this information element shall not be present.

   1. `SIP-Item-Number`

           - This information element shall only be present for IMS-AKA authentication schemes.
           - This information element shall be present when there are multiple occurrences of the Authentication Data information element in the Authentication Request Response, and the order in which they should be processed is significant.
           - In this scenario, Authentication Data information elements with a low Item Number information element value should be processed before Authentication Data information elements with a high Item Number information element value.

   2. `SIP-Authentication-Scheme`

           - This information element indicates the authentication scheme. 

   3. `SIP-Authenticate`

            - This information element shall only be present for IMS-AKA authentication schemes.

   4. `SIP-Authorization`
  
            - This information element shall only be present for IMS-AKA authentication schemes.
  
   5. `Confidentiality-Key`
 
            - This information element shall be present for IMS AKA authentication schemes.
            - It shall contain the confidentiality key. 

   6. `Integrity-Key`

            - This information element shall only be present for IMS-AKA authentication schemes.
            - This information element shall contain the integrity key. 

## 4. 위치 등록 처리(Cx / Server-Assignment Req/Ans , SAR/SAA)

> S-CSCF registration/deregistration notification

- S-CSCF 와 HSS 사이에서 사용되는 절차
- Cx-Put 및 Cx-Pull
- S-CSCF에 Public Identity를 지정하거나(assign), 하나 이상의 Public Identities에 지정된 S-CSCF의 이름을 지움(clear)
- HSS에서 S-CSCF 관련(relevant) 사용자 정보를 다운로드
- HSS에서 S-CSCF Restoration Information을 백업 및 검색(retrieve), TS 23.380 참고
- HSS에게 P-CSCF Restoration Indication을 제공하고 P-CSCF Restoration 매커니즘을 촉발(trigger)시킴

### 4.1. Request 주요 AVPs

### 4.2. Response 주요 AVPs

## 5. 위치 삭제 처리(Cx / Registration-Termination Req/Ans , RTR/RTA)

> 

### 5.1. Request 주요 AVPs

### 5.2. Response 주요 AVPs

## 6. 가입자 정보 변경(Cx / Push-Profile Req/Ans , PPR/PPA )

> 

### 6.1. Request 주요 AVPs

### 6.2. Response 주요 AVPs

## 7. 가입자 위치 질의(Cx / Location-Information Req/Ans , LIR/LIA)

> 

### 7.1. Request 주요 AVPs

### 7.2. Response 주요 AVPs

### *Cx interface AVP*에 대한 자세한 내용은 [여기](https://github.com/lyw1217/TIL/blob/main/Moblie/Cx_interface_AVPs.md)를 참고

## Registration Flow
23228 5.2.2 Registration Flows 참고

## S-CSCF Restoration 관련 자료
- [Real Time Communication - "Rainy-day Scenarios – S-CSCF Restoration"](https://realtimecommunication.wordpress.com/2016/05/25/rainy-day-scenarios-s-cscf-restoration/)

## 참고 자료
- [김창기, 신재승, 신연승, 조철회, [3GPP IP 멀티미디어 서비스를 위한 핵심망 구조 분석]](https://ettrends.etri.re.kr/ettrends/75/0905000333/)
- [3GPP TS 29.228 "IP Multimedia (IM) Subsystem Cx and Dx Interfaces; Signalling flows and message contents"](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1681)
- [3GPP TS 29.229 "Cx and Dx Interfaces based on the Diameter protocol; protocol details"](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1682)