# PDU Session Establishment

TS 23.502 4.3.2절 PDU Session Establishment

## General

PDU Sesstion Establishment는 아래 경우에 이루어질 수 있다.
- UE가 PDU Session Establishment 절차를 시작
- UE가 3GPP와 non-3GPP간 PDU Session handover를 시작
- UE가 EPS에서 5GS로의 PDU Session handover를 시작
- 네트워크에서 PDU Session Establishment procedure를 트리거
  - 이 경우에는 네트워크가 UE side의 application(s)로 device trigger message를 보낸다. 
  - Device Trigger Request 메시지의 payload에는 PDU Session establishment request를 트리거할 것으로 예상되는 UE side의 application(s)에 대한 정보가 포함된다. 4.13.2 절 참고.

만약 UE가 3GPP access와는 다른 PLMN에 위치한 N3IWF/TNGW/W-AGF를 통해 non-3GPP access에 동시에 register된다면, 이후 절차의 functional entities는 PDU Session을 위해 UE와 NAS 메시지를 교환하는 access의 PLMN에 위치한다.

TS 23.501의 5.6.1절에 명시된 대로, PDU Session은 한번에 하나의 access type(i.e. 3GPP access or non-3GPP access)으로 관련(associated)될 수도 있으며, 또는 multiple access type(i.e. 하나의 3GPP access와 하나의 non-3GPP access)과 동시에 관련될 수도 있다. multiple access type과 관련된 PDU Session은 ATSSS 기능을 지원하는 UE에 의해 요청될 수 있으며, Multi Access PDU(MA PDU) Session으로 지칭된다.

다음 4.3.2.2절은 특정 시점에 single access type과 관련된 PDU Session을 establishing하기 위한 절차이다. MA PDU는 4.22절의 ATSSS를 참고.

## 4.3.2.2 UE Requested PDU Session Establishment

### 4.3.2.2.1 Non-roaming and Roaming with Local Breakout

4.3.2.2.1절에서는 Non-roaming과 Roaming 시 Local Breakout 상황에서의 PDU Session establishment를 명시한다. 이 절차는 다음과 같이 사용된다:
- 새로운 PDU Session을 establish
- EPS에서 N26 인터페이스 없이 5GS로 PDN Connection을 Handover
- existing PDU Session을 non-3GPP access 와 3GPP access 간 전환(switching). 이 경우에 특정 시스템 동작은 4.9.2절과 4.9.3절에서 정의되어있음
- Emergency Services를 위한 PDU Session 요청

로밍의 경우, AMF는 LBO(Local BreakOut) 또는 Home Routing에서 PDU Session을 establish할지 여부를 결정한다. LBO의 경우, 절차는 로밍이 아닌 경우와 동일하지만 AMF, SMF, UPF, PCF가 visited network에 위치한다. Emergency Service를 위한 PDU Sessions는 Home Routed mode에서는 절대로 설정되지 않는다. 만약 PDU session의 Control Plane CIoT 5GS Optimisation이 LBO와 함께 활성화된 경우, NEF는 이 PDU Session의 앵커로 사용되지 않는다.

> NOTE 1: UE는 TS 23.501의 5.15.5.3절에서와 같이 Home PLMN과 Visited PLMN의 S-NSSAIs 모두를 네트워크에 제공한다.

![Figure 4.3.2.2.1-1](images/Figure%204.3.2.2.1-1.png)

이 절차에서는 UE가 AMF에 이미 register되어있다고 가정하기 때문에, UE가 Emergency Register하지 않는 한 AMF는 이미 UDM으로부터 가입자의 subscription data를 조회했음.

## 1. PDU Session Establishment Request

UE에서 AMF로: NAS 메시지 전송

- NAS 메시지

      S-NSSAI(s), UE가 요청한 DNN, PDU Session ID, Request type, 이전 PDU Session ID, N1 SM container(PDU Session Establishment Request, [Port Management Information Container])

**새로운 PDU Session을 establish하기 위해서, UE는 새로운 PDU Session ID를 생성한다.**

UE는 N1 SM container 내에 PDU Session Establishment Request를 포함한 NAS 메시지를 전송함으로써 PDU Session Establishment 절차를 시작한다. PDU Session Establishment Request에는 `PDU Session ID`, `Requested PDU Session Type`, `Requested SSC mode`, `5GSM Capability`, `PCO`, `SM PDU DN Request Container`, `[Number Of Packet Filters]`, `[Header Compression 설정]`, `UE Integrity Protection Maximum Data Rate`, `[Always-on PDU Session Requested]`가 포함된다.

`Request Type`은 새로운 PDU Session을 establish하기 위한 요청인 경우 "Initial request"로 표시되고, 3GPP access와 non-3GPP access 사이에서의 기존 PDU 세션의 스위칭이거나 EPC의 기존 PDN Connection으로부터 PDU Session Handover를 하는 경우에는 "Exising PDU Session"으로 표시된다. 만약 request가 존재하는 EPC PDN Connection을 나타내는 경우, S-NSSAI는 TS 23.501의 5.15.7.2절에 설명되어 있는 대로 설정된다.

Emergency service가 필요하고 Emergency PDU Session이 이미 establish 되어있지 않은 경우, UE는 "Emergency Request"를 나타내는 Request Type과 함께 UE가 요청한 PDU Session Establishment 절차를 시작해야한다.

`Request Type`은 만약 PDU Session Establishment가 Emergency services를 위한 PDU Session을 establish하기 위한 요청인 경우에 "Emergency Request"로 표시된다. request가 이미 존재하는 3GPP access와 non-3GPP access 사이에서의 Emergency service를 위한 PDU Session 스위칭을 나타내거나 EPC의 Emergency services를 위한 기존 PDN connection으로부터 PDU Session으로 Handover를 나타내는 경우, `Request Type`은 "Existing Emergency PDU Session"으로 표시된다.

`5GSM Core Network Capability`는 UE에 의해 제공되며, TS 23.501의 5.4.4b절에서 정의된대로 SMF에서 처리한다.

`Number Of Packet Filters`는 establish되는 PDU Session의 signalled된 QoS rules에 대한 지원되는 packet filters의 수를 나타낸다. UE가 지정한 packet filters의 수는 PDU Session의 lifetime동안 유효하다. 존재 조건(presence condition)은 TS 24.501을 참조.

`UE Integrity Protection Maximum Data Rate`는 UE가 지원할 수 있는 최대 데이터 전송률을 나타낸다. UE는 PDU Session Establishment Request을 전송하는 Access Type과는 관계없이 `UE Integrity Protection Maximum Data Rate`를 제공해야 한다.

이전 registration 절차에서 UE와 네트워크 간에 Control Plane CIoT 5GS optimisation을 위한 header compression의 사용이 성공적으로 negotiate 되었다면, "Unstructured" PDU Session Type이 아닌 경우에 UE는 `Header Compression Configuration` 을 포함해야 한다. `Header Compression Configuration`에는 header compression channel setup에 필요한 정보가 포함된다. Optional하게, `Header Compression Configuration`에는 추가적인 header compression context 파라미터들이 포함될 수 있다.

UE가 보내는 NAS 메시지는 AN에 의해 AMF로 향하는 N2 메시지에 캡슐화되며, 가입자 위치 정보와 Access Type 정보를 포함해야 한다.

PDU Session Establishment Request 메시지에는 외부 DN에 대한 PDU Session authorization을 위한 정보를 포함하는 SM PDU DN Request Container가 포함될 수 있다.

UE는 현재 access type의 Allowed NSSAI 중에서 S-NSSAI를 포함해야 한다. Allowed NSSAI의 Mapping이 UE에게 제공된 경우, UE는 VPLMN의 S-NSSAI(from Allowed NSSAI)와 일치하는 HPLMN의 S-NSSAI(from Mapping된 Allowed NSSAI)를 모두 제공해야 한다.

procedure가 SSC mode 3 operation을 위해 트리거되는 경우, UE는 NAS 메시지에 release될, on-going PDU Session의 PDU Session ID를 나타내는 Old PDU Session ID를 포함해야 한다.

AMF는 AN으로부터 NAS SM 메시지(step 1에서 구성된)와 가입자 위치 정보(e.g. NG-RAN의 Cell ID)를 받는다.

UE는 LADN의 가용 영역 바깥에 있는 경우 LADN에 해당하는 PDU Session establishment를 트리거해서는 안된다.

UE가 IMS를 위한 PDU Session을 establish하고 UE가 connectivity establishment 도중에 P-CSCF 주소를 discover하도록 설정된 경우, UE는 SM container 내에서 P-CSCF IP 주소를 요청하는 indicator를 포함해야 한다.

The PS Data Off status is included in the PCO in the PDU Session Establishment Request message. 

The UE capability to support Reliable Data Service is included in the PCO in the PDU Session Establishment Request message. 

If the UE has indicated that it supports transfer of Port Management Information Containers as per UE 5GSM Core Network Capability, then the UE shall include the MAC address of the DS-TT Ethernet port used for this PDU session. If the UE is aware of the UE-DS-TT Residence Time, then the UE shall additionally include the UE-DS-TT Residence Time. 

If the UE requests to establish always-on PDU session, the UE includes an Always-on PDU Session Requested indication in the PDU Session Establishment Request message. 

Port Management Information Container is received from DS-TT and includes port management capabilities, i.e. information indicating which standardized and deployment-specific port management information is supported by DS-TT as defined in clause 5.28.3 of TS 23.501 [2]. 

---

## 2. SMF selection

AMF는 Request Type이 "initial request"를 나타내고 PDU Session ID가 UE의 기존 PDU Session 중 어느 것에도 사용되지 않는다는 것을 기준으로 메시지가 새로운 PDU Session을 생성하는 요청인지 판단한다.

만약 NAS 메시지에 S-NSSAI가 포함되어 있지 않은 경우, AMF는 요청받은 PDU Session을 위한 Serving PLMN의 S-NSSAI를 결정한다. UE의 현재 Allowed NSSAI로부터.

만약 단 하나의 S-NSSAI만 Allowd NSSAI에 있다면, 그 S-NSSAI를 사용해야 한다. Allowed NSSAI에 여러 개의 S-NSSAI가 있다면 UE의 가입정보 또는 사업자 정책에 따라 S-NSSAI가 선택됩니다.

NAS 메시지에 Serving PLMN의 S-NSSAI가 포함되어 있지만 DNN은 포함되어 있지 않은 경우, AMF는 요청받은 PDU Session을 위한 DNN을 결정하기 위해 UE의 가입 정보에 default DNN이 있는 경우 해당 S-NSSAI의 default DNN을 선택한다; 그렇지 않은 경우 serving AMF는 로컬로 구성된 DNN을 선택한다.

만약 AMF가 SMF를 선택할 수 없는 경우(e.g. UE가 요청한 DNN이 네트워크에서 지원되지 않는 경우, 또는 UE가 요청한 DNN이 S-NSSAI에 대한 Subscribed DNN 목록에 없고 wildcard DNN이 Subscribed DNN 목록에 없는 경우), AMF는 PCF로부터 받은 operator policy에 따라 적절한 원인과 함께 UE의 PDU Session Establishment Request를 reject하거나 PCF에게 UE의 requested DNN을 selected DNN으로 교체하도록 요청해야 한다.

만약 UE가 요청한 DNN이 UE의 가입 정보에 있지만 PCF로부터 받은 operator policy에 replacement로 표시된 경우, AMF는 PCF에게 selected DNN으로의 DNN replacement를 요청해야 한다. AMF는 DNN replacement를 요청할 때 4.1.16.2.11절에 명시된대로 처리한다. 만약 UE가 요청한 DNN이 UE의 가입 정보에 있지만 네트워크에서 지원되지 않고 PCF로부터 받은 operator policy에도 replacement로 표시되지 않은 경우, AMF는 적절한 cause와 함께 UE로부터의 PDU Sesstion Establishment Request를 reject 해야한다.

AMF는 23.501의 6.3.2절 및  4.3.2.2.3절에 설명된 대로 SMF를 선택한다. 만약 Request Type이 "Initial request"를 나타내거나, request가 EPS에서의 handover 또는 다른 AMF에 의한 non-3GPP access에서의 handover로 인한 것이면, AMF는 S-NSSAI(s), DNN, PDU Session ID, SMF ID 및 PDU Session의 Access Type과의 연관성(association)을 저장한다.

During registration procedures, the AMF determines the use of the Control Plane CIoT 5GS Optimisation or User Plane CIoT 5GS Optimisation based on UEs indications in the 5G Preferred Network Behaviour, the serving operator policies and the network support of CIoT 5GS optimisations. The AMF selects an SMF that supports Control Plane CIoT 5GS optimisation or User Plane CIoT 5GS Optimisation as described in clause 6.3.2 of TS 23.501 [2].

Request Type이 "initial request" 이고, 메시지에 existing PDU Session을 나타내는 Old PDU Session ID가 포함되어 있는 경우, AMF는 4.3.5.2절에 설명된 대로 SMF를 선택하고, 새로운 PDU Session ID, S-NSSAI(s), selected SMF ID 및 PDU Session의 Access Type의 연관 관계(association)을 저장한다.

Request Type이 "Existing PDU Session"인 경우, AMF는 UDM에서 받은 SMF-ID에 기반해서 SMF를 선택한다. Request Type이 "Existing PDU Session"이지만 AMF가 PDU Session ID를 인식하지 못하거나, subscription context(AMF가 Registration 또는 Subscription Profile Update Notification 절차 중에 UDM으로부터 받은)에 PDU Session ID에 해당하는 SMF ID가 포함되어 있지 않은 경우 error case에 해당한다. AMF는 PDU Session에 저장된 Access Type을 업데이트 한다.

Request Type이 "Existing PDU Session"인데, existing PDU Session이 3GPP access와 non-3GPP access간 이동을 의미하는 경우, PDU Session의 Serving PLMN S-NSSAI가 target access type의 Allowed NSSAI에 포함되어 있다면 PDU Session Establishment 절차를 아래와 같은 경우에 수행할 수 있다.
- PDU Session ID에 해당하는 SMF ID와 AMF가 동일한 PLMN에 속하는 경우
- PDU Session ID에 해당하는 SMF ID가 HPLMN에 속하는 경우

그렇지 않으면 AMF는 적절한 cause와 함께 PDU Session Establishment Request를 reject 해야한다.

> NOTE 2: SMF ID에는 SMF가 속한 PLMN ID가 포함된다.

Emergency Registerd UE로부터 온 request이고 Request Type이 "Emergency Request" 또는 "Existing Emergency PDU Session"이 아닌 경우 해당 요청을 reject한다. AMF는 Request Type이 "Emergency Request"라면 UE에서 제공한 S-NSSAI 및 DNN 값이 없다고 가정하고, 대신에 로컬로 configured된 값을 사용한다. AMF는 PDU Session의 Access Type을 저장한다.

만약 Request Type이 "Emergency Request" 또는 "Existing Emergency PDU Session"인 경우, AMF는 23.501의 5.16.4절에서 설명된대로 SMF를 선택한다.

---

## 3. Nsmf_PDUSession_CreateSMContext Request

AMF에서 SMF로: Nsmf_PDUSession_CreateSMContext Request 또는 Nsmf_PDUSession_UpdateSMContext Request

- Nsmf_PDUSession_CreateSMContext Request

      SUPI, selected DNN, requested DNN, S-NSSAI(s), PDU Session ID, AMF ID, Request Type, PCF ID, Priority Access, [Small Data Rate Control Status], N1 SM container(PDU Session Establishment Request), 가입자 위치 정보, Access Type, RAT Type, PEI, GPSI, LADN service area내 UE 존재 여부, PDU Session Status Notification을 위한 Subscription, DNN Selection Mode, Trace Requirement, Control Plane CIoT 5GS Optimisation indication, or Control Plane Only indicator

- Nsmf_PDUSession_UpdateSMContext Request

      SUPI, DNN, S-NSSAI(s), SM Context ID, AMF ID, Request Type, N1 SM container (PDU Session Establishment Request), User location information, Access Type, RAT type, PEI, Serving Network (PLMN ID, or PLMN ID and NID, see clause 5.18 of TS 23.501 [2])

만약 AMF가 UE로부터 제공받은 PDU Session ID에 대한 SMF와의 association이 없을 경우(e.g. Request Type이 "initial request"), AMF는 Nsmf_PDUSession_CreateSMContext Request를 invoke한다. 그러나 AMF가 이미 UE로부터 제공받은 PDU Session ID에 대한 SMF와의 association을 갖고 있는 경우(e.g. Request Type이 "existing PDU Session"), AMF는 Nsmf_PDUSession_UpdateSMContext Request를 invoke한다.

AMF는 Allowed NSSAI에서 Serving PLMN의 S-NSSAI를 SMF에게 전송한다. local breakout(LBO)에서 로밍 시나리오의 경우에는 AMF가 Mapping Of Allowed NSSAI에서 해당하는 HPLMN의 S-NSSAI를 SMF에게 전송한다.

AMF ID는 UE를 serving하는 AMF를 고유하게 식별하는 UE의 GUAMI이다. AMF는 UE로부터 수신한 PDU Session Establishment Request가 포함된 N1 SM container와 함께 PDU Session ID를 forward한다. GPSI는 AMF에서 사용 가능한 경우 포함되어야 한다.

AMF는 Access Type과 RAT Type을 결정한다. 4.2.2.2.1절 참고.

UE가 제한된 서비스 상태에서 SUPI를 제공하지 않고 Emergency services(i.e. Emergency Registered)에 register한 경우, AMF는 SUPI 대신 PEI를 제공한다. PEI는 23.501의 5.9.3절에 정의되어있다. 만약 UE가 제한된 서비스 상태에서  인증되지 않은 SUPI를 제공하여 Emergency services(i.e. Emergency Registered)에 register한 경우에는 AMF에서 SUPI가 인증되지 않았음을 표시한다. SMF는 UE에 대한 SUPI를 수신하지 못하거나 AMF가 SUPI가 인증되지 않았다고 표시할 때 UE가 인증되지 않았다고 판단한다.

만약 AMF가 selected DNN이 LADN에 해당하는 것으로 판단하면, AMF는 "UE presence in LADN service area"를 제공한다. 이는 UE가 LADN service area의 IN인지 OUT인지를 나타낸다.

만약 step 1에 Old PDU Session ID이 포함되어 있고 SMF가 재할당되지 않아야 하는 경우에, AMF는 Nsmf_PDUSession_CreateSMContext Request에 Old PDU Session ID를 포함시킨다.

DNN Selection Mode는 AMF에 의해 결정된다. 이는 UE가 PDU Session Establishment Request에서 명시적(explicitly) subscribed DNN을 제공했는지 여부를 나타낸다.

SMF는 DNN Selection Mode를 사용하여 UE의 request를 accept할지 reject할지 결정할 수 있다.

Registration 절차 또는 Service Request 절차 도중 AN parameters로 수신된 Establishment cause가 priority services(e.g. MPS, MCS)와 관련이 있는 경우, AMF는 priority정보를 나타내기 위해 Message Priority header를 포함합니다. SMF는 Message Priority header를 사용하여 UE request가 NAS level congestion control 대상인지 여부를 판단한다. 다른 NF들은 priority 정보를 29.500에 명시된 service-based interfaces에서 Message Priority header를 포함하여 relay한다.

In the local breakout case, if the SMF (in the VPLMN) is not able to process some part of the N1 SM information that Home Routed Roaming is required and the SMF responds to the AMF that it is not the right SMF to handle the N1 SM message by invoking Nsmf_PDUSession_CreateSMContext Response service operation. The SMF includes a proper N11 cause code triggering the AMF to proceed with home routed case. The procedure starts again at step 2 of clause 4.3.2.2.2. 

The AMF may include a PCF ID in the Nsmf_PDUSession_CreateSMContext Request. This PCF ID identifies the H-PCF in the non-roaming case and the V-PCF in the local breakout roaming case. 

The AMF includes Trace Requirements if Trace Requirements have been received in subscription data. 

If the AMF decides to use the Control Plane CIoT 5GS Optimisation or User Plane CIoT 5GS Optimisation as specified in step 2 or to only use Control Plane CIoT 5GS Optimisation for the PDU session as described in clause 5.31.4 of TS 23.501 [2], the AMF sends the Control Plane CIoT 5GS Optimisation indication or Control Plane Only indicator to the SMF. 

If the AMF determines that the RAT type is NB-IoT and the number of PDU Sessions with user plane resources activated for the UE has reached the maximum number of supported user plane resources (0, 1 or 2) based on whether the UE supports UP data transfer and the UE's 5GMM Core Network Capability as described in Clause 5.31.19 of TS 23.501 [2], the AMF may either reject the PDU Session Establishment Request or continue with the PDU Session establishment and include the Control Plane CIoT 5GS Optimisation indication or Control Plane Only indicator to the SMF. 

The AMF includes the latest Small Data Rate Control Status if it has stored it for the PDU Session. 

If the RAT type was included in the message, then the SMF stores the RAT type in SM Context. 

If the UE supports CE mode B and and use of CE mode B is not restricted according to the Enhanced Coverage Restriction information in the UE context in the AMF, then the AMF shall include the extended NAS-SM timer indication. Based on the extended NAS-SM timer indication, the SMF shall use the extended NAS-SM timer setting for the UE as specified in TS 24.501 [25].

---

## 4. Subscription retrieval / Subscription for updates

If Session Management Subscription data for corresponding SUPI, DNN and S-NSSAI of the HPLMN is not available, then SMF retrieves the Session Management Subscription data using Nudm_SDM_Get (SUPI, Session Management Subscription data, selected DNN, S-NSSAI of the HPLMN, Serving PLMN ID, [NID]) and subscribes to be notified when this subscription data is modified using Nudm_SDM_Subscribe (SUPI, Session Management Subscription data, selected DNN, S-NSSAI of the HPLMN, Serving PLMN ID, [NID]). UDM may get this information from UDR by Nudr_DM_Query (SUPI, Subscription Data, Session Management Subscription data, selected DNN, S-NSSAI of the HPLMN, Serving PLMN ID, [NID]) and may subscribe to notifications from UDR for the same data by Nudr_DM_subscribe. 

The SMF may use DNN Selection Mode when deciding whether to retrieve the Session Management Subscription data e.g. if the (selected DNN, S-NSSAI of the HPLMN) is not explicitly subscribed, the SMF may use local configuration instead of Session Management Subscription data. 

If the Request Type in step 3 indicates "Existing PDU Session" or "Existing Emergency PDU Session" the SMF determines that the request is due to switching between 3GPP access and non-3GPP access or due to handover from EPS. The SMF identifies the existing PDU Session based on the PDU Session ID. In such a case, the SMF does not create a new SM context but instead updates the existing SM context and provides the representation of the updated SM context to the AMF in the response. 

If the Request Type is "Initial request" and if the Old PDU Session ID is included in Nsmf_PDUSession_CreateSMContext Request, the SMF identifies the existing PDU Session to be released based on the Old PDU Session ID. 

Subscription data includes the Allowed PDU Session Type(s), Allowed SSC mode(s), default 5QI and ARP, subscribed Session-AMBR, SMF-Associated external parameters. 

Static IP address/prefix may be included in the subscription data if the UE has subscribed to it. 

The SMF checks the validity of the UE request: it checks 
- Whether the UE request is compliant with the user subscription and with local policies; 
- (If the selected DNN corresponds to an LADN), whether the UE is located within the LADN service area 
based on the "UE presence in LADN service area" indication from the AMF. If the AMF does not provide the "UE presence in LADN service area" indication and the SMF determines that the selected DNN corresponds to a LADN, then the SMF considers that the UE is OUT of the LADN service area. 

The SMF determines whether the PDU Session requires redundancy and the SMF determines the RSN as described in clause 5.33.2.1 of TS 23.501 [2]. If the SMF determines that redundant handling is not allowed or not possible for the given PDU Session, the SMF shall either reject the establishment of the PDU Session or accept the establishment of a PDU session without redundancy handling based on local policy. 

If the UE request is considered as not valid, the SMF decides to not accept to establish the PDU Session. 

> NOTE 3: The SMF can, instead of the Nudm_SDM_Get service operation, use the Nudm_SDM_Subscribe service operation with an Immediate Report Indication that triggers the UDM to immediately return the subscribed data if the corresponding feature is supported by both the SMF and the UDM. 

---

## 5. Nsmf_PDUSession_CreateSMContext Response

From SMF to AMF: Either Nsmf_PDUSession_CreateSMContext Response (Cause, SM Context ID or N1 SM container (PDU Session Reject (Cause))) or an Nsmf_PDUSession_UpdateSMContext Response depending on the request received in step 3. 

If the SMF received Nsmf_PDUSession_CreateSMContext Request in step 3 and the SMF is able to process the PDU Session establishment request, the SMF creates an SM context and responds to the AMF by providing an SM Context ID. 

If the UP Security Policy for the PDU Session is determined to have Integrity Protection set to "Required", the SMF may, based on local configuration, decide whether to accept or reject the PDU Session request based on the UE Integrity Protection Maximum Data Rate. 

> NOTE 4: The SMF can e.g. be configured to reject a PDU Session if the UE Integrity Protection Maximum Data Rate has a very low value, if the services provided by the DN would require higher bitrates. 

When the SMF decides to not accept to establish a PDU Session, the SMF rejects the UE request via NAS SM signalling including a relevant SM rejection cause by responding to the AMF with Nsmf_PDUSession_CreateSMContext Response. The SMF also indicates to the AMF that the PDU Session ID is to be considered as released, the SMF proceeds to step 20 and the PDU Session Establishment procedure is stopped.

---

## 6. PDU Session authentication / authorization

Optional Secondary authentication/authorization. 

If the Request Type in step 3 indicates "Existing PDU Session", the SMF does not perform secondary authentication/authorization. 

If the Request Type received in step 3 indicates "Emergency Request" or "Existing Emergency PDU Session", the SMF shall not perform secondary authentication\authorization. 

If the SMF needs to perform secondary authentication/authorization during the establishment of the PDU Session by a DN-AAA server as described in clause 5.6.6 of TS 23.501 [2], the SMF triggers the PDU Session establishment authentication/authorization as described in clause 4.3.2.3. 

---

## 7a. PCF selection

If dynamic PCC is to be used for the PDU Session, the SMF performs PCF selection as described in clause 6.3.7.1 of TS 23.501 [2]. If the Request Type indicates "Existing PDU Session" or "Existing Emergency PDU Session", the SMF shall use the PCF already selected for the PDU Session. 

Otherwise, the SMF may apply local policy. 

---

## 7b. SM Policy Association Establishment or SMF initiated SM Policy Association Modification

The SMF may perform an SM Policy Association Establishment procedure as defined in clause 4.16.4 to establish an SM Policy Association with the PCF and get the default PCC Rules for the PDU Session. The SMF shall include the 3GPP Data Off status if received in step 1. The GPSI shall be included if available at SMF. If the Request Type in step 3 indicates "Existing PDU Session", the SMF provides information on the Policy Control Request Trigger condition(s) that have been met by an SMF initiated SM Policy Association Modification procedure as defined in clause 4.16.5.1. The PCF may provide policy information defined in clause 5.2.5.4 (and in TS 23.503 [20]) to SMF. 

The PCF, based on the Emergency DNN, sets the ARP of the PCC rules to a value that is reserved for 
Emergency services as described in TS 23.503 [20]. 

> NOTE 5: The purpose of step 7 is to receive PCC rules before selecting UPF. If PCC rules are not needed as input for UPF selection, step 7 can be performed after step 8.

---

## 8. UPF selection

If the Request Type in step 3 indicates "Initial request", the SMF selects an SSC mode for the PDU Session as described in clause 5.6.9.3 of TS 23.501 [2]. The SMF also selects one or more UPFs as needed as described in clause 6.3.3 of TS 23.501 [2]. In the case of PDU Session Type IPv4 or IPv6 or IPv4v6, the SMF allocates an IP address/prefix for the PDU Session (unless configured otherwise) as described in clause 5.8.2 of TS 23.501 [2]. In the case of PDU Session Type IPv6 or IPv4v6, the SMF also allocates an interface identifier to the UE for the UE to build its link-local address. For Unstructured PDU Session Type the SMF may allocate an IPv6 prefix for the PDU Session and N6 point-to-point tunnelling (based on UDP/IPv6) as described in clause 5.6.10.3 of TS 23.501 [2]. For Ethernet PDU Session Type, neither a MAC nor an IP address is allocated by the SMF to the UE for this PDU Session. 

If the AMF indicated Control Plane CIoT 5GS Optimisation in step 3 for this PDU session, then, 

1. For Unstructured PDU Session Type, the SMF checks whether UE's subscription include a "NEF Identity for NIDD" for the DNN/S-NSSAI combination. When the "NEF Identity for NIDD" is present in the UE's subscription data, the SMF will select the NEF identified for the S-NSSAI and selected DNN in the "NEF Identity for NIDD" as the anchor of this PDU Session. Otherwise, the SMF will select a UPF as the anchor of this PDU Session. 
2. For other PDU Session Types, the SMF will perform UPF selection to select a UPF as the anchor of this 
PDU Session. 

If the Request Type in Step 3 is "Existing PDU Session", the SMF maintains the same IP address/prefix that has already been allocated to the UE in the source network. 

If the Request Type in step 3 indicates "Existing PDU Session" referring to an existing PDU Session moved between 3GPP access and non-3GPP access the SMF maintains the SSC mode of the PDU Session, the current PDU Session Anchor and IP address. 

> NOTE 6: The SMF may decide to trigger e.g. new intermediate UPF insertion or allocation of a new UPF as described in step 5 in clause 4.2.3.2. 

If the Request Type indicates "Emergency Request", the SMF selects the UPF as described in clause 5.16.4 of TS 23.501 [2] and selects SSC mode 1. 

SMF may select a UPF (e.g. based on requested DNN/S-NSSAI) that supports NW-TT functionality.

---

## 9. SMF initiated SM Policy Association Modification

SMF may perform an SMF initiated SM Policy Association Modification procedure as defined in clause 4.16.5.1 to provide information on the Policy Control Request Trigger condition(s) that have been met. If Request Type is "initial request" and dynamic PCC is deployed and PDU Session Type is IPv4 or IPv6 or IPv4v6, SMF notifies the PCF (if the Policy Control Request Trigger condition is met) with the allocated UE IP address/prefix(es). 

> NOTE 7: If an IP address/prefix has been allocated before step 7 (e.g. subscribed static IP address/prefix in UDM/UDR) or the step 7 is perform after step 8, the IP address/prefix can be provided to PCF in step 7 and the IP address/prefix notification in this step can be skipped. 

PCF may provide updated policies to the SMF. The PCF may provide policy information defined in clause 5.2.5.4 (and in TS 23.503 [20]) to SMF. 

---

## 10.

If Request Type indicates "initial request", the SMF initiates an N4 Session Establishment procedure with the selected UPF(s), otherwise it initiates an N4 Session Modification procedure with the selected UPF(s): 

## 10a. N4 Session Establishment / Modification Request

The SMF sends an N4 Session Establishment/Modification Request to the UPF and provides Packet detection, enforcement and reporting rules to be installed on the UPF for this PDU Session. If the SMF is configured to request IP address allocation from UPF as described in clause 5.8.2 of TS 23.501 [2] then the SMF indicates to the UPF to perform the IP address/prefix allocation and includes the information required for the UPF to perform the allocation. If the selective User Plane deactivation is required for this PDU Session, the SMF determines the Inactivity Timer and provides it to the UPF. The SMF provides Trace Requirements to the UPF if it has received Trace Requirements. If the Reliable Data Service is enabled for the PDU Session by the SMF as specified in TS 23.501 [2], the RDS Configuration information is provided to the UPF in this step. The SMF provides Small Data Rate Control parameters to the UPF for the PDU Session, if required. The SMF provides the Small Data Rate Control Status to the UPF, if received from the AMF. If the Serving PLMN intends to enforce Serving PLMN Rate Control (see clause 5.31.14.2 of TS 23.501 [2]) for this PDU session then the SMF shall provide Serving PLMN Rate Control parameters to UPF for limiting the rate of downlink control plane data packets. 

For a PDU Session of type Ethernet, SMF (e.g. for a certain requested DNN/S-NSSAI) may include an indication to request UPF to provide port numbers. 

If SMF decides to perform redundant transmission for one or more QoS Flows of the PDU session as described in clause 5.33.1.2 of TS 23.501 [2], two CN Tunnel Info are requested by the SMF from the UPF. The SMF also indicates the UPF to eliminate the duplicated packet for the QoS Flow in uplink direction. The SMF indicates the UPF that one CN Tunnel Info is used as the redundancy tunnel of the PDU session described in clause 5.33.2.2 of TS 23.501 [2]. 

If SMF decides to insert two I-UPFs between the PSA UPF and the NG-RAN for redundant transmission as described in clause 5.33.1.2 of TS 23.501 [2], the SMF requests the corresponding CN Tunnel Info and provides them to the I-UPFs and PSA UPF respectively. The SMF also indicates the PSA UPF to eliminate the duplicated packet for the QoS Flow in uplink direction. The SMF indicates the PSA UPF that one CN Tunnel Info is used as the redundancy tunnel of the PDU session described in clause 5.33.2.2 of 
TS 23.501 [2]. 

> NOTE 8: The method to perform elimination and reordering on RAN/UPF based on the packets received from the two GTP-U tunnels is up to RAN/UPF implementation. The two GTP-U tunnels are terminated at the same RAN node and UPF. 

If Control Plane CIoT 5GS Optimisation is enabled for this PDU session and the SMF selects the NEF as the anchor of this PDU Session in step 8, the SMF performs SMF-NEF Connection Establishment Procedure as described in clause 4.25.2. 

---

## 10b. N4 Session Establishment / Modification Response

The UPF acknowledges by sending an N4 Session Establishment/Modification Response. 

If the SMF indicates in step 10a that IP address/prefix allocation is to be performed by the UPF then this response contains the requested IP address/prefix. The requested CN Tunnel Info is provided to SMF in this step. If SMF indicated the UPF to perform packet duplication and elimination for the QoS Flow in step 10a, two CN Tunnel Info are allocated by the UPF and provided to the SMF. If SMF decides to insert two I-UPFs between the PSA UPF and the NG-RAN for redundant transmission as described in clause 5.33.1.2 of TS 23.501 [2], CN Tunnel Info of two I-UPFs and the UPF (PSA) are allocated by the UPFs and provided to the SMF. The UPF indicates the SMF that one CN Tunnel Info is used as the redundancy tunnel of the PDU session as described in clause 5.33.2.2 of TS 23.501 [2]. 

If SMF requested UPF to provide port numbers then UPF includes the DS-TT port and Bridge ID in the response according to TS 23.501 [2]. 

If multiple UPFs are selected for the PDU Session, the SMF initiate N4 Session Establishment/Modification procedure with each UPF of the PDU Session in this step. 

> NOTE 9: If the PCF has subscribed to the UE IP address change Policy Control Trigger (as specified in clause 6.1.3.5 of TS 23.503 [20]) then the SMF notifies the PCF about the IP address/prefix allocated by the UPF. This is not shown in figure 4.3.2.2.1-1.

---

## 11. Namf_Communication_N1N2MessageTransfer

SMF to AMF: Namf_Communication_N1N2MessageTransfer (PDU Session ID, N2 SM information (PDU Session ID, QFI(s), QoS Profile(s), CN Tunnel Info, S-NSSAI from the Allowed NSSAI, Session-AMBR, PDU Session Type, User Plane Security Enforcement information, UE Integrity Protection Maximum Data Rate, RSN), N1 SM container (PDU Session Establishment Accept ([QoS Rule(s) and QoS Flow level QoS parameters if needed for the QoS Flow(s) associated with the QoS rule(s)], selected SSC mode, S-NSSAI(s), UE Requested DNN, allocated IPv4 address, interface identifier, Session-AMBR, selected PDU Session Type, [Reflective QoS Timer] (if available), [P-CSCF address(es)], [Control Plane Only indicator], [Header Compression Configuration], [Always-on PDU Session Granted], [Small Data Rate Control parameters], [Small Data Rate Control Status], [Serving PLMN Rate Control]))). If multiple UPFs are used for the PDU Session, the CN Tunnel Info contains tunnel information related with the UPFs that terminate N3. 

The SMF may provide the SMF derived CN assisted RAN parameters tuning to the AMF by invoking Nsmf_PDUSession_SMContextStatusNotify (SMF derived CN assisted RAN parameters tuning) service. The AMF stores the SMF derived CN assisted RAN parameters tuning in the associated PDU Session context for this UE. 

The N2 SM information carries information that the AMF shall forward to the (R)AN which includes: 

- The CN Tunnel Info corresponds to the Core Network address(es) of the N3 tunnel corresponding to the PDU Session. If two CN Tunnel Info are included for the PDU session for redundant transmission, the SMF also indicates the NG-RAN that one of the CN Tunnel Info used as the redundancy tunnel of the PDU session as described in clause 5.33.2.2 of TS 23.501 [2]. 
- One or multiple QoS profiles and the corresponding QFIs can be provided to the (R)AN. This is further described in clause 5.7 of TS 23.501 [2]. The SMF may indicate for each QoS Flow whether redundant transmission shall be performed by a corresponding redundant transmission indicator. 
- The PDU Session ID may be used by AN signalling with the UE to indicate to the UE the association between (R)AN resources and a PDU Session for the UE. 
- A PDU Session is associated to an S-NSSAI of the HPLMN and, if applicable, to a S-NSSAI of the VPLMN and a DNN. The S-NSSAI provided to the (R)AN, is the S-NSSAI with the value for the Serving PLMN (i.e. the HPLMN S-NSSAI or, in LBO roaming case, the VPLMN S-NSSAI). 
- User Plane Security Enforcement information is determined by the SMF as described in clause 5.10.3 of TS 23.501 [2]. 
- If the User Plane Security Enforcement information indicates that Integrity Protection is "Preferred" or "Required", the SMF also includes the UE Integrity Protection Maximum Data Rate as received in the PDU Session Establishment Request. 
- The use of the RSN parameter by NG-RAN is described in clause 5.33.2.1 of TS 23.501 [2]. 

The N1 SM container contains the PDU Session Establishment Accept that the AMF shall provide to the UE. If the UE requested P-CSCF discovery then the message shall also include the P-CSCF IP address(es) as determined by the SMF and as described in clause 5.16.3.4 of TS 23.501 [2]. The PDU Session Establishment Accept includes S-NSSAI from the Allowed NSSAI. For LBO roaming scenario, the PDU Session Establishment Accept includes the S-NSSAI from the Allowed NSSAI for the VPLMN and also it includes the corresponding S-NSSAI of the HPLMN from the Mapping Of Allowed NSSAI that SMF received in step 3. 

If the PDU Session being established was requested to be an always-on PDU Session, the SMF shall indicate whether the request is accepted by including an Always-on PDU Session Granted indication in the PDU Session Establishment Accept message. If the PDU Session being established was not requested to be an always-on PDU Session but the SMF determines that the PDU Session needs to be established as an always-on PDU Session, the SMF shall include an Always-on PDU Session Granted indication in the PDU Session Establishment Accept message indicating that the PDU session is an always-on PDU Session. 

If Control Plane CIoT 5GS Optimisation is enabled for this PDU session, the N2 SM information is not included in this step. If Control Plane CIoT 5GS optimisation is enabled for this PDU session and the UE has sent the Header Compression Configuration in the PDU Session Establishment Request and the SMF supports the header compression parameters, the SMF shall include the Header Compression Configuration in the PDU Session Establishment Accept message. If the UE has included Header Compression context parameters in Header Compression Configuration in the PDU Session Establishment Request, the SMF shall establish the header compression context and may acknowledge the Header Compression context parameters. If the header compression context is not established during the PDU Session Establishment procedure, before using the compressed format for sending the data, the UE and the SMF need to establish the header compression context based on the Header Compression Configuration. If the SMF has received the Control Plane Only Indicator in step 3, the SMF shall include the Control Plane Only Indicator in the PDU Session Establishment Accept message. The SMF shall indicate the use of Control Plane only on its CDR. If the Small Data Rate Control is configured in the SMF, the SMF shall also include Small Data Rate Control parameters and the Small Data Rate Control Status (if received from the AMF) in the PDU Session Establishment Accept message as described inclause 5.31.14.3 of TS 23.501 [2]. If the Serving PLMN intends to enforce Serving PLMN Rate Control (see clause 5.31.14.2 of TS 23.501 [2]) for this PDU session then the SMF shall include the Serving PLMN Rate Control parameters in the PDU Session Establishment Accept message. The UE shall store and use Serving PLMN Rate Control parameters as the maximum allowed limit of uplink control plane user data. 

If the UE indicates the support of RDS in the PCO in the PDU Session Establishment Request and RDS is enabled for the PDU Session, the SMF shall inform the UE that RDS is enabled in the PCO in the PDU Session Establishment Accept (see clause 5.31.6 of TS 23.501 [2]). 

If the NIDD parameters (e.g. maximum packet size) were received from NEF during the SMF-NEF Connection Establishment procedure in step 10, the SMF shall inform the UE of the NIDD parameters in the PCO in the PDU Session Establishment Accept (see clause 5.31.5 of TS 23.501 [2]). 

Multiple QoS Rules, QoS Flow level QoS parameters if needed for the QoS Flow(s) associated with those QoS rule(s) and QoS Profiles may be included in the PDU Session Establishment Accept within the N1 SM and in the N2 SM information. 

The Namf_Communication_N1N2MessageTransfer contains the PDU Session ID allowing the AMF to know which access towards the UE to use. 

If the PDU session establishment failed anywhere between step 5 and step 11, then the Namf_Communication_N1N2MessageTransfer request shall include the N1 SM container with a PDU Session Establishment Reject message (see clause 8.3.3 of TS 24.501 [25]) and shall not include any N2 SM container. The (R)AN sends the NAS message containing the PDU Session Establishment Reject to the UE. In this case, steps 12-17 are skipped. 

---

## 12. N2 PDU Session Request (NAS msg)

AMF to (R)AN: N2 PDU Session Request (N2 SM information, NAS message (PDU Session ID, N1 SM container (PDU Session Establishment Accept)), [CN assisted RAN parameters tuning]). If the N2 SM information is not included in the step 11, an N2 Downlink NAS Transport message is used instead. 

The AMF sends the NAS message containing PDU Session ID and PDU Session Establishment Accept targeted to the UE and the N2 SM information received from the SMF within the N2 PDU Session Request to the (R)AN. 

If the SMF derived CN assisted RAN parameters tuning are stored for the activated PDU Session(s), the AMF may derive updated CN assisted RAN parameters tuning and provide them the (R)AN.

---

## 13. AN-specific resource setup (PDU Session Establishment Accept)

(R)AN to UE: The (R)AN may issue AN specific signalling exchange with the UE that is related with the information received from SMF. For example, in the case of a NG-RAN, an RRC Connection Reconfiguration may take place with the UE establishing the necessary NG-RAN resources related to the QoS Rules for the PDU Session request received in step 12. 

(R)AN also allocates (R)AN Tunnel Info for the PDU Session. In the case of Dual Connectivity, the Master RAN node may assign some (zero or more) QFIs to be setup to a Master RAN node and others to the Secondary RAN node. The AN Tunnel Info includes a tunnel endpoint for each involved (R)AN node and the QFIs assigned to each tunnel endpoint. A QFI can be assigned to either the Master RAN node or the Secondary RAN node and not to both. 

If the (R)AN receives two CN Tunnel Info for a PDU session in step 12 for redundant transmission, (R)AN also allocates two AN Tunnel Info correspondingly and indicate to SMF one of the AN Tunnel Info is used as the redundancy tunnel of the PDU session as described in clause 5.33.2.2 of TS 23.501 [2]. 

(R)AN forwards the NAS message (PDU Session ID, N1 SM container (PDU Session Establishment Accept)) provided in step 12 to the UE. (R)AN shall only provide the NAS message to the UE if the AN specific signalling exchange with the UE includes the (R)AN resource additions associated to the received N2 command. 

If MICO mode is active and the NAS message Request Type in step 1 indicated "Emergency Request", then the UE and the AMF shall locally deactivate MICO mode. 

If the N2 SM information is not included in the step 11, then the following steps 14 to 16b and step 17 are omitted. 

---

## 14. N2 PDU Session Response

(R)AN to AMF: N2 PDU Session Response (PDU Session ID, Cause, N2 SM information (PDU Session ID, AN Tunnel Info, List of accepted/rejected QFI(s), User Plane Enforcement Policy Notification)). 

The AN Tunnel Info corresponds to the Access Network address of the N3 tunnel corresponding to the PDU Session. 

If the (R)AN rejects QFI(s) the SMF is responsible of updating the QoS rules and QoS Flow level QoS parameters if needed for the QoS Flow associated with the QoS rule(s) in the UE accordingly. 

The NG-RAN rejects the establishment of UP resources for the PDU Session when it cannot fulfil User Plane Security Enforcement information with a value of Required. The NG-RAN notifies the SMF when it cannot 
fulfil a User Plane Security Enforcement with a value of Preferred. 

If the NG-RAN cannot establish redundant user plane for the PDU Session as indicated by the RSN parameter, the NG-RAN takes the decision on whether to reject the establishment of RAN resources for the PDU Session based on local policies as described in TS 23.501 [2].

---

## *First Uplink Data*

---

## 15. Nsmf_PDUSession_UpdateSMContext Request

AMF to SMF: Nsmf_PDUSession_UpdateSMContext Request (SM Context ID, N2 SM information, Request Type). 

The AMF forwards the N2 SM information received from (R)AN to the SMF. 

If the list of rejected QFI(s) is included in N2 SM information, the SMF shall release the rejected QFI(s) associated QoS profiles. 

If the N2 SM information indicates failure of user plane resource setup, the SMF shall reject the PDU session establishment by including a N1 SM container with a PDU Session Establishment Reject message (see clause 8.3.3 of TS 24.501 [25]) in the Nsmf_PDUSession_UpdateSMContext Response in step 17. Step 16 is skipped in this case and instead the SMF releases the N4 Session with UPF. 

If the User Plane Enforcement Policy Notification in the N2 SM information indicates that no user plane resources could be established and the User Plane Enforcement Policy indicated "required" as described in clause 5.10.3 of TS 23.501 [2], the SMF shall reject the PDU session establishment by including a N1 SM container with a PDU Session Establishment Reject message (see clause 8.3.3 of TS 24.501 [25]) in the Nsmf_PDUSession_UpdateSMContext Response in step 17. Step 16 is skipped in this case.

---

## 16a. N4 Session Modification Request

The SMF initiates an N4 Session Modification procedure with the UPF. The SMF provides AN Tunnel Info to the UPF as well as the corresponding forwarding rules. 

If SMF decides to perform redundant transmission for one or more QoS Flows of the PDU, the SMF also indicates the UPF to perform packet duplication for the QoS Flow(s) in downlink direction by forwarding rules. 

In the case of redundant transmission with two I-UPFs for one or more QoS Flows of the PDU, the SMF provides AN Tunnel Info to two I-UPFs and also indicates the UPF (PSA) to perform packet duplication for the QoS Flow(s) in downlink direction by forwarding rules. The SMF also provides the UL Tunnel Info of the UPF (PSA) to the two I-UPFs and the DL Tunnel Info of the two I-UPFs to the UPF (PSA). 

> NOTE 10: If the PDU Session Establishment Request was due to mobility between 3GPP and non-3GPP access or mobility from EPC, the downlink data path is switched towards the target access in this step. 

---

## 16b. N4 Session Modification Response

The UPF provides an N4 Session Modification Response to the SMF. 

If multiple UPFs are used in the PDU Session, the UPF in step 16 refers to the UPF terminating N3. 

After this step, the UPF delivers any down-link packets to the UE that may have been buffered for this PDU Session. 

---

## 16c. Registration

If Request Type in step 3 indicates neither "Emergency Request" nor "Existing Emergency PDU Session" and, if the SMF has not yet registered for this PDU Session, then the SMF registers with the UDM using Nudm_UECM_Registration (SUPI, DNN, S-NSSAI, PDU Session ID, SMF Identity, Serving PLMN ID, [NID]) for a given PDU Session. As a result, the UDM stores following information: SUPI, SMF identity and the associated DNN, S-NSSAI, PDU Session ID and Serving Network (PLMN ID, [NID], see clause 5.18 of TS 23.501 [2]). The UDM may further store this information in UDR by Nudr_DM_Update (SUPI, Subscription Data, UE context in SMF data). 

If the Request Type received in step 3 indicates "Emergency Request": 

- For an authenticated non-roaming UE, based on operator configuration (e.g. related with whether the operator uses a fixed SMF for Emergency calls, etc.), the SMF may register in the UDM usingNudm_UECM_Registration (SUPI, PDU Session ID, SMF identity, Indication of Emergency Services) for a given PDU Session that is applicable for emergency services. As a result, the UDM shall store the applicable PDU Session for Emergency services. 
- For an unauthenticated UE or a roaming UE, the SMF shall not register in the UDM for a given PDU Session.

---

## *First Downlink Data*

---

## 17. Nsmf_PDUSession_UpdateSMContext Response

SMF to AMF: Nsmf_PDUSession_UpdateSMContext Response (Cause). 

The SMF may subscribe to the UE mobility event notification from the AMF (e.g. location reporting, UE moving into or out of Area Of Interest), after this step by invoking Namf_EventExposure_Subscribe service operation as specified in clause 5.2.2.3.2. For LADN, the SMF subscribes to the UE moving into or out of LADN service area event notification by providing the LADN DNN as an indicator for the Area Of Interest (see clause 5.6.5 and 5.6.11 of TS 23.501 [2]). 

After this step, the AMF forwards relevant events subscribed by the SMF.

---

## 18. Nsmf_PDUSession_SMContextStatusNotify

\[Conditional\] SMF to AMF: Nsmf_PDUSession_SMContextStatusNotify (Release) 

If during the procedure, any time after step 5, the PDU Session establishment is not successful, the SMF informs the AMF by invoking Nsmf_PDUSession_SMContextStatusNotify (Release). The SMF also releases any N4 session(s) created, any PDU Session address if allocated (e.g. IP address) and releases the association with PCF, if any. In this case, step 19 is skipped. 

---

## 19. IPv6 Address Configuration

SMF to UE: In the case of PDU Session Type IPv6 or IPv4v6, the SMF generates an IPv6 Router Advertisement and sends it to the UE. If Control Plane CIoT 5GS Optimisation is enabled for this PDU Session the SMF sends the IPv6 Router Advertisement via the AMF for transmission to the UE using the Mobile Terminated Data Transport in Control Plane CIoT 5GS Optimisation procedures (see clause 4.24.2), otherwise the SMF sends the IPv6 Router Advertisement via N4 and the UPF. 

---

## 20. SMF initiated SM Policy Association Modification

When the trigger for 5GS Bridge information available is armed, then the SMF may initiate the SM Policy Association Modification as described in 4.16.5.1. 

If the UE has indicated support of transferring Port Management Information Containers, then SMF informs PCF that a 5GS Bridge information is available. SMF provides the 5GS Bridge information (e.g. 5GS Bridge ID, port number of the DS-TT Ethernet port, MAC address of the DS-TT Ethernet port and UE-DS-TT Residence Time as provided by the UE) to PCF. TSN AF calculates the bridge delay for each port pair, i.e. composed of DS-TT Ethernet port and NW-TT Ethernet port, using the UE-DS-TT Residence Time for all NW-TT Ethernet port(s) serving the 5GS Bridge indicated by the 5GS Bridge ID. If SMF received a Port Management Information Container from either the UE or the UPF, then SMF provides the Port Management Information Container and port number of the related port to the PCF as described in clause 5.28.3.2 of TS 23.501 [2]. If SMF received a Bridge Management Information Container from the UPF, then SMF provides the Bridge Management Information Container to the PCF as described in clause 5.28.3.2 of TS 23.501 [2]. 

---

## 21. Unsubscription

If the PDU Session establishment failed after step 4, the SMF shall perform the following: 

The SMF unsubscribes to the modifications of Session Management Subscription data for the corresponding (SUPI, DNN, S-NSSAI of the HPLMN), using Nudm_SDM_Unsubscribe (SUPI, Session Management Subscription data, DNN, S-NSSAI of the HPLMN), if the SMF is no more handling a PDU Session of the UE for this (DNN, S-NSSAI of the HPLMN). The UDM may unsubscribe to the modification notification from UDR by Nudr_DM_Unsubscribe (SUPI, Subscription Data, Session Management Subscription data, S-NSSAI of the HPLMN, DNN). 
