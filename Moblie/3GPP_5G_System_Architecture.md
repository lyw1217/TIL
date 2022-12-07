# 3GPP 5G System Architecture

## Network Funtions (NFs) and entities

5G 시스템 아키텍쳐의 network funtion들과 entity들을 요약하면 아래와 같다.

| Entities                                      | Description |
| --------------------------------------------- | ----------- |
| UE (User Equipment)                           | 이동통신망에서 end-user가 직접 통신하는 모든 device들, 즉, 단말을 의미 ([참고](https://github.com/lyw1217/TIL/blob/main/Moblie/User_Equipment.md))            |
| RAN (Radio Access Network)                    | 이동통신망의 무선 단말과 접속을 이루는 무선영역을 담당하는 망([참고](http://www.ktword.co.kr/test/view/view.php?m_temp1=4252)), 즉, 기지국을 의미          |
| AMF (Access and Mobility Management Function) | 단말의 이동성 관리 역할            |
| SMF (Session Management Function)             | 단말의 데이터 전송을 위한 세션 관리 역할           |
| UPF (User Plane Function)                     | Data Network와 연결되어 데이터 패킷의 전송을 담당            |
| PCF (Policy Control Function)                 | 사업자 과금이나 제어 정책에 대한 정보 관리            |
| NRF (Network Repository Function)             | NF의 서비스 상태 모니터링 및 연동 정보 관리            |
| UDM (Unified Data Management)                 | 단말의 가입자 정보 관리            |
| UDR (Unified Data Repository)                 | 가입자 관련 데이터 저장 및 조회 기능            |
| AUSF (Authentication Server Function)         | 단말의 인증 담당            |
| NSSF (Network Slice Selection Function)       | 네트워크 슬라이스 관련 정보 저장 관리            |


<details>
<summary>접기/펼치기</summary>
- The 5G System architecture consists of the following network functions (NF):
    -	Authentication Server Function (AUSF).
    -	Access and Mobility Management Function (AMF).
    -	Data Network (DN), e.g. operator services, Internet access or 3rd party services.
    -	Unstructured Data Storage Function (UDSF).
    -	Network Exposure Function (NEF).
    -	Network Repository Function (NRF).
    -	Network Slice Specific Authentication and Authorization Function (NSSAAF).
    -	Network Slice Selection Function (NSSF).
    -	Policy Control Function (PCF).
    -	Session Management Function (SMF).
    -	Unified Data Management (UDM).
    -	Unified Data Repository (UDR).
    -	User Plane Function (UPF).
    -	UE radio Capability Management Function (UCMF).
    -	Application Function (AF).
    -	User Equipment (UE).
    -	(Radio) Access Network ((R)AN).
    -	5G-Equipment Identity Register (5G-EIR).
    -	Network Data Analytics Function (NWDAF).
    -	CHarging Function (CHF).

- The 5G System architecture also comprises the following network entities:
    -	Service Communication Proxy (SCP).
    -	Security Edge Protection Proxy (SEPP).
    -	Non-3GPP InterWorking Function (N3IWF).
    -	Trusted Non-3GPP Gateway Function (TNGF).
    -	Wireline Access Gateway Function (W-AGF).
    -	Trusted WLAN Interworking Function (TWIF).
</details><br>

## Non-roaming reference architecture


![Figure 4.2.3-1: 5G System architecture](./images/Figure_4.2.3-1_5G_System_architecture.png)

Figure 4.2.3-1: 5G System architecture



## 참고 자료
- [3GPP TS 23.501 V16.6.0](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3144)
- [Seog-Gyu Kim - [Efficient Congestion Control for Interworking between 5G-System and LTE]](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwjqz86dyInyAhWIOpQKHU-VDesQFjACegQIBxAD&url=http%3A%2F%2Fkoreascience.or.kr%2Farticle%2FJAKO201910537995269.pdf&usg=AOvVaw28pgjNGzzMydWj8uflVBiy)
- [5G Standalone Access Registration - UE registers with the 5G Core Network (5GC) via the 5G-RAN](https://medium.com/5g-nr/5g-standalone-access-registration-fe80aa28d723)
- [5G standalone access registration signaling flow](https://www.eventhelix.com/5G/standalone-access-registration/5g-standalone-access-registration.pdf)
- [5G-NR Standalone Access Registration](https://www.eventhelix.com/5G/standalone-access-registration/)
- [5G-NR Non-standalone access call flows](https://www.eventhelix.com/5G/non-standalone-access-en-dc/)
- [Samsung - 5G 국제 표준의 이해](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwi51aLL3onyAhUJQd4KHWRTAVkQFjAAegQIBxAD&url=https%3A%2F%2Fimages.samsung.com%2Fis%2Fcontent%2Fsamsung%2Fp5%2Fglobal%2Fbusiness%2Fnetworks%2Finsights%2Fwhite-paper%2Fwho-and-how_making-5g-nr-standards%2Fwho-and-how_making-5g-nr-standards_KR.pdf&usg=AOvVaw2t0Vf77taAfqBn61s_dJHg)
- [한국정보통신기술협회 - 5G 네트워크/시스템 구조 기술](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwi51aLL3onyAhUJQd4KHWRTAVkQFjADegQIAxAD&url=https%3A%2F%2Fwww.tta.or.kr%2Fdata%2FandroReport%2FttaJnal%2F175-2-3-4.pdf&usg=AOvVaw08kotd-Gs93YrK12P6UiQ9)
- [netmanias, 코어 네트워크 진화 - 5G 서비스 기반 구조](https://www.netmanias.com/ko/post/blog/13206/5g/core-network-evolution-5g-service-based-arhcitecture)
- [Sense Wide - [5G] 5G 네트워크 구조 정리 (5G RAN과 5G Core)](https://jb-story.tistory.com/346)