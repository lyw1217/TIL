# IMS 서비스 호처리(Sh)

##### _틀린 부분이 있을 수 있습니다. 지적 부탁드립니다._

### IMS Diameter 메시지

| Command Name                | Src | Dest | Abbr |
| --------------------------- | --- | ---- | ---- |
| **Sh Interface**            |     |      |      |
| User-Data-Req               | AS  | HSS  | UDR  |
| User-Data-Ans               | HSS | AS   | UDA  |
| Profile-Update-Req          | AS  | HSS  | PUR  |
| Profile-Update-Ans          | HSS | AS   | PUA  |
| Subscribe-Notifications-Req | AS  | HSS  | SNR  |
| Subscribe-Notifications-Ans | HSS | AS   | SNA  |
| Push-Notification-Req       | HSS | AS   | PNR  |
| Push-Notification-Ans       | AS  | HSS  | PNA  |

---
## 1. Sh Interface 절차의 기능 분류

1. 데이터 처리 절차(Data Handling Procedures)

   - HSS에서 AS(Application Server)로 데이터를 다운로드함 (Data read [`Sh-Pull`])
   - HSS의 데이터를 업데이트함 (Data Update [`Sh-Update`])

2. 구독/알림 절차(Subscription/Notification Procedures)

   - AS는 HSS로부터 데이터 변경에 대한 알림을 수신하기 위해 구독할 수 있음 (Subscription to notifications [`Sh-Subs-Notif`])
   - HSS는 AS가 이전에 구독한 데이터의 변경 사항을 AS에 알릴(notify) 수 있음 (Notifications [`Sh-Notif`])

---
## 2. 가입자 정보 질의(Sh / User-Data Req/Ans , UDR/UDA)

> Data read (Sh-Pull)

- AS에 의해 호출됨
- HSS에 있는 특정 유저의 데이터를 읽어들이는데 사용

### 2-1. Request 주요 AVPs

1. `User-Identity`
        
    IMS Public User Identity, Public Service Identity, MSISDN or External Identifier of the user for whom the data is required.

2. `Data-Reference`
    
    This information element indicates the reference to the requested information

3. `Service-Indication`

    IE that identifies, together with the User Identity included in the User-Identity AVP and Data-Reference, the set of service related transparent data that is being requested.

4. `Origin-Host`

    IE that identifies the AS originator of the request and that is used to check the AS permission list.

### 2-2. Response 주요 AVPs

1. `Result-Code / Experimental_Result`

    Result of the request. 

    Result-Code AVP shall be used for errors defined in the Diameter base protocol (see IETF RFC 6733 [44]).

    Experimental-Result AVP shall be used for Sh errors. This is a grouped AVP which contains the 3GPP Vendor ID in the Vendor-Id AVP, and the error code in the Experimental-Result-Code AVP.

2. `User-Data`

    Requested data. This information element shall be present if the requested data exists in the HSS and the AS has permissions to read it.

---
## 3. 가입자 정보 변경(Sh / Profile-Update Req/Ans , PUR/PUA)

> Data Update (Sh-Update)

- AS에 의해 호출됨
- AS가 각 IMS Public User Identity에 대해 HSS에 저장된 데이터를 업데이트할 수 있도록 함
- AS가 HSS에 저장된 Dynamic Service Activation Info를 업데이트할 수 있도록 함
- AS가 HSS에 저장된 Short Message Service Registration Info를 업데이트할 수 있도록 함
- AS가 HSS에 저장된 STN-SR을 업데이트할 수 있도록 함

### 3-1. Request 주요 AVPs

1. `User-Identity`

    IMS Public User Identity or Public Service Identity or MSISDN or External Identifier for which data is updated.

2. `Data-Reference`

    This information element includes the reference to the data on which updates are required (possible values of the Data Reference are defined in Table 7.6.1).

3. `User-Data`

    Updated data.

4. `Origin-Host`

    IE that identifies the AS originator of the request and that is used to check the AS permission list.

### 3-2. Response 주요 AVPs

1. `Result-Code / Experimental-Result`

    Result of the update of data in the HSS. 

    Result-Code AVP shall be used for errors defined in the Diameter base protocol (see IETF RFC 6733 [44]).

    Experimental-Result AVP shall be used for Sh errors. This is a grouped AVP which contains the 3GPP Vendor ID in the Vendor-Id AVP, and the error code in the Experimental-Result-Code AVP.

---
## 4. 가입자 정보 구독/해지(Sh / Subs-Notification Req/Ans , SNR/SNA)

> Subscription to notifications (Sh-Subs-Notif)

- AS에 의해 호출됨
- AS가 HSS로부터 특정 Public User Identity 또는 Public Service Identity가 업데이트 되었을 때 알림(Notify)을 받을 수 있도록 구독함
- Optionally to request the user data from the HSS in the same operation.

### 4-1. Request 주요 AVPs

1. `User-Identity`

    IMS Public User Identity or Public Service Identity or MSISDN or External Identifier for which notifications of data changes are requested. See section 7.1 for the content of this AVP.

2. `Data-Reference`

    This information element includes the reference to the data on which notifications of change are required (valid reference values are defined in 7. 6).

3. `Subs-Req-Type`

    This information element indicates the action requested on subscription to notifications.

4. `Send-Data-Indication`

    This information element requests that the data is sent in the response.

    Send Data Indication is not applicable to one time subscriptions to UE reachability for IP.

5. `Service-Indication`

    IE that identifies, together with the User Identity and Data-Reference, the set of service related transparent data for which notifications of changes are requested.

6. `Origin-Host`

    IE that identifies the AS originator of the request and that is used to check the AS permission list.

7. `Expiry-Time`

    This information element indicates the expiry time of the subscription to notifications in the HSS.

    Gives the absolute time requested at which the subscription expires.

8. `One-Time-Notification`

    This information element indicates if subscription shall be ended by the HSS after sending the first notification.

    This IE shall be present for UE reachability for IP.

### 4-2. Response 주요 AVPs

1. `Expiry-Time`

    Acknowledges the absolute time at which the subscription expires.

2. `User-Data`

    Current values of the data for which notifications have been requested.

    It should be present if the Send-Data-Indication AVP is set to value USER_DATA_REQUESTED.

---
## 5. 가입자 정보 변경 알림(Sh / Profile-Notification Req/Ans , PNR/PNA)

> Notifications (Sh-Notif)

- HSS에 의해 호출됨
- AS가 이전에 [Sh-Subs-Notif](#4-가입자-정보-구독해지sh--subs-notification-reqans--snrsna)를 사용하여 구독한 데이터의 변경 사항을 AS에 알림(Notify)

### 5-1. Request 주요 AVPs

1. `User-Identity`

    IMS Public User Identity or Public Service Identity or MSISDN or External Identifier for which data has changed.

    If the request refers to a Wildcarded PSI, the HSS may include any PSI matching the corresponding Wildcarded PSI in this information element. The AS shall find the corresponding Wildcarded PSI with this information.

    See section 7.1 for the content of this AVP.

2. `User-Data`

    Changed data.

### 5-2. Response 주요 AVPs

### *Sh interface AVP*에 대한 자세한 내용은 [여기](https://github.com/lyw1217/TIL/blob/main/Moblie/Sh_interface_AVPs.md)를 참고

---
## Message flows

![Figure B.1.1: Data Update, Registration, Notification Subscription](images/Data%20Update,%20Registration,%20Notification%20Subscription.png)

[3GPP TS 29.328, Figure B.1.1: Data Update, Registration, Notification Subscription]

1. User가 새로운 서비스에 가입한다. 운영자(operator)는 AS에서 서비스를 프로비저닝(provisions)한다. AS는 일부 서비스 데이터를 HSS에 저장한다.(Sh-Update, user identity, updated data)
2. HSS 는 데이터가 업데이트 되었음을 확인한다.
3. 잠시 후, User는 네트워크에 가입(Register)한다.
4. S-CSCF는 HSS에서 데이터를 다운로드한다(Cx Interface의 S-CSCF Registration Notification 절차 중). Filter Criteria는 AS가 end User가 가입되었음을 notify 받도록 지정한다.(?)
5. 200 OK
6. S-CSCF는 3rd Party 등록(Register) 메시지를 AS로 전송하여 USer가 등록되었음을 알린다.
7. 200 OK
8. AS는 Sh-Subs-Notif(user identity, requested data, service information and send data indication)를 통해 알림(notify)를 구독(subscribe)하고 HSS에서 서비스를 제공하는데 필요한 데이터를 다운로드한다.
9. HSS에서 구독 요청을 확인하고 AS로 데이터를 보낸다.
10. 어느 시기에, AS는 Sh-Update(user identity, updated data)를 통해 HSS에 있는 User의 서비스 데이터(e.g. repository data)를 업데이트 하기로 결정한다.
11. HSS가 서비스 데이터가 업데이트 되었음을 확인한다.
12. 어느 시기에, HSS에서 User 데이터가 업데이트된다. AS가 알림(Notify) 구독 중이라면(step 8 에서처럼), HSS는 Sh-Notif(user identity, updated data)를 통해 업데이트된 데이터를 AS로 요청합니다.
13. AS가 알림에 응답합니다.

## 참고 자료
- [김창기, 신재승, 신연승, 조철회, [3GPP IP 멀티미디어 서비스를 위한 핵심망 구조 분석]](https://ettrends.etri.re.kr/ettrends/75/0905000333/)
- [3GPP TS 29.328 "IP Multimedia (IM) Subsystem Sh interface; signalling flows and message contents".](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1706)
- [3GPP TS 29.329 "Sh Interface based on the Diameter protocol; protocol details](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1707)