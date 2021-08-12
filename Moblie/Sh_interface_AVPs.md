# Sh Interface AVPs

##### _틀린 부분이 있을 수 있습니다. 지적 부탁드립니다._

Sh interface의 AVPs 중 일부를 발췌해서 정리

## User-Identity AVP

>type : Grouped

`IMS Public User Identity`, `Public Service Identity`, `MSISDN` 또는 `External Identifier` 중 하나가 포함된다.
<details>
<summary>접기/펼치기</summary>

- 29.329

The User-Identity AVP is of type Grouped. This AVP contains either a Public- Identity AVP or an MSISDN AVP or an External-Identifier AVP.

- 29.328

| Information element name                           | Mapping to Diameter AVP | Description                                                                                                                                                                                                                                                                                        |
| -------------------------------------------------- | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| IMS Public User Identity / Public Service Identity | Public-Identity         | IMS Public User Identity or Public Service Identity for which data is required. If the MSISDNand External Identifier are is not included in the User-Identity AVP, the Public-Identity AVP shall be included in Sh messages only for allowed Data References as described in Table 7.6.1.          |
| MSISDN                                             | MSISDN                  | MSISDN for which data is required. If the Public-Identity AVP and External Identifier are not included in the User-Identity AVP, the MSISDN AVP shall be included in the Sh-Pull or Sh-Subs-Notif or Sh-Update messages only for allowed Data References as described in Table 7.6.1.              |
| External Identifier                                | External-Identifier     | External Identifier for which data is required. If the Public-Identity AVP and MSISDN are not included in the User-Identity AVP, the External Identifier AVP shall be included in the Sh-Pull or Sh-Subs-Notif or Sh-Update messages only for allowed Data References as described in Table 7.6.1. |
</details><br>

## Identity-Set AVP

>type : Enumerated

요청된 IMS Public Identity의 집합을 나타낸다.

[Data-Reference AVP](#data-accessible-via-sh-interface)의 `IMSPublicIdentity` 항목을 참고

| Type                  | Value | Description |
| --------------------- | ----- | ----------- |
| ALL_IDENTITIES        | 0     |             |
| REGISTERED_IDENTITIES | 1     |             |
| IMPLICIT_IDENTITIES   | 2     |             |
| ALIAS_IDENTITIES      | 3     |             |

<details>
<summary>접기/펼치기</summary>

The Identity-Set AVP is of type Enumerated and indicates the requested set of IMS Public Identities.  The following values are defined:
    ALL_IDENTITIES (0)
    REGISTERED_IDENTITIES (1)
    IMPLICIT_IDENTITIES (2)
    ALIAS_IDENTITIES (3)
</details><br>


## Service-Indication AVP

>type : OctetString

AS의 서비스 또는 서비스 집합과 HSS의 관련 repository data를 식별하게 해주는 Service Indication.

transparent data와 연관된 서비스의 집합을 구분할 수 있게 해주는 식별자

<details>
<summary>접기/펼치기</summary>

- 29.329

The Service-Indication AVP is of type OctetString. This AVP contains the Service Indication that identifies a service or a set of services in an AS and the related repository data in the HSS. Standardized values of Service-Indication identifying a standardized service or  set of services in the AS and standardized format of the related repository data are defined in 3GPP TS 29.364 [10].


- 29.328

Identifier of one set of service related transparent data, which is stored in an HSS in an operator network per Public Identity.

The HSS shall allocate memory space to implement a data repository to store transparent data per IMS Public User Identity or Public Service Identity and value of Service Indication with a Sequence Number for verification.

For Public Service Identities matching a Wildcarded Public Service Identity, the repository data shall be stored per Wildcarded Public Service Identity and not for each specific Public Service Identity.
</details><br>

## Data-Reference AVP

>type : Enumerated

`UDR` 및 `SNR` 메시지에서 요청한 가입자 데이터의 유형을 나타낸다.

<details>
<summary>접기/펼치기</summary>

The Data-Reference AVP is of type Enumerated, and indicates the type of the requested user data in the operation UDR and SNR. Its exact values and meaning is defined in 3GPP TS 29.328 [1]. The following values are defined (more details are given in 3GPP TS 29.328 [1]):

RepositoryData (0)   
IMSPublicIdentity (10)   
IMSUserState (11)   
S-CSCFName (12)   
InitialFilterCriteria (13)   
This value is used to request initial filter criteria relevant to the requesting AS   
LocationInformation (14)   
UserState (15)   
ChargingInformation (16)    
MSISDN (17)   
PSIActivation (18)   
DSAI (19)   
ServiceLevelTraceInfo (21)   
IPAddressSecureBindingInformation (22)    
ServicePriorityLevel (23)   
SMSRegistrationInfo (24)   
UEReachabilityForIP (25)   
TADSinformation (26)    
STN-SR (27)   
UE-SRVCC-Capability (28)   
ExtendedPriority (29)   
CSRN (30)    
ReferenceLocationInformation (31)    
IMSI (32)   
IMSPrivateUserIdentity (33)   

</details><br>

## Data accessible via Sh interface

Data Reference 중 일부만 발췌

| Data Ref. | XML tag                               | Defined in | Access key                                                                                                                                                                                                                                                                          | Operations                                                |
| --------- | ------------------------------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- |
| 0         | RepositoryData                        | 7.6.1      | Data Reference<br>+ ( IMS Public User Identity OR Public Service Identity )<br>+ Service Indication                                                                                                                                                                                 | Sh-Pull<br>Sh-Update<br>Sh-Subs-Notif<br>(Note 1, Note 3) |
| 10        | IMSPublicIdentity                     | 7.6.2      | Data Reference<br>+ ( IMS Public User Identiy OR Public Service Identity OR MSISDN OR External Identifier )<br>+ [ Requested Identity Set ]                                                                                                                                         | Sh-Pull<br>Sh-Subs-Notif<br>                              |
| 11        | IMSUserState                          | 7.6.3      | Data Reference<br>+ IMS Public User Identity                                                                                                                                                                                                                                        | Sh-Pull<br>Sh-Subs-Notif<br>                              |
| 12        | S-CSCFName                            | 7.6.4      | Data Reference<br>+ ( IMS Public User Identity OR Public Service Identity )                                                                                                                                                                                                         | Sh-Pull<br>Sh-Subs-Notif<br>(Note 1)<br>                  |
| 13        | InitialFilterCriteria                 | 7.6.5      | Data Reference<br>+ ( IMS Public User Identity OR Public Service Identity )<br>+ Application Server Name                                                                                                                                                                            | Sh-Pull<br>Sh-Subs-Notif<br>(Note 1)<br>                  |
| 14        | LocationInformation                   | 7.6.6      | Data Reference<br>+ ( IMS Public User Identity OR MSISDN OR External Identifier )<br>+ [ Private Identity ]<br>+ Requested Domain<br>+ Current Location<br>+ [ Serving Node Indication ]<br>+ [ Requested Nodes ] <br>+ [ Local Time Zone Indication ] <br>+ [ RAT-Type Requested ] | Sh-Pull<br>(Note 5)<br>(Note 6)<br>(Note 7)<br>           |
| 15        | UserState                             | 7.6.7      | Data Reference<br>+ ( IMS Public User Identity OR MSISDN OR External Identifier )<br>+ [ Private Identity ] <br>+ Requested Domain<br>+ [ Requested Nodes ]                                                                                                                         | Sh-Pull<br>(Note 5)<br>(Note 7)<br>                       |
| 16        | Charging information                  | 7.6.8      | Data Reference<br>+ ( IMS Public User Identity OR Public Service Identity OR MSISDN OR External Identifier )                                                                                                                                                                        | Sh-Pull<br>Sh-Subs-Notif<br>                              |
| 17        | MSISDN or MSISDN +ExtendedMSISDN      | 7.6.9      | Data Reference<br>+ ( IMS Public User Identity OR MSISDN OR External Identifier )<br>+ [ Private Identity ]                                                                                                                                                                         | Sh-Pull <br>(Note 4)<br>                                  |
| 18        | PSIActivation                         | 7.6.10     | Data Reference<br>+ IMS Public Service Identity                                                                                                                                                                                                                                     | Sh-Pull<br>Sh-Update<br>Sh-Subs-Notif<br>(Note 1)<br>     |
| 19        | DSAI                                  | 7.6.11     | Data Reference<br>+ ( IMS Public User Identity OR Public Service Identity )<br>+ DSAI Tag<br>+ Application Server Name                                                                                                                                                              | Sh-Pull<br>Sh-Update<br>Sh-Subs-Notif<br>(Note 1)<br>     |
| 20        | Reserved                              |            |                                                                                                                                                                                                                                                                                     | <br>                                                      |
| 21        | ServiceLevelTraceInfo                 | 7.6.13     | Data Reference<br>+ ( IMS Public User Identity OR MSISDN OR External Identifier )                                                                                                                                                                                                   | Sh-Pull<br>Sh-Subs-Notif<br>                              |
| 22        | IP Address Secure Binding Information | 7.6.14     | Data Reference<br>+ IMS Public User Identity                                                                                                                                                                                                                                        | Sh-Pull<br>Sh-Subs-Notif<br>                              |
| 23        | Service Priority Level                | 7.6.15     | Data Reference<br>+ IMS Public User Identity                                                                                                                                                                                                                                        | Sh-Pull<br>Sh-Subs-Notif<br>                              |
| 24        | SMSRegistrationInfo                   | 7.6.16     | Data Reference<br>+ ( IMS Public User Identity OR MSISDN OR External Identifier )<br>+ [ Private Identity ]                                                                                                                                                                         | Sh-Pull<br>Sh-Update<br>(Note 5)<br>                      |
| 25        | UE reachability for IP                | 7.6.17     | Data Reference<br>+ ( IMS Public User Identity OR MSISDN OR External Identifier )<br>+ [ Private Identity ]                                                                                                                                                                         | Sh-Subs-Notif<br>(Note 5)<br>                             |
| 26        | T-ADS Information                     | 7.6.18     | Data Reference<br>+ ( IMS Public User Identity OR MSISDN )<br>+ [ Private Identity ]                                                                                                                                                                                                | Sh-Pull<br>(Note 5)<br>                                   |
| 27        | STN-SR                                | 7.6.20     | Data Reference<br>+ ( IMS Public User Identity OR MSISDN )<br>+ [ Private Identity ]                                                                                                                                                                                                | Sh-Pull<br>Sh-Updatef<br>(Note 5)<br>                     |
| 28        | UE-SRVCC- Capability                  | 7.6.21     | Data Reference<br>+ ( IMS Public User Identity OR MSISDN )<br>+ [ Private Identity ]                                                                                                                                                                                                | Sh-Pull<br>Sh-Subs-Notif <br>(Note 5)<br>                 |
| 29        | ExtendedPriority                      | 7.6.15A    | Data Reference<br>+ IMS Public User Identity                                                                                                                                                                                                                                        | Sh-Pull<br>Sh-Subs-Notif<br>                              |
| 30        | CSRN                                  | 7.6.22     | Data Reference<br>+ ( IMS Public User Identity OR MSISDN )<br>+ [ Private Identity ]                                                                                                                                                                                                | Sh-Pull<br>(Note 5)<br>                                   |
| 31        | Reference Location Information        | 7.6.23     | Data Reference<br>+ IMS Public User Identity<br>+ [ Private Identity ]                                                                                                                                                                                                              | Sh-Pull<br>(Note 5)<br>                                   |
| 32        | IMSI                                  | 7.6.24     | Data Reference<br>+ ( IMS Public User Identity OR MSISDN OR External Identifier )<br>+ [ Private Identity ]                                                                                                                                                                         | Sh-Pull<br>(Note 5)<br>(Note 8)<br>                       |
| 33        | IMSPrivateUserIdentity                | 7.6.25     | Data Reference<br>+ IMS Public User Identity                                                                                                                                                                                                                                        | Sh-Pull<br>Sh-Subs-Notif<br>(Note 8)<br>                  |
| 34        | IMEISV                                | 7.6.26     | Data Reference<br>+ ( IMS Public User Identity OR MSISDN OR External Identifier )<br>+ [ Private Identity ]                                                                                                                                                                         | Sh-Pull<br>(Note 5)                                       |

### Repository Data

transparent 데이터가 포함되어 있다. 하나의 Data Repository는 동일한 서비스를 구현하는 둘 이상의 AS가 공유할 수 있다.

<details>
<summary>접기/펼치기</summary>

This information element contains transparent data. A data repository may be shared by more than one AS implementing the same service.
</details><br>

### IMSPublicIdentity

[Identity-Set AVP](#identity-set-avp)의 값에 따라서 포함되는 내용이 다르다.

- IMPLICIT_IDENTITIES 인 경우
    
    - `User-Identity` AVP에 포함된 PuID와 같은 IRS(implicit registration set)에 속하는 모든 non-barred IMS Public Identity들을 제공
    - `User-Identity` AVP가 `Public Service Identity`인 경우 HSS는 요청에서 받은 `User Identity`만 리턴해야함

- ALIAS_IDENTITIES 인 경우

    - `User-Identity` AVP에 포함된 PuID와 같은 Alias Public User Identity Set에 속하는 모든 non-barred IMS Public Identity들을 제공
    - `User-Identity` AVP가 `MSISDN`, `Public Service Identity`, `External Identifier`인 경우에는 이 값에 applicable 하지 않음

- REGISTERED_IDENTITIES 인 경우

    - `User-Identity` AVP에 포함된 IMS Public Identity, MSISDN, External Identifier와 관련된 모든 non-barred Private Identity를 제공
    - `User-Identity` AVP가 PuID인 경우 응답에 Identity들을 리턴하지 않음

- ALL_IDENTITIES 인 경우
    - `User-Identity` AVP와 관련된 모든 Private Identities에 속하는 모든 non-barred IMS Public Identites를 제공 

<details>
<summary>접기/펼치기</summary>

This data contents included in the Sh-Pull Resp, Sh-Subs-Notif Resp or Sh-Notif depends on whether Requested Identity Set information element was included in the Sh-Pull or Sh-Subs-Notif, as follows:
-	When this information element takes the value IMPLICIT_IDENTITIES, the HSS shall provide all non-barred IMS Public Identities that belong to the same implicit registration set as the IMS Public Identity included in the message in the User-Identity AVP. The MSISDN and External Identifier within the User-Identity AVP are not applicable for this value. If the User Identity is a Public Service Identity, the HSS shall return only the User Identity received in the request.
-	When this information element takes the value ALIAS_IDENTITIES, the HSS shall provide all non-barred IMS Public User Identities that are in the same Alias Public User Identity Set as the IMS Public User Identity included in the message in the User-Identity AVP (see 3GPP TS 23.008 [27] for the definition of Alias Public User Identity Set). The MSISDN, the Public Service Identity and the External Identifier within the User-Identity AVP are not applicable for this value.
-	When this information element takes the value REGISTERED_IDENTITIES, the HSS shall provide all non-barred IMS Public Identities whose state is registered, belonging to all Private Identities that the IMS Public Identity or MSISDN or External Identifier in the User-Identity AVP is associated with. If the User Identity is a Public Service Identity, the HSS shall return no identities in the response.
-	When this information element takes the value ALL_IDENTITIES, the HSS shall provide all non-barred IMS Public Identities, belonging to all Private Identities that the User Identity is associated with.
-	When this information element is not included, the HSS shall download the set of IMS Public Identities that would be downloaded if the value of this information element had been ALL_IDENTITIES.
An IMS Public Identity would be either:
-	associated with the same Private User Identity or Private Service Identity as the User Identity included in the request or
-	associated with the MSISDN present in the request or
-	associated with an External Identifier present in the request.
Multiple instances of this information element may be included in the message.
</details><br>

### IMS User State

### S-CSCF Name

### Initial Filter Criteria

### Location Information

### User state

### Charging information

### MSISDN

### UE reachability for IP

### T-ADS Information

### Private Identity

### STN-SR

### UE SRVCC Capability

### CSRN

### IMSI

### IMSPrivateUserIdentity



## Subs-Req-Type AVP

>type : Enumerated

알림 구독 요청의 유형을 나타냄

| Type        | Value | Description    |
| ----------- | ----- | -------------- |
| Subscribe   | 0     | 알림 구독      |
| Unsubscribe | 1     | 알림 구독 해지 |

<details>
<summary>접기/펼치기</summary>

The Subs-Req-Type AVP is of type Enumerated, and indicates the type of the subscription-to-notifications request. The following values are defined:

    Subscribe (0)   
    This value is used by an AS to subscribe to notifications of changes in data.   
    Unsubscribe (1)   
    This value is used by an AS to unsubscribe to notifications of changes in data.   
</details><br>


## Expiry-Time AVP

>type : Time

알림 구독에 대한 expiry time(만료 시간)을 나타낸다. 이 시간이 지나면 구독이 해지된다.

<details>
<summary>접기/펼치기</summary>

The Expiry-Time AVP is of type Time.  This AVP contains the expiry time of subscriptions to notifications in the HSS.
</details><br>


## Send-Data-Indication AVP

>type : Enumerated

Sender 측에서 User-Data의 요청했는지 여부를 나타낸다.

| Type                    | Value | Description                 |
| ----------------------- | ----- | --------------------------- |
| USER_DATA_NOT_REQUESTED | 0     | User_Data를 요청하지 않았음 |
| USER_DATA_REQUESTED     | 1     | User_Data를 요청함          |

<details>
<summary>접기/펼치기</summary>

The Send-Data-Indication AVP is of type Enumerated. If present it indicates that the sender requests the User-Data. The following values are defined:

    USER_DATA_NOT_REQUESTED (0)
    USER_DATA_REQUESTED (1)
</details><br>

## One-Time-Notification AVP

>type : Enumerated

Sender 측에 단 한 번만 알림(notify)하는 것을 나타낸다.

| Type                            | Value | Description    |
| ------------------------------- | ----- | -------------- |
| ONE_TIME_NOTIFICATION_REQUESTED | 0     | 한 번만 notify |

이 AVP는 UE reachability for IP(25) Data Reference에서만 적용된다.

<details>
<summary>접기/펼치기</summary>

The One-Time-Notification AVP is of type Enumerated. If present it indicates that the sender requests to be notified only one time. The following values are defined:

    ONE_TIME_NOTIFICATION_REQUESTED (0)
    This AVP is only applicable to UE reachability for IP (25)
</details><br>


## 참고 자료

- [3GPP TS 29.328 "IP Multimedia (IM) Subsystem Sh interface; signalling flows and message contents".](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1706)
- [3GPP TS 29.329 "Sh Interface based on the Diameter protocol; protocol details](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1707)