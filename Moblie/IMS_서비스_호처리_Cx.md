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

## 1. 가입자 권한 검증(Cx / User-Authorization Req/Ans , UAR/UAA)

### 1.1. 주요 AVPs

## 2. 가입자 인증(Cx / Multimedia-Auth Req/Ans , MAR/MAA)

### 2.1. 주요 AVPs

## 3. 위치 등록 처리(Cx / Server-Assignment Req/Ans , SAR/SAA)

### 3.1. 주요 AVPs

## 4. 위치 삭제 처리(Cx / Registration-Termination Req/Ans , RTR/RTA)

### 4.1. 주요 AVPs

## 5. 가입자 정보 변경(Cx / Push-Profile Req/Ans , PPR/PPA )

### 5.1. 주요 AVPs

## 6. 가입자 위치 질의(Cx / Location-Information Req/Ans , LIR/LIA)

### 6.1. 주요 AVPs

### *Cx interface AVP*에 대한 자세한 내용은 [여기](https://github.com/lyw1217/TIL/blob/main/Moblie/Cx_interface_AVPs.md)를 참고

## S-CSCF Restore 관련 자료
- [Real Time Communication - "Rainy-day Scenarios – S-CSCF Restoration"](https://realtimecommunication.wordpress.com/2016/05/25/rainy-day-scenarios-s-cscf-restoration/)

## 참고 자료
- [김창기, 신재승, 신연승, 조철회, [3GPP IP 멀티미디어 서비스를 위한 핵심망 구조 분석]](https://ettrends.etri.re.kr/ettrends/75/0905000333/)
- [3GPP TS 29.228 "IP Multimedia (IM) Subsystem Cx and Dx Interfaces; Signalling flows and message contents"](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1681)
- [3GPP TS 29.229 "Cx and Dx Interfaces based on the Diameter protocol; protocol details"](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1682)