# AN Release(clause 4.2.6 of TS 23.502)

23.502(v16.15)의 4.2.6절에 있는 AN Release 절차에 대해 정리

## 4.2.6 AN Release 

이 절차는
- UE를 위한 (R)AN과 AMF간의 logical한 NG-AP signalling connection
- the associated N3 User Plane connections
- UE와 (R)AN 사이의 (R)AN 신호 연결
- the associated (R)AN resources

를 해제(release)하기 위해 사용된다.

NG-AP signalling connection이 (R)AN 또는 AMF failure로 인해 끊어졌을 때, (R)AN 또는 AMF는 아래 절차에 설명된 대로 로컬에서 AN release를 수행하며, (R)AN 과 AMF 간에 표시된 signalling을 사용하거나 의존하지 않는다. AN release로 인해 UE의 모든 User Plane connections가 비활성화 된다.

AN release는 다음과 같은 이유로 발생할 수 있다.

|원인|예시|
|---|---|
|(R)AN이 원인으로 시작되는 경우<br>((R)AN-initiated) |- O&M의 개입(intervention)<br>- Unspecified Failure(불특정 실패)<br>- (R)AN (e.g. Radio) 링크 Failure<br>- User Inactivity(유저가 활동하지 않음)<br>- Inter-System Redirection<br>- IMS voice를 위한 QoS Flow 설정 요청<br>- UE에서 생성한 신호연결 해제<br>- 이동 제한(mobility restriction)<br>- UE로부터의 Release Assistance Information(RAI)<br>- etc.|
|AMF가 원인으로 시작되는 경우<br>(AMF-initiated)|- Unspecified Failure<br>- etc.|

Figure 4.2.6-1에는 (R)AN-initiated 및 AMF-initiated AN Release 절차가 표시되어 있다.

만약 UE에 대해서 Service Gap Control이 적용되어야 한다면(23.501의 5.31.16절을 참고), 그리고 Service Gap timer가 이미 실행중이지 않는 경우에 Service Gap timer는 AMF와 UE에서 CM-IDLE로 진입할 때 시작되어야 한다.

다만 아래와 같은 경우에는 Service Gap timer를 시작하지 않아야 한다.
- 연결이 MT event의 paging 이후에 이루어진 경우
- Uplink 데이터 상태가 없는 Registration 절차 이후에 이루어진 경우
- Emergency services나 exception reporting 같은 규정 우선(regulatory prioritized) 서비스들에 대한 Registration 절차

이 절차에서, 영향을 받는 SMF와 UPF는 모두 UE를 서비스하는 PLMN 하에 있다. 예를 들어, Home Routed 로밍의 경우에 HPLMN의 SMF와 UPF는 관련되지 않는다(not involved).

![figure 4.2.6-1](images/Figure_4.2.6-1.AN_Release_procedure.png)

## 1a. (R)AN Connection Release / 1b. N2 UE Context Release Request

**만약 확인된 (R)AN의 상태(e.g. Radio Link Failure)가 있거나 다른 (R)AN의 내부적인 이유로 인해, (R)AN은 (R)AN에서 UE context release를 시작할 수 있다. 이 경우, (R)AN은 AMF로 N2 UE Context Release Request(Cause, List of PDU Session ID(s) with active N3 user plane) 메시지를 전송한다.**

 > Cause는 release의 reason을 나타낸다 (e.g. AN Link Failure, O&M intervention, unspecified failure, etc.).   
 > The List of PDU Session ID(s)는 UE의 (R)AN이 서비스하는 PDU Sessions를 나타낸다.

만약 (R)AN이 NG-RAN이면, 이 단계는 TS 38.413의 8.3.2절에서 설명된다. 만약 (R)AN이 N3IWF라면 이 단계는 4.12.4.2절에서 설명된다.

만약 release의 reason이 NG-RAN이 TS 36.331에 정의된 AS Release Assistance Indicator를 수신한 경우라면, NG-RAN은 즉시 RRC connection을 release하지 않고 N2 UE Context Release Request 메시지를 AMF로 전송해야 한다. 만약 AS RAI가 오직 단일 downlink transmission만 예상됨을 나타내는 경우, NG-RAN은 단일 downlink NAS PDU 또는 N3 data PDU가 전송된 후에만 N2 UE Context Release Request를 전송할 수 있다.

만약 N2 Context Release Request의 cause가 `user inactivity` 또는 `AS RAI`의 이유로 release가 요청되었다고 표시된 경우, AMF는 아직 처리되지 않은 MT traffic or signalling이 대기 중인지 여부를 알지 않는 한 AN Release 절차를 계속한다.

---

## 2. N2 UE Context Release Commnad

AMF에서 (R)AN으로 : AMF가 N2 UE Context Release Request 메시지를 수신하거나 내부 AMF 이벤트로 인해, AMF는 (R)AN으로 N2 UE Context Release Command (Cause)를 전송한다.
> 내부 AMF 이벤트 : Service Request 또는 Registration Request를 수신하여 another NAS signalling connection still via (R)AN을 설정하는 것을 포함한다.

Cause는 step 1에서 (R)AN으로부터의 Cause 또는 AMF event로 인한 Cause를 나타난다.
> 만약 (R)AN이 NG-RAN이라면 이 단계는 38.413의 8.3.3절에서 설명한다. 만약 (R)AN이 N3IWF/TNGF/W-AGF인 경우 이 단계는 4.12.4.2절 / 23.316 7.2.5절의 4.12a에서 설명한다.

만약 AMF가 another NAS signalling connection still via (R)AN을 설정하기 위해 Service Request 또는 Registration Request를 수신한 경우, UE를 성공적으로 인증한 후에 AMF는 old NAS signalling connection을 release한 다음, Service Request 또는 Registration Request 절차를 계속한다.

---

## 3. (R)AN Connection Release (Conditional)

(R)AN과 UE간의 연결(RRC connection or NWu connection)이 이미 release되지 않은 경우 (step 1), 다음 중 하나가 발생한다.

- a) (R)AN은 UE에게 (R)AN connection을 release하도록 요청한다. UE로부터 (R)AN connection release confirmation을 수신하면, (R)AN은 UE의 context를 삭제한다.
- b) N2 UE Context Release Command의 Cause가 UE가 이미 local에서 RRC connection을 release한 것을 나타내는 경우, (R)AN은 local에서 RRC connection을 release한다.

---

## 4. N2 UE Context Release Complete

(R)AN은 N2 Release를 confirm하기 위해 N2 UE Context Release Complete 메시지(활성화된 N3 user plane, User 위치 정보, 위치 정보의 Age를 포함하는 List of PDU Session ID(s))를 AMF에게 반환한다.

List of PDU Session ID(s)는 UE가 서비스되는 (R)AN의 PDU Sessions를 나타낸다. AMF는 NG-RAN 노드로부터 수신받은 항상 최신의 UE Radio Capability Information 또는 NB-IoT specific UE Radio Access Capability Information을 저장한다. 해당 UE에 대한 AMF와 (R)AN 간의 N2 signalling connection이 release된다.

만약 UE가 WUS를 지원하는 NG-eNB에 의해 서비스되는 경우, NG-eNB는 Paging을 위한 Recommended Cells And RAN 노드에 대한 정보를 포함해야 하며, 그렇지 않을 경우 (R)AN은 페이징을 위한 recommended cells / TAs / NG-RAN 노드 id의 목록을 AMF에 제공할 수 있다.

PLMN이 secondary RAT usage reporting을 구성(configure)한 경우, NG-RAN 노드는 RAN usage data Report를 제공할 수 있다.

이 단계는 step 2 이후에 즉시 수행되어야하며, 예를 들어 UE가 RRC 연결 해제를 승인하지 않는 상황에서 지연되어서는 안된다.

NG-RAN은 가능한 경우 CE capable UE에 대한 Paging Assistance를 N2 UE Context Release Complete 메시지에 포함한다. AMF는 수신받은 subsequent Paging 절차를 위해 수신된 CE capable UE를 위한 Paging Assistance Data를 UE Context에 저장한다.

---

## 5. Nsmf_PDUSession_UpdateSMContext Request (Conditional)

AMF에서 SMF로: N2 UE Context Release Complete의 각 PDU Session에 대해, AMF는 Nsmf_PDUSession_UpdateSMContext Request를 호출한다.

- PDU Session ID
- PDU Session Deactivation
- Cause
- Operation Type
- User Location Information
- Age of Location Information
- N2 SM Information (Secondary RAT usage data)

step 5에서의 Cause는 step 2에서의 Cause와 같다. 만약 step 1b에서, active N3 user plane과 함께 List of PDU Session ID(s)가 포함되었다면, step 2 전에 step 5에서 step 7가 먼저 수행된다. Operation Type이 "UP deactivate"로 설정된 것은 PDU Session에 대한 user plane resources가 deactivation 되었음을 나타낸다.

Control Plane CIoT 5GS Optimisation을 사용하는 PDU Session의 경우, 그리고 UE가 extended Idle mode DRX의 사용을 negotiate한 경우, AMF는 UE가 downlink data에 reachable하지 않다고 즉시 SMF에게 알린다.

Control Plane CIoT 5GS Optimisation을 사용하는 PDU Session의 경우, 그리고 UE가 Active Time으로 MICO mode를 사용하는 것으로 negotiate한 경우, AMF는 Active Time이 만료되면 UE가 downlink data에 reachable할 수 없음을 SMF에게 알린다.

---

## 6a. N4 Session Modification Request (Conditional)

SMF to UPF: N4 Session Modification Request (AN or N3 UPF Tunnel Info to be removed, Buffering on/off). 

SMF에서 UPF로: N4 Session Modification Request (제거할 AN 또는 N3 UPF 터널링 정보, 버퍼링 on/off)

For PDU Sessions not using Control Plane CIoT 5GS Optimisation, the SMF initiates an N4 Session Modification procedure indicating the need to remove Tunnel Info of AN or UPF terminating N3. Buffering on/off indicates whether the UPF shall buffer incoming DL PDU or not. 

If the SMF has received an indication from the AMF that the UE is not reachable for downlink data for PDU Sessions using Control Plane CIoT 5GS Optimisation, the SMF may initiate an N4 Session Modification procedure to activate buffering in the UPF. 

If multiple UPFs are used in the PDU Session and the SMF determines to release the UPF terminating N3, step 6a is performed towards the UPF (e.g. PSA) terminating N9 towards the current N3 UPF. The SMF then releases the N4 session towards the N3 UPF (the N4 release is not shown on the call flow). 

See clause 4.4 for more details. 

If the cause of AN Release is because of User Inactivity, or UE Redirection, the SMF shall preserve the GBR QoS Flows. Otherwise, the SMF shall trigger the PDU Session Modification procedure (see clause 4.3.3) for the GBR QoS Flows of the UE after the AN Release procedure is completed. 

If the redundant I-UPFs are used for URLLC, the N4 Session Modification Request procedure is done for each I-UPF. In this case, SMF selects both the redundant I-UPFs to buffer the DL packets for this PDU Session or drop the DL packets for this PDU session or forward the DL packets for this PDU session to the SMF, based on buffering instruction provided by the SMF as described in clause 5.8.3.2 or 5.8.3.3 of TS 23.501 [2]. 
 
If the redundant N3 tunnels are used for URLLC, the N4 Session Modification Request procedure to the UPF of N3 terminating point is to remove the dual AN Tunnel Info for N3 tunnel of the corresponding PDU Session.

---

## 6b. N4 Session modification Response (Conditional)

UPF to SMF: N4 Session Modification Response acknowledging the SMF request. 

See clause 4.4 for more details.

## 7. Nsmf_PDUSession_UpdateSMContext Response (Conditional)

SMF to AMF: Nsmf_PDUSession_UpdateSMContext Response for step 5. 

--- 

Upon completion of the procedure, the AMF considers the N2 and N3 as released and enters CM-IDLE state.

After completion of the procedure, the AMF reports towards the NF consumers are triggered for cases in clause 4.15.4. 

After completion of the procedure, if steps 5 to 7 were performed before step 2 and the AMF received N2 SM information from NG-RAN in step 4 (e.g. Secondary RAT usage data report), the AMF initiates a 
Nsmf_PDUSession_UpdateSMContext towards SMF to deliver the N2 SM information. 