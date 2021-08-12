# UE (User Equipment) Identifier

##### _틀린 부분이 있을 수 있습니다. 지적 부탁드립니다._

## 1. UICC

> Universal Intergrated Circuit Card

- 단말기에 장착하는 카드 자체(하드웨어)가 UICC
- 카드에 적용된 애플리케이션(소프트웨어)가 SIM, USIM, ISIM 등으로 나뉨
    - ISIM(IP Multimedia Services Identity Module) : IMS 서비스 관련 식별 모듈로 IMS 관련 데이터(PrID, PuID, 인증 관련 키와 보안 정보 등)을 저장

## 2. UE

> User Equipment

직역하면 가입자(이용자) 설비(장비)   

이동 통신망에서 end-user가 직접 통신하는 모든 device들을 말한다.

즉, 스마트폰, 셀룰러 통신 가능한 랩탑 컴퓨터와 같은 장치들을 통칭한다. (UICC를 장착한 상태의 단말기)

이 UE 들을 구분하기 위해 LTE 네트워크에서는 다양한 Identification을 활용한다.

UE는 USIM(Universal Subscriber Identity Module)과 ME(Mobile Equipment)로 구성된다.

## 2.1. UE ID 종류

- IMSI (International Mobile Subscriber Identity)
- GUTI (Globally Unique Temporary Identifier)
- S-TMSI
- IP Address(PDN Address)
- C-RNTI
- UE S1AP ID
- UE X2AP ID

여기에선 IMSI, GUTI에 대해 알아보고, 추가적으로 5G 에서 사용되는 SUCI, SUPI에 대해서도 알아보겠다.

### 2.1.1. 왜 UE ID 가 여러 종류일까?

"UE 별로 자원을 할당 받기도 하지만 같은 망 자원(예를 들어 채널, connection 등)을 공유하여 사용하기도 한다.   
이 경우 해당 네트워크 엔터티와 인터페이스에서는 UE를 식별하기 위하여 UE 식별자를 할당한다.   
자원을 공유하는 계층이 다르므로 UE를 식별하는 식별자는 다양하게 존재한다."


## 3. PLMN ID

> Public Land Mobile Network

이동통신 사업자의 네트워크 식별번호를 말하며, 전세계 통신사 네트워크마다 부여되어 있는 국제 표준이다.

- PLMN ID = 모바일 국가 코드(MCC) + 이동통신망 코드(MNC)

        +---------------+---------------+
        |      MCC      |      MNC      |
        +---------------+---------------+
        <---3 digits---><-최대 3 digits->
        MCC : Mobile Country Code
        MNC : Mobile Network Code

- 국내(South Korea) 통신 사업자별 코드

| MCC | MNC | 브랜드명 | 이동통신사업자 |
| --- | --- | -------- | -------------- |
| 450 | 02  | KT       | KT             |
| 450 | 04  | KT       | KT             |
| 450 | 05  | SKT      | SK Telecom     |
| 450 | 06  | LG U+    | LG U+          |
| 450 | 08  | KT       | KT             |

- [mcc-mnc.com](https://www.mcc-mnc.com/) 에서 전 세계에 부여된 코드를 확인할 수 있다.

## 4. IMSI

> International Mobile Subscriber Identity

이름에서 유추할 수 있듯이, 전세계적으로 이동통신 가입자를 유일하게 식별할 수 있는 값이다.

- IMSI = PLMN + MSIN (최대 15 digits)

        +---------------+---------------+----------------------------+
        |      MCC      |      MNC      |            MSIN            |
        +---------------+---------------+----------------------------+
        <---3 digits---><-최대 3 digits-><-------최대 10 digits------>
        <-----------------------최대 15 digits----------------------->

- MSIN : 이동통신사로부터 할당 받은 모바일 가입자 번호

"사용자가 단말을 구매하고 LTE 서비스에 가입하면 IMSI 값이 저장되어 있는 USIM 카드를 받게 되고 사업자는 가입 등록 정보를 IMSI와 함께 HSS(Home Subscriber Server)와 SPR(Subscriber Profile Repository)에 provisioning 한다. 이 후 UE가 LTE 망에 접속하면 MME는 UE로부터 수신한 IMSI를 통해 가입자의 이동통신망을 식별하고 가입 등록 정보를 갖고 있는 HSS를 선택하여 등록 정보를 다운로드 받아옴으로써 LTE 망의 기본 연결인 default EPS 베어러 설정을 시작한다."

- 예시 :

        MCC  : 450        (South Korea)
        MNC  : 08         (KT)
        MSIN : 1012345678
        
        => IMSI = 450081012345678

## 5. GUTI

> Globally Unique Temporary Identifier

IMSI는 이동통신 가입자를 고유하게 식별하는 영구적인 값으로, 노출될 경우 보안 문제가 야기될 수 있다.

GUTI는 UE가 망에 접속했을 때 MME가 할당하는 값으로 IMSI를 대신하여 가입자를 고유하게 식별하는 역할을 한다.

UE가 LTE 네트워크에 처음 접속할 때는 IMSI 값으로 접속 요청하고 MME는 GUTI 값을 할당해준다. 이후 재접속할 때부터는 IMSI 대신 GUTI 값을 사용한다.

GUTI는 전세계적으로 고유한 값을 가지지만, UE가 LTE 네트워크에 등록할 때마다 MME로부터 새롭게 할당받는 Temporary Identifier이므로, UE를 식별할 수 있으면서 노출되더라도 보안 문제가 덜하다.

        - GUTI Format

                                <--------- S-TMSI ---------->
        +-----+-----+-----------+------+--------------------+
        | MCC | MNC |   MMEGI   | MMEC |       M-TMSI       |
        +-----+-----+-----------+------+--------------------+
        <- PLMN ID -><----- MMEI ------>
        <----------- GUMMEI -----------><----- M-TMSI ------>
        <---------------------- GUTI ----------------------->

## 6. SUCI, SUPI

> SUbsctiption Concealed Identifier   
> SUbscription Permanent Identifier 

통신 시스템에서 이동통신 사업자는 각 가입자를 식별하기 위해 LTE 에서는 IMSI, 5G에서는 SUPI라고 알려진 고유한 값을 할당한다. 그러나 이 값들은 무선 링크에서 유출되면 보안 문제가 발생할 수 있다.

그래서 3G에서는 TMSI(Temporary Mobile Subscriber Identity), LTE와 5G에서는 [GUTI](#5-guti)를 할당하여 사용한다.

그러나 처음 네트워크에 접속할 때는 GUTI 를 아직 할당받지 못해 IMSI/SUPI 로 접속 요청하기 때문에, 이 과정에서 IMSI/SUPI를 탈취해내는 "IMSI Catcing" 공격이 수행될 수 있다.

이 문제를 해결하기 위해서 3GPP 에서는, 5G-GUTI를 통한 식별 과정에서 실패하더라도 이전 세대와는 다르게 SUPI를 일반 텍스트(plain-text)로 전송하지 않는다.

대신 은폐된(concealed) SUPI를 포함하는 ECIES(Elliptic Curve Integrated Encryption Scheme) 기반 개인 정보 보호 식별자가 전송된다. 이 은폐된 SUPI를 SUCI 라고 부른다.

<details>
<summary>SUPI/SUCI 규격 접기/펼치기</summary>

[23.501]에 정의된 SUPI/SUCI

### 5.9	Identifiers

5.9.1	General

Each subscriber in the 5G System shall be allocated one 5G Subscription Permanent Identifier (SUPI) for use within the 3GPP system. The 5G System supports identification of subscriptions independently of identification of the user equipment.

Each UE accessing the 5G System shall be assigned a Permanent Equipment Identifier (PEI). In the scope of this Release, this applies only to devices supporting at least one 3GPP access technology.

The 5G System supports allocation of a temporary identifier (5G-GUTI) in order to support user confidentiality protection.

5.9.2	Subscription Permanent Identifier

A globally unique 5G Subscription Permanent Identifier (SUPI) shall be allocated to each subscriber in the 5G System and provisioned in the UDM/UDR. The SUPI is used only inside 3GPP system, and its privacy is specified in TS 33.501 [29].

The SUPI may contain:

-	an IMSI as defined in TS 23.003 [19], or
-	a network-specific identifier, used for private networks as defined in TS 22.261 [2].

A SUPI containing a network-specific identifier shall take the form of a Network Access Identifier (NAI) using the NAI RFC 7542 [20] based user identification as defined in TS 23.003 [19].

When UE needs to indicate its SUPI to the network (e.g. as part of the Registration procedure), the UE provides the SUPI in concealed form as defined in TS 23.003 [19].

In order to enable roaming scenarios, the SUPI shall contain the address of the home network (e.g. the MCC and MNC in the case of an IMSI based SUPI).

For interworking with the EPC, the SUPI allocated to the 3GPP UE shall always be based on an IMSI to enable the UE to present an IMSI to the EPC.

5.9.2a	Subscription Concealed Identifier

The Subscription Concealed Identifier (SUCI) is a privacy preserving identifier containing the concealed SUPI. It is specified in TS 33.501 [29].

[33.501]에 정의된 SUPI/SUCI

### 6.12	Subscription identifier privacy

6.12.1	Subscription permanent identifier 

In the 5G system, the globally unique 5G subscription permanent identifier is called SUPI as defined in 3GPP TS 23.501 [2]. The SUCI is a privacy preserving identifier containing the concealed SUPI.

The SUPI is privacy protected over-the-air by using the SUCI which is described in clause 6.12.2. Handling of SUPI and privacy provisioning related to concealing the SUPI shall be done according to the requirements specified in clause 5 and details provided in clause 6.12.2.

6.12.2	Subscription concealed identifier

The SUbscription Concealed Identifier, called SUCI, is a privacy preserving identifier containing the concealed SUPI. 

The UE shall generate a SUCI using a protection scheme with the raw public key, i.e. the Home Network Public Key, that was securely provisioned in control of the home network. The protection schemes shall be the ones specified in Annex C of this document or the ones specified by the HPLMN.

The UE shall construct a scheme-input from the subscription identifier part of the SUPI as  follows: 

-	For SUPIs containing IMSI, the subscription identifier part of the SUPI includes the MSIN of the IMSI as defined in TS 23.003 [19]. 
-	For SUPIs taking the form of a NAI, the subscription identifier part of the SUPI includes the "username" portion of the NAI as defined in NAI RFC 7542 [57].

The UE shall execute the protection scheme with the constructed scheme-input as input and take the output as the Scheme Output.

The UE shall not conceal the Home Network Identifier and the Routing Indicator.

For SUPIs containing IMSI, the UE shall construct the SUCI with the following data fields: 

- 	The SUPI Type as defined in TS 23.003 [19] identifies the type of the SUPI concealed in the SUCI. 
-	The Home Network Identifier is set to the MCC and MNC of the IMSI as specified in 23.003 [19]. 
-	The Routing Indicator as specified in TS 23.003 [19].
-	The Protection Scheme Identifier as specified in Annex C of this specification.
-	The Home Network Public Key Identifier as specified in this document and detailed in TS 23.003 [19].
-	The Scheme Output as specified in this document and detailed in TS 23.003 [19].

For SUPIs containing Network Specific Identifier, the UE shall construct the SUCI in NAI format with the following data fields:

-	realm part of the SUCI is set to the realm part of the SUPI.
- 	username part of the SUCI is formatted as specified in TS 23.003 [19] using the SUPI Type, Routing Indicator, the Protection Scheme Identifier, the Home Network Public Key Identifier and the Scheme Output.

NOTE 1: 	The format of the SUPI protection scheme identifiers is defined in Annex C.  

NOTE 2:	The identifier and the format of the Scheme Output are defined by the protection schemes in Annex C. In case of non-null-schemes, the freshness and randomness of the SUCI will be taken care of by the corresponding SUPI protection schemes.

NOTE 2a:	In case of null-scheme being used, the Home Network Public Key Identifier is set to a default value as described in TS 23.003 [19].  

The UE shall include a SUCI only in the following 5G NAS messages:

-	if the UE is sending a Registration Request message of type "initial registration" to a PLMN for which the UE does not already have a 5G-GUTI, the UE shall include a SUCI to the Registration Request message, or
-	if the UE responds to an Identity Request message by which the network requests the UE to provide its permanent identifier,  the UE  includes a  SUCI in the Identity Response message as specified in clause 6.12.4. 
-	if the UE is sending a De-Registration Request message to a PLMN during an initial registration procedure for which the UE did not receive the registration accept message with 5G-GUTI, the UE shall include the SUCI used in the initial registration to the De-Registration Request message.
NOTE 3: 	In response to the Identity Request message, the UE never sends the SUPI. 
The UE shall generate a SUCI using "null-scheme" only in the following cases:
-	if the UE is making an unauthenticated emergency session and it does not have a 5G-GUTI to the chosen PLMN, or 
-	if the home network has configured "null-scheme" to be used, or
- 	if the home network has not provisioned the public key needed to generate a SUCI.

If the operator's decision, indicated by the USIM, is that the USIM shall calculate the SUCI, then the USIM shall not give the ME any parameter for the calculation of the SUCI including the Home Network Public Key Identifier, the Home Network Public Key, and the Protection Scheme Identifier. If the ME determines that the calculation of the SUCI, indicated by the USIM, shall be performed by the USIM, the ME shall delete any previously received or locally cached parameters for the calculation of the SUCI including the SUPI Type, the Routing Indicator, the Home Network Public Key Identifier, the Home Network Public Key and the Protection Scheme Identifier. The operator should use proprietary identifier for protection schemes if the operator chooses that the calculation of the SUCI shall be done in USIM.

If the operator's decision is that ME shall calculate the SUCI, the home network operator shall provision in the USIM an ordered priority list of the protection scheme identifiers that the operator allows. The priority list of protection scheme identifiers in the USIM shall only contain protection scheme identifiers specified in Annex C, and the list may contain one or more protection schemes identifiers. The ME shall read the SUCI calculation information from the USIM, including the SUPI, the SUPI Type, the Routing Indicator, the Home Network Public Key Identifier, the Home Network Public Key and the list of protection scheme identifiers. The ME shall select the protection scheme from its supported schemes that has the highest priority in the list are obtained from the USIM. 

The ME shall calculate the SUCI using the null-scheme if the Home Network Public Key or the priority list are not provisioned in the USIM.

NOTE 4:	The above feature is introduced since additional protection schemes could be specified in the future for a release newer than the ME release. In this case, the protection scheme selected by older MEs may not be the protection scheme with the highest priority in the list of the USIM.

</details><br>



## 참고 자료
- [NETMANIAS - LTE Identification I: UE 및 ME 식별자](https://www.netmanias.com/ko/?m=view&id=techdocs&no=5156)
- [NETMANIAS - LTE: 가입자 식별자 IMSI와 GUTI](https://www.netmanias.com/ko/?m=view&id=blog&no=5375)
- [wikipedia - User equipment](https://en.wikipedia.org/wiki/User_equipment)
- [3GPP TS 23.003, “Numbering, Addressing and Identification”](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=729)
- [3GPP 25-series of specifications](https://www.3gpp.org/DynaReport/25-series.htm)
- [3GPP 36-series of specifications](https://www.3gpp.org/DynaReport/36-series.htm)
- [3GPP TS 23.501](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3144)
- [3GPP TS 33.501, "Security architecture and procedures for 5G system"](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3169)
- [devage@tistory - 5G SUCI](https://devage.tistory.com/64)
- 김재범, 한국정보통신기술협회, "사업자 간 UICC 이동성 제공을 위한 VoLTE 단말 규격 표준 해설서"
- [염흥렬, 한국정보통신기술협회, "5G 보안 국제표준화 동향"](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwjjl5KPg6vyAhVPZ94KHceOAogQFnoECBEQAQ&url=https%3A%2F%2Fwww.tta.or.kr%2Fdata%2FreportDown.jsp%3Fnews_num%3D6957&usg=AOvVaw0aClzLVD3yziizbVncVYwz)
- [Techplayon - "5G Identifiers SUPI and SUCI"](https://www.techplayon.com/5g-identifiers-supi-and-suci/)