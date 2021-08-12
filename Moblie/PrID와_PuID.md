# PuID(Public User ID)와 PrID(Private User ID)

##### _틀린 부분이 있을 수 있습니다. 지적 부탁드립니다._

## PuID(Public User ID)  
  - IMS Subsystem 내의 가입자가 다른 가입자와의 통신을 요청하기 위해 사용하는 ID
  - 최소 1개 이상의 PuID를 가지고 있어야 함
  - SIP URI(IETF RFC 3261) 또는 Tel URI(IETF RFC 3966)의 형태를 취해야 함
  - SIP URI 형식 : "sip:username@domain"
  - Tel URI 형식 : "tel:+\<CC\>\<NDC\>\<SN\>"

<details>
<summary>PuID 규격 접기/펼치기</summary>

[TS 23.003 에 정의된 PuID]

### 13.4	Public User Identity

A Public User Identity is any identity used by a user within the IMS subsystem for requesting communication to another user.<br>
The Public User Identity shall take the form of either a SIP URI (see IETF RFC 3261 [26]) or a Tel URI (see IETF RFC 3966 [45]).<br>
The 3GPP specifications describing the interfaces over which Public User Identities are transferred specify the allowed Public User Identity formats, in particular 3GPP TS 24.229 [81] for SIP signalling interfaces, 3GPP TS 29.229 [95] for Cx and Dx interfaces, 3GPP TS 29.329 [96] for Sh interface, 3GPP TS 29.165 [97] for II-NNI interface.<br>
In the case the user identity is a telephone number, it shall be represented either by a Tel URI or by a SIP URI that includes a "user=phone" URI parameter and a "userinfo" part that shall follow the same format as the Tel URI.<br>
According to 3GPP TS 24.229 [81], the UE can use either:<br>
- a global number as defined in IETF RFC 3966 [45] and  following E.164 format, as defined by ITU-T Recommendation E.164 [10] or<br>
- a local number, that shall include a "phone-context" parameter that identifies the scope of its validity, as per IETF RFC 3966 [45].<br>
According to 3GPP TS 29.165 [97] a global number as defined in IETF RFC 3966 [45] shall be used in a tel-URI or in the user portion of a SIP URI with the user=phone parameter when conveyed via a non-roaming II-NNI except when agreement exists between the operators to also allow other kinds of numbers.<br>
According to 3GPP TS 29.229 [95] and 3GPP TS 29.329 [96] the canonical forms of SIP URI and Tel URI shall be used over the corresponding Diameter interfaces.<br>
The canonical form of a SIP URI for a Public User Identity shall take the form "sip:username@domain" as specified in IETF RFC 3261 [26], clause 10.3. SIP URI comparisons shall be performed as defined in IETF RFC 3261 [26], clause 19.1.4.<br>
The canonical form of a Tel URI for a Public User Identity shall take the form "tel:+<CC><NDC><SN>" (max number of digits is 15), that represents an E.164 number and shall contain a global number without parameters and visual separators (see IETF RFC 3966[45], clause 3). Tel URI comparisons shall be performed as defined in IETF RFC 3966[45], clause 4.<br>
Public User Identities are stored in the HSS either as a distinct Public User Identity or as a Wildcarded Public User Identity. A distinct Public User Identity contains the Public User Identity that is used in routing and it is explicitly provisioned in the HSS.<br>

[TS 23.228 에 정의된 PuID]

### 4.3.3.2 Public User Identities

Every IM CN subsystem user shall have one or more Public User Identities (see TS 22.228 [8]), including at least one taking the form of a SIP URI (see IETF RFC 3261 [12]). The Public User Identity is used by any user for requesting communications to other users. For example, this might be included on a business card. <br>
- Both telecom numbering and Internet naming schemes can be used to address users depending on the Public User identities that the users have. <br>
- The Public User Identity shall take the form as defined in TS 23.003 [24]. <br>
- An ISIM application shall securely store at least one Public User Identity. For UEs supporting only non-3GPP accesses, if neither ISIM nor USIM is present, but IMC is present, the Public User Identity shall be stored in IMC. It shall not be possible for the UE to modify the Public User Identity, but it is not required that all additional Public User Identities be stored on the ISIM application or IMC. <br>
- A Public User Identity shall be registered either explicitly or implicitly before originating IMS sessions and originating IMS session unrelated procedures can be established by a UE using the Public User Identity. Subscriber-specific services for unregistered users may nevertheless be executed as described in clause 5.6.5. Each    implicit registration set shall contain at least one Public User Identity taking the form of a SIP URI. <br>
NOTE: An implicit registration set can contain Public User Identities of more than one service profile. When sending a third party registration request (for details see clause 5.4.1.7 in TS 24.229 [10a]) to an AS based on an initial filter criteria in a service profile, the third party registration request will include a Public User Identity taking the form of a SIP URI from that service profile within the implicit registration set. <br>
- It shall be possible to identify Alias Public User Identities. For such a group of Public User Identities, operations that enable changes to the service profile and the service data configured shall apply to all the Public User Identities within the group. This grouping information shall be stored in the HSS. It shall be possible to make this grouping information available to the AS via the Sh interface, and Sh operations are applicable to all of the Public User Identities within the same Alias Public User Identity group. It shall be possible to make this information available to the S-CSCF via the Cx interface. It shall be possible to make this information available to the UE via the Gm interface. <br>
- A Public User Identity shall be registered either explicitly or implicitly before terminating IMS sessions and terminating IMS session unrelated procedures can be delivered to the UE of the user that the Public User Identity belongs to. Subscriber-specific services for unregistered users may nevertheless be executed as described in chapter 5.12. <br>
- It shall be possible to register globally (i.e. through one single UE request) a user that has more than one public identity via a mechanism within the IP multimedia CN subsystem (e.g. by using an Implicit Registration Set). This shall not preclude the user from registering individually some of his/her public identities if needed. <br>
- Public User Identities are not authenticated by the network during registration. <br>
- Public User Identities may be used to identify the user's information within the HSS (for example during mobile terminated session set-up).   <br>

</details><br>


## PrID(Private User ID)
  - 홈 네트워크 운영자(통신사)에 의해 고유한 Global ID로 할당되며, 등록, 인증, 관리 및 계정 용도로 사용됨
  - 최소 1개 이상의 PrID를 가지고 있어야 함
  - SIP 메시지 라우팅에 사용되지 않음
  - NAI(Network Access Identifier)의 형태를 취해야 하며 IETF RFC 4282의 clause 2.1에 명시된 "username@realm" 형식을 가져야 함
  - IMSI가 2341509999999999(MCC = 234, MNC = 15) 인 경우 PrID는 "234150999999999@ims.mnc015.mcc234.3gppnetwork.org" 의 형태로 이루어짐


<details>
<summary>PrID 규격 접기/펼치기</summary>

[TS 23.003에 정의된 PrID]

### 13.3	Private User Identity

The private user identity shall take the form of an NAI, and shall have the form username@realm as specified in clause 2.1 of IETF RFC 4282 [53].<br>
NOTE:	It is possible for a representation of the IMSI to be contained within the NAI for the private identity.<br>
For 3GPP systems, the private user identity used for the user shall be as specified in clause 4.2 of 3GPP TS 24.229 [81] and in 3GPP TS 23.228 [24] Annex E.3.1. If the private user identity is not known, the private user identity shall be derived from the IMSI.<br>
The following steps show how to build the private user identity out of the IMSI:<br>
1.	Use the whole string of digits as the username part of the private user identity; and<br>
2.	convert the leading digits of the IMSI, i.e. MNC and MCC, into a domain name, as described in clause 13.2.<br>
The result will be a private user identity of the form "<IMSI>@ims.mnc<MNC>.mcc<MCC>.3gppnetwork.org". For example: If the IMSI is 234150999999999 (MCC = 234, MNC = 15), the private user identity then takes the form "234150999999999@ims.mnc015.mcc234.3gppnetwork.org".<br>
For 3GPP2 systems, if there is no IMC present, the UE shall derive the private user identity as described in Annex C of 3GPP2 X.S0013-004 [67].<br>

[TS 23.228에 정의된 PrID]

### 4.3.3.1 Private User Identities

Every IM CN subsystem user shall have one or more Private User Identities. The private identity is assigned by the home network operator, and used, for example, for Registration, Authorization, Administration, and Accounting purposes. This identity shall take the form of a Network Access Identifier (NAI) as defined in IETF RFC 4282 [14]. It is possible for a representation of the IMSI to be contained within the NAI for the private identity. <br>
- The Private User Identity is not used for routing of SIP messages. <br>
- The Private User Identity shall be contained in all Registration requests, (including Re-registration and Deregistration requests) passed from the UE to the home network.<br>
- An ISIM application shall securely store one Private User Identity. For UEs supporting only non-3GPP accesses, if neither ISIM nor USIM is present, but IMC is present, the Private User Identity shall be stored in IMC. It shall not be possible for the UE to modify the Private User Identity information stored on the ISIM application or IMC. <br>
- The Private User Identity is a unique global identity defined by the Home Network Operator, which may be used within the home network to identify the user's subscription (e.g. IM service capability) from a network perspective. The Private User Identity identifies the subscription, not the user. <br>
- The Private User Identity shall be permanently allocated to a user's subscription (it is not a dynamic identity), and is valid for the duration of the user's subscription with the home network. <br>
- The Private User Identity is used to identify the user's information (for example authentication information) stored within the HSS (for use for example during Registration). <br>
- The Private User Identity may be present in charging records based on operator policies. <br>
- The Private User Identity is authenticated only during registration of the user, (including re-registration and deregistration). <br>
- The HSS needs to store the Private User Identity. <br>
- The S-CSCF needs to obtain and store the Private User Identity upon registration and unregistered termination. <br>
- If mobile terminated short message service without MSISDN as defined in TS 23.204 [56] is required then the Private User Identity shall be based on the IMSI according to TS 23.003 [24], clause 13.3.

</details><br>

## 특징
- 하나의 PrID가 여러 개의 PuID로 구성될 수 있음
  - 동일한 단말에 사용자 선택에 따라 여러 번호로 등록 가능
- PuID 별로 서로 다른 Service Profile을 적용할 수 있음
  - 등록되는 번호에 따라 상이한 서비스 제공 가능
- 하나의 PuID가 여러 개의 PrID와 연결될 수 있음
  - 여러 단말에서 동일한 번호를 이용 가능

![Figure 4.5: Relationship of the Private User Identity and Public User Identities](images/Relationship%20of%20the%20Private%20User%20Identity%20and%20Public%20User%20Identities.png)

[3GPP TS 23.228 "IP Multimedia Subsystem (IMS); Stage 2", Figure 4.5: Relationship of the Private User Identity and Public User Identities]

![Figure 4.6: The relation of a shared Public User Identity (Public-ID-2) and Private User Identities](images/The%20relation%20of%20a%20shared%20Public%20User%20Identity%20(Public-ID-2)%20and%20Private%20User%20Identities.png)

[3GPP TS 23.228 "IP Multimedia Subsystem (IMS); Stage 2", Figure 4.6: The relation of a shared Public User Identity (Public-ID-2) and Private User Identities]

## IRS(Implicit Registration Set)
- SIP는 한 번에 하나의 PuID를 등록(Registration)할 수 있다.
- 그럼 여러 개의 PuID를 가지고 있는 경우에는 개별적으로 등록해야한다.
- 시간과 리소스를 많이 잡아먹게된다.
- IRS(Implicit Registration Set)은 PuID의 집합이다.
- IRS로 묶인 ID들 중 하나가 등록되면, 묶여있는 모든 ID들이 동시에 등록된다.
- 묶여 있는 ID들 중 하나가 등록 취소(Deregistration)되면, 묶여 있는 모든 ID들이 동시에 등록 취소 된다.

<details>
<summary>Implicit Registratrion 규격 접기/펼치기</summary>

[TS 23.228에 정의된 Implicit Registration]

### 5.2.1a	Implicit Registration
5.2.1a.0	General

When an user has a set of Public User Identities defined to be implicitly registered via single IMS registration of one of the Public User Identity's in that set, it is considered to be an Implicit Registration. No single public identity shall be considered as a master to the other Public User Identities. Figure 5.0c shows a simple diagram of implicit registration and Public User Identities. Figure 5.0d shows a similar diagram when multiple Private User Identities are involved. In order to support this function, it is required that:

-	HSS has the set of Public User Identities that are part of implicit registration.
-	Cx reference point between S CSCF and HSS shall support download of all Public User Identities associated with the implicit registration, during registration of any of the single Public User Identities within the set.
-	All Public User Identities of an Implicit Registration set must be associated to the same Private User Identities. See figure 5.0d for the detailed relationship between the public and private user entities within an Implicit Registration set.
-	When one of the Public User Identities within the set is registered, all Public User Identities associated with the implicit registration set are registered at the same time.
-	When one of the Public User Identities within the set is de-registered, all Public User Identities that have been implicitly registered are de-registered at the same time.
-	Registration and de-registration always relates to a particular contact address and a particular Private User Identity. A Public User Identity that has been registered (including when implicitly registered) with different contact addresses remains registered in relation to those contact addresses that have not been de-registered.
-	Public User Identities belonging to an implicit registration set may point to different service profiles; or some of these Public User Identities may point to the same service profile.
-	When a Public User Identity belongs to an implicit registration set, it cannot be registered or de-registered individually without the Public User Identity being removed from the implicit registration list.
-	All IMS related registration timers should apply to the set of implicitly registered Public User Identities
-	S CSCF, P CSCF and UE shall be notified of the set of Public User Identities belonging to the implicitly registered function. Session set up shall not be allowed for the implicitly registered Public User Identities until the entities are updated, except for the explicitly registered Public User Identity.
-	The S CSCF shall store during registration all the Service profiles corresponding to the Public User Identities being registered.
-	When a Public User Identity is barred from IMS communications, only the HSS and S CSCF shall have access to this Public User Identity.
 
![Figure 5.0c: Relationship of Public User Identities when implicitly registered](images/Relationship%20of%20Public%20User%20Identities%20when%20implicitly%20registered.png)

[3GPP TS 23.228 "IP Multimedia Subsystem (IMS); Stage 2", Figure 5.0c: Relationship of Public User Identities when implicitly registered]

![Figure 5.0d: The relation of two shared Public User Identities (Public-ID-3 and 4) and Private User Identities](images/The%20relation%20of%20two%20shared%20Public%20User%20Identities%20(Public-ID-3%20and%204)%20and%20Private%20User%20Identities.png)

[3GPP TS 23.228 "IP Multimedia Subsystem (IMS); Stage 2", Figure 5.0d: The relation of two shared Public User Identities (Public-ID-3 and 4) and Private User Identities]

5.2.1a.1	Implicit Registration for UE without ISIM or IMC

In case an UE is registering in the IMS without ISIM or, for UEs supporting only non-3GPP accesses, without IMC, it shall require the network's assistance to register at least one Public User Identity, which is used for session establishment & IMS signalling. Implicit registration shall be used as part of a mandatory function for these ISIM-less or IMC-less UEs to register the Public User Identity(s). In addition to the functions defined in clause 5.2.1a, the following additional functions are required for this scenario.

-	The Temporary public identity shall be used for initial registration process
-	It shall be defined in HSS that if the user does not have implicit registration activated then the user shall not be allowed to register in the IMS using the Temporary Public User Identity.

</details><br>

## Wildcarded Public User Identity

  - 동일한 서비스 프로파일을 공유하고 동일한 IRS에 포함된 Public User Identities의 집합
  - 네트워크에 의해 많은 수의 사용자가 한 번에 등록되고 동일한 방식으로 처리되는 경우 노드의 작동 및 유지 관리를 최적화 할 수 있다.

<details>
<summary>Wildcarded PuID 규격 접기/펼치기</summary>

[TS 23.003에 정의된 Wildcarded PuID]

### 13.4A	Wildcarded Public User Identity   

Public User Identities may be stored in the HSS as Wildcarded Public User Identities. A Wildcarded Public User Identity represents a collection of Public User Identities that share the same service profile and are included in the same implicit registration set. Wildcarded Public User Identities enable optimisation of the operation and maintenance of the nodes for the case in which a large amount of users are registered together and handled in the same way by the network. The format of a Wildcarded Public User Identity is the same as for the Wildcarded PSI described in clause 13.5.


[TS 23.228에 정의된 Wildcarded PuID]

### 4.3.3.2b	Wildcarded Public User Identity
It shall be possible to support a wildcarded Public User Identity. A wildcarded Public User Identity expresses a set of Public User Identities grouped together. It shall be possible to include and express the wildcarded Public User Identity in the implicit registration set according to clause 5.2.1a.
Only distinct Public User Identities shall be used for explicit registration. The implicit registration of a wildcarded Public User Identity shall be handled in the same manner as the implicit registration of a distinct Public User Identity from a network perspective, with only one service profile associated to the wildcarded Public User Identity.
It shall be possible for a user to have a distinct Public User Identity even if it matches a wildcarded Public User Identity. Such a distinct Public User Identity may have a different service profile than the wildcarded Public User Identity.
Editor's Note:	It is to TBD if a distinct Public User Identity shall be included in the same implicit registration or not. If stage 3 protocol solution found for this issue, then they can be in separate implicit registration set.
The matching of a distinct Public User Identity shall take precedence over matching of wildcarded Public User Identity. When the value of a Public User Identity matches what is expressed as an implicitly registered wildcarded Public User Identity and there is no better match, then the procedures are the same as in the case that the identifier matches an implicitly registered distinct Public User Identity.
</details><br>

## Temporary Public User Identity

- IMSI에 기반한 Public User Identity
- 3GPP 시스템에서, Public User Identity를 호스트하는 ISIM application이 없는 경우 Temporary Public User Identity를 사용한다.
- '저장된 PuID가 없으면 Temporary PuID를 사용한다'는 의미?
- "sip:" + IMSI + home network domain name의 형식
- IMSI가 `234150999999999` 라면
  - MCC = 234
  - MNC = 15
  - MSIN = 0999999999
- 그럼 home network domain name은 `ims.mnc015.mcc234.3gppnetwork.org` 가 되고
- Temporary Public User Identity는 `sip:234150999999999@ims.mnc015.mcc234.3gppnetwork.org` 가 된다.

<details>
<summary>Temporary PuID 규격 접기/펼치기</summary>

### 13.2	Home network domain name
The home network domain name shall be in the form of an Internet domain name, e.g. operator.com, as specified in IETF RFC 1035 [19] and IETF RFC 1123 [20]. The home network domain name consists of one or more labels. Each label shall consist of the alphabetic characters (A-Z and a-z), digits (0-9) and the hyphen (-) in accordance with IETF RFC 1035 [19]. Each label shall begin and end with either an alphabetic character or a digit in accordance with IETF RFC 1123 [20]. The case of alphabetic characters is not significant.

For 3GPP systems, if there is no ISIM application, the UE shall derive the home network domain name from the IMSI as described in the following steps:

1.	Take the first 5 or 6 digits, depending on whether a 2 or 3 digit MNC is used (see 3GPP TS 31.102 [27]) and separate them into MCC and MNC; if the MNC is 2 digits then a zero shall be added at the beginning.
2.	Use the MCC and MNC derived in step 1 to create the "mnc<MNC>.mcc<MCC>.3gppnetwork.org" domain name.
3.	Add the label "ims." to the beginning of the domain.

An example of a home network domain name is:

    IMSI in use: 234150999999999;

    where:
    
    -	MCC = 234;
    -	MNC = 15; and
    -	MSIN = 0999999999,

which gives the home network domain name: ims.mnc015.mcc234.3gppnetwork.org.

For 3GPP2 systems, if there is no IMC present, the UE shall derive the home network domain name as described in Annex C of 3GPP2 X.S0013-004 [67].

[TS 23.003에 정의된 Temporary PuID]

### 13.4B	Temporary Public User Identity   

For 3GPP systems, if there is no ISIM application to host the Public User Identity, a Temporary Public User Identity shall be derived, based on the IMSI. The Temporary Public User Identity shall be of the form as described in clause 13.4 and shall consist of the string "sip:" appended with a username and domain portion  equal to the IMSI derived Private User Identity, as described in clause 13.2. An example using the same example IMSI from clause 13.2 can be found below:

EXAMPLE:	"sip:234150999999999@ims.mnc015.mcc234.3gppnetwork.org".

For 3GPP2 systems, if there is no IMC present, the UE shall derive the public user identity as described in Annex C of 3GPP2 X.S0013-004 [67].

[TS 23.003에 정의된 Home network domain name]

</details><br>

## 참고 자료
- [이운영, KT 플랫폼연구소, [유무선통합 IMS플랫폼 기술]](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwiBtLCv2pjyAhUsxosBHd-aC0UQFnoECAMQAw&url=http%3A%2F%2Fwebs.co.kr%2F%3Fmodule%3Dfile%26act%3DprocFileDownload%26file_srl%3D39321%26sid%3D68db23e4e057c1c24999e922c5698a1b&usg=AOvVaw1npIFv_RJvWc5OtVJxnfHv)
- [The IMS: IP Multimedia Concepts And Services, Second Edition by Miikka Poikselka, Georg Mayer, Hisham Khartabil, Aki Niemi](https://www.oreilly.com/library/view/the-ims-ip/9780470019061/9780470019061_mechanism_to_register_multiple_user_iden.html)
- [3GPP TS 23.228 "IP Multimedia Subsystem (IMS); Stage 2"](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=821)
- [3GPP TS 22.228 "Service requirements for the Internet Protocol (IP) multimedia core network subsystem (IMS); Stage 1"](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=629)
- [3GPP TS 23.003, “Numbering, Addressing and Identification”](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=729)