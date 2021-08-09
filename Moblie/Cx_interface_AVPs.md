# Cx Interface AVPs

##### _틀린 부분이 있을 수 있습니다. 지적 부탁드립니다._

Cx Interface의 AVPs 중 일부를 발췌해서 정리

## Visited-Network-Identifier AVP
---

<details>
<summary>접기/펼치기</summary>
<div markdown="1">
The Visited-Network-Identifier AVP is of type OctetString. This AVP contains an identifier that helps the HSS to identify the visited network (e.g. the visited network domain name). Coding of octets is H-PLMN operator specific. The I-CSCF maps a received P-Visited-Network-ID onto an Octet String value that is consistently configured in I-CSCF and HSS to uniquely identify the visited network.<br>
</div>
</details><br>

type : UTF8OctectString

방문한 홈 네트워크를 식별하는데 도움을 주는 식별자가 포함되어 있음

(예를 들면, visited network domain name)

## User-Authorization-Type AVP
---

type : Enumerated

User Authorization operation(사용자 권한 부여 작업)에서 사용자 권한 유형을 나타낸다.
(i.e. UAR)   
아래 값들 중 하나가 정의된다.

|Type           |Value|Description|
|---------------|-----|-----------|
|REGISTRATION   |0    |최초 Regi 또는 Re-Regi 시에 사용|
|DE_REGISTRATION|1    |Regi 취소 시에 사용|
|REGISTRATION_AND_CAPABILITIES|2|I-CSCF가 HSS에게 S-CSCF 정보를 명시적으로 요청할 때 사용 (I-CSCF는 HSS에 저장된 사용자의 현재 S-CSCF에 연결할 수 없고 새로운 S-CSCF를 선택해야 할 때 REGI_AND_CAPA를 사용)|

<details>
<summary>접기/펼치기</summary>
<div markdown="1">
The User-Authorization-Type AVP is of type Enumerated, and indicates the type of user authorization being performed in a User Authorization operation, i.e. UAR command. The following values are defined:<br><br>
REGISTRATION (0)<br>
	This value is used in case of the initial registration or re-registration. I-CSCF determines this from the Expires field or expires parameter in Contact field in the SIP REGISTER method if it is not equal to zero.  <br>
	This is the default value.<br><br>
DE_REGISTRATION (1)<br>
	This value is used in case of the de-registration. I-CSCF determines this from the Expires field or expires parameter in Contact field in the SIP REGISTER method if it is equal to zero.<br><br>
REGISTRATION_AND_CAPABILITIES (2)<br>
	This value is used when the I-CSCF explicitly requests S-CSCF capability information from the HSS. The I-CSCF shall use this value when the user's current S-CSCF, which is stored in the HSS, cannot be contacted and a new S-CSCF needs to be selected<br>
<br>
</div>
</details><br>


## Server-Capabilities AVP
---

type : Grouped

I-CSCF가 S-CSCF를 선택하는데 assist하는 정보를 포함하고 있음.   
(만약 Public User Identity와 연관된 S-CSCF가 없다면, HSS는 I-CSCF가 적절한 S-CSCF를 선택하는 것을 허용하는 S-CSCF 기능(capabilities)과 관련된 정보를 응답할 수 있음.)

- ### Mandatory-Capability AVP
    type : Unsigned32   
    single determined mandatory capability or a set of capabilities of an S-CSCF

- ### Optional-Capability AVP
    type : Unsigned32   
    single determined mandatory capability or a set of capabilities of an S-CSCF


<details>
<summary>접기/펼치기</summary>
<div markdown="1">
The Server-Capabilities AVP is of type Grouped. This AVP contains information to assist the I-CSCF in the selection of an S-CSCF.<br>
AVP format<br>
Server-Capabilities ::= \<AVP header: 603 10415\><br>
*[Mandatory-Capability]<br>
*[Optional-Capability]<br>
*[Server-Name]<br>
*[AVP]<br><br>
6.3.5	Mandatory-Capability AVP<br>
The Mandatory-Capability AVP is of type Unsigned32. Each value included in this AVP can be used to represent a single determined mandatory capability or a set of capabilities of an S-CSCF, as described in 3GPP TS 29.228 [1] (clause 6.7).<br><br>
6.3.6	Optional-Capability AVP<br>
The Optional-Capability AVP is of type Unsigned32. Each value included in this AVP can be used to represent a single determined optional capability or a set of capabilities of an S-CSCF, as described in 3GPP TS 29.228 [1] (clause 6.7).<br>
</div>
</details><br>

<details>
<summary>접기/펼치기</summary>
<div markdown="1">
6.7	S-CSCF Assignment<br>
The list of mandatory and optional capabilities received by an I-CSCF from the HSS allows operators to distribute users between S-CSCFs, depending on the different capabilities (e.g. features, role, geographical location) that each S-CSCF may have. Alternatively, an operator has the possibility to steer users to certain S-CSCFs.<br>
The operator shall define (possibly based on the functionality offered by each S-CSCF installed in the network) the exact meaning of the S-CSCF mandatory and optional capabilities available in his network. It is an operator task to allocate a unique value to represent a single capability (e.g. support of "wildcarded PSI") or a set of capabilities (e.g. support of "alias" and "Shared IFC sets" and "wildcarded PSI") and to use these values to identify capabilities that are mandatory and/or optional to support for a given subscription. It is a configuration task for the operator to ensure that the I-CSCF has a correct record of the capabily values received from the HSS for each S-CSCF available in his network. The I-CSCF and the HSS do not need to know the semantic of these values. This semantic is exclusively an operator issue.<br>
As a first choice, the I-CSCF shall select an S-CSCF that has all the mandatory and optional capabilities for the user. Only if that is not possible shall the I-CSCF apply a 'best-fit' algorithm. If more than one S-CSCF is identified that supports all mandatory capabilities the I-CSCF may then consider optional capabilities in selecting a specific S-CSCF. The 'best-fit' algorithm is implementation dependent and out of the scope of this specification.<br>
It is the responsibility of the operator to ensure that there are S-CSCFs which have mandatory capabilities indicated by the HSS for any given user. However, configuration errors may occur. If such errors occur and they prevent the I-CSCF from selecting an S-CSCF which meets the mandatory capabilities indicated by the HSS, the I-CSCF shall inform the operator via the O&M subsystem.<br>
As an alternative to selecting an S-CSCF based on the list of capabilities received from the HSS, it is possible to steer users to certain S-CSCFs. To do this, the operator may include one or more S-CSCF names as part of the capabilities of the user profile. The reason for the selection (e.g. all the users belonging to the same company/group could be in the same S-CSCF to implement a VPN service) and the method of selection are operator issues and out of the scope of this specification. If this alternative is chosen, the HSS shall include Server-Name AVPs in the Server-Capabilities AVP and should not include Mandatory-Capability AVPs or Optional-Capability AVPs in the Server-Capabilities AVP, and the I-CSCF when receiving Server-Name AVPs within the Server-Capabilities AVP shall discard any Mandatory-Capability AVP and any Optional-Capability AVP received within the Server-Capabilities AVP.<br>
The following table is a guideline for operators that records S-CSCF capabilities that need to be supported by an S-CSCF in order to serve a user or a service (identified by a Public User Identity or Public Service Identity), that cannot be served by an S-CSCF which is only compliant to a previous 3GPP release.<br>
</div>
</details><br>

## SIP-Number-Auth-Items AVP
---

type : Unsigned32

- Request 메시지에 포함된 경우, S-CSCF가 요청하는 인증 벡터의 수
- Response 메시지에 포함된 경우, HSS(UDM)에서 제공하는 SIP-Auth-Data-Item AVP의 실제 수(actual number)

<details>
<summary>접기/펼치기</summary>
<div markdown="1">
6.3.8	SIP-Number-Auth-Items AVP<br>
The SIP-Number-Auth-Items AVP is of type Unsigned32.<br>
When used in a request, the SIP-Number-Auth-Items indicates the number of authentication vectors the S-CSCF is requesting. This can be used, for instance, when the client is requesting several pre-calculated authentication vectors. In the answer message, the SIP-Number-Auth-Items AVP indicates the actual number of SIP-Auth-Data-Item AVPs provided by the Diameter server. <br>
</div>
</details><br>

## SIP-Authenticate AVP
---

type : OctecString

authentication challenge RAND와 token AUTN가 binary encoded 되어 연결된 값이 포함된다.

인증 정보의 고정 길이는 32 octets (RAND 16 octets + AUTN 16 octets)

(RAND와 AUTN에 대한 정보는 [3GPP TS 33.203](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=2277) 참고)

<details>
<summary>접기/펼치기</summary>
<div markdown="1">
6.3.10	SIP-Authenticate AVP<br>
The SIP-Authenticate AVP is of type OctetString and contains specific parts of the data portion of the WWW-Authenticate or Proxy-Authenticate SIP headers that are to be present in a SIP response. <br>
It shall contain, binary encoded, the concatenation of the authentication challenge RAND and the token AUTN. See 3GPP TS 33.203 [3] for further details about RAND and AUTN. The Authentication Information has a fixed length of 32 octets; the 16 most significant octets shall contain the RAND, the 16 least significant octets shall contain the AUTN.<br>
</div>
</details><br>

## SIP-Authorization AVP
---

type : OctetString

- Authentication Request 메시지에 포함된 경우, RAND(16 octets) 와 AUTS(14 octets)가 binary encoded 되어 연결된 값이 포함된다. 그래서 인증 정보는 30 octets의 고정 길이를 가진다.
  - RAND와 AUTS에 대한 정보는 [3GPP TS 33.203](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=2277) 참고
- Authentication Request Response 메시지에 포함된 경우, 예상 응답 XRES가 binary encoded된 값이 포함된다.
  - XRES에 대한 정보는 [3GPP TS 33.203](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=2277) 참고

<details>
<summary>접기/펼치기</summary>
<div markdown="1">
6.3.11	SIP-Authorization AVP<br>
The SIP-Authorization AVP is of type OctetString and contains specific parts of the data portion of the Authorization or Proxy-Authorization SIP headers suitable for inclusion in a SIP request. <br>
When included in an Authentication Request, it shall contain the concatenation of RAND, as sent to the terminal, and AUTS, as received from the terminal. RAND and AUTS shall both be binary encoded. See 3GPP TS 33.203 [3] for further details about RAND and AUTS. The Authorization Information has a fixed length of 30 octets; the 16 most significant octets shall contain the RAND, the 14 least significant octets shall contain the AUTS.<br>
When included in an Authentication Request Response, it shall contain, binary encoded, the expected response XRES. See 3GPP TS 33.203 [3] for further details about XRES. <br>
</div>
</details><br>

## 참고 자료
- [3GPP TS 29.228 "IP Multimedia (IM) Subsystem Cx and Dx interfaces; Signalling flows and message contents"](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1681)
- [3GPP TS 29.229 "Cx and Dx interfaces based on the Diameter protocol; Protocol details"](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1682)
- [The IMS: IP Multimedia Concepts And Services, Second Edition by Miikka Poikselka, Georg Mayer, Hisham Khartabil, Aki Niemi](https://www.oreilly.com/library/view/the-ims-ip/9780470019061/9780470019061_s-cscf_assignment.html)