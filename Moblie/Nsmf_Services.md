# Nsmf PDUSession Service

TS 29.502(v1614) Session Management Service 5.2절

## Nsmf_PDUSession Service

다른 NF가 PDU Session을 establish, modify, release할 수 있도록 하는 서비스

서비스의 주요 기능들
- PDU Session에 대한 SM Contexts의 생성, 수정, 삭제
    > SM Context는 NF Service Consumer(e.g. AMF)와 PDU Session에 대한 SMF 사이의 연관 관계(association)을 나타낸다.
- PDU Session에 대한 SM Contexts의 검색(retrieval) (i.e. UE EPS PDN connection 또는 complete SM context)
    > 예를 들어, PDU Session이 N26 인터페이스를 이용하여 EPC로 이동하거나 I-SMF 또는 V-SMF 간에 N38 인터페이스를 이용하여 SM contexts를 전송하는데 사용
- Creation, modification and deletion of PDU sessions between the V-SMF and H-SMF in HR roaming scenarios, or between the I-SMF and SMF for PDU sessions involving an I-SMF;
- Sending of mobile originated data (received over NAS) for a PDU session to the SMF, V-SMF in HR roaming scenarios, or I-SMF for PDU sessions involving an I-SMF; 
- Transferring of NEF anchored mobile originated data for a PDU session to the H-SMF in HR roaming scenarios, or SMF for PDU sessions involving an I-SMF; 
- Transferring of NEF anchored mobile terminated data for a PDU session to the V-SMF in HR roaming scenarios, or I-SMF for PDU sessions involving an I-SMF; 
- 정책 및 과금 rule을 PDU Session과 연관시키고 정책 및 과금 rule을 flow에 바인딩한다.
- N4를 통해 UPF와 상호 작용하여 User Plane Session을 생성, 수정, 해제한다.
- UPF로부터 User Plane event를 처리하고 해당 정책 및 과금 rule을 적용한다.

아래 표는 Nsmf_PDUSession service를 통해 지원가능한 Service Operations를 나타낸다.

| Service Operations       | Description                                                                                                                                                                                                                            | Operation Semantics                 | Example Consumer(s)      |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------- | ------------------------ |
| Create SM Context        | Create an SM context in SMF, or in V-SMF in HR roaming scenarios, or in I-SMF during the I-SMF insertion and                                                                                                                           | hange scenarios, for a PDU session. | Request/Response         | AMF |
| Update SM Context        | Update the SM context of a PDU session and/or provide the SMF with N1 or N2 SM information received from the UE or from the AN.                                                                                                        | Request/Response                    | AMF, I-SMF               |
| Release SM Context       | Release the SM context of a PDU session when the PDU session has been released.                                                                                                                                                        | Request/Response                    | AMF                      |
| Notify SM Context Status | Notify the NF Service Consumer about the status of an SM Context of a PDU session (e.g. the SM Context is released within the SMF).                                                                                                    | Subscribe/Notify                    | AMF                      |
| Retrieve SM Context      | Retrieve an SM context of a PDU session: - from SMF, or from V-SMF in HR roaming scenarios, for 5GS to EPS mobility; - from SMF during I-SMF insertion or from I-SMF during I-SMF change/removal; - from V-SMF during change of V-SMF. | Request/Response                    | AMF, I-SMF, V-SMF, SMF   |
| Create                   | Create a PDU session in the H-SMF in HR roaming scenarios, or in the SMF for PDU sessions involving an I-SMF.                                                                                                                          | Request/Response                    | V-SMF, I-SMF             |
| Update                   | Update a PDU session in the H-SMF or V-SMF in HR roaming scenarios, or in the I-SMF or SMF for PDU sessions involving an I-SMF.                                                                                                        | Request/Response                    | V-SMF, H-SMF, I-SMF, SMF |
| Release                  | Release a PDU session in the H-SMF in HR roaming scenarios, or in the SMF for PDU sessions involving an I-SMF.                                                                                                                         | Request/Response                    | V-SMF, I-SMF             |
| Notify Status            | Notify the NF Service Consumer about the status of a PDU session (e.g. the PDU session is released due to local reasons within the SMF).                                                                                               | Subscribe/Notify                    | V-SMF, I-SMF             |

(일부 생략)