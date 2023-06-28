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

UE에서 AMF로: NAS 메시지(S-NSSAI(s), UE가 요청한 DNN, PDU Session ID, Request type, 이전 PDU Session ID, N1 SM container(PDU Session Establishment Request, \[Port Management Information Container\])) 전송

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

---

## 4. Subscription retrieval / Subscription for updates

---

## 5. Nsmf_PDUSession_CreateSMContext Response

---

## 6. PDU Session authentication / authorization

---

## 7a. PCF selection

---

## 7b. SM Policy Association Establishment or SMF initiated SM Policy Association Modification

---

## 8. UPF selection

---

## 9. SMF initiated SM Policy Association Modification

---

## 10a. N4 Session Establishment / Modification Request

---

## 10b. N4 Session Establishment / Modification Response

---

## 11. Namf_Communication_N1N2MessageTransfer

---

## 12. N2 PDU Session Request (NAS msg)

---

## 13. AN-specific resource setup (PDU Session Establishment Accept)

---

## 14. N2 PDU Session Response

---

## *First Uplink Data*

---

## 15. Nsmf_PDUSession_UpdateSMContext Request

---

## 16a. N4 Session Modification Request

---

## 16b. N4 Session Modification Response

---

## 16c. Registration

---

## *First Downlink Data*

---

## 17. Nsmf_PDUSession_UpdateSMContext Response

---

## 18. Nsmf_PDUSession_SMContextStatusNotify

---

## 19. IPv6 Address Configuration

---

## 20. SMF initiated SM Policy Association Modification

---

## 21. Unsubscription

