# 3GPP 규격 보는 방법(Release, Stage 등)

3GPP 규격을 보면서, 궁금했던 부분들을 나열하고 찾은 내용들을 정리

##### _틀린 부분이 있을 수 있습니다. 지적 부탁드립니다._

## Release 가 뭐지?

3GPP uses a system of parallel "Releases" which provide developers with a stable platform for the implementation of features at a given point and then allow for the addition of new functionality in subsequent Releases.

3GPP는 개발자에게 주어진 시점에서 기능을 구현하기 위한 안정적인 플랫폼을 제공한 후 후속 릴리즈에서 새로운 기능을 추가할 수 있는 병렬 "릴리즈" 시스템을 사용한다. 

- [참고1](https://www.3gpp.org/specifications/releases)

## 왜 릴리즈를 나눠놨을까?

장비 개발자들이 해당 릴리즈까지의 기술 특징들을 자신들의 장비가 모두 지원하고, 그 후 릴리즈에 나타나는 기술 특징들도 자신들의 장비에 추가 부가시킬 수 있도록 하며, 이를 확인 가능케 하기 위함

- [참고1](http://www.ktword.co.kr/test/view/view.php?m_temp1=5391)

## Stage 는 뭐지?

A three-stage methodology as defined in ITU T Recommendation I.130 is applied in 3GPP according TR 21.900 clause 4.1:

Stage 1 is an overall service description from the user’s standpoint.

"Stage 1" refers to the service description from a service-user’s point of view.

Stage 2 is an overall description of the organization of the network functions to map service requirements into network capabilities.

"Stage 2" is a logical analysis, devising an abstract architecture of functional elements and the information flows amongst them across reference points between functional entities.

Stage 3 is the definition of switching and signalling capabilities needed to support services defined in stage 1.

"Stage 3" is the concrete implementation of the functionality and of the protocols appearing at physical interfaces between physical elements onto which the functional elements have been mapped.

1단계는 사용자의 관점에서 전반적인 서비스 설명입니다.

"1단계"는 서비스 사용자의 관점에서 서비스 설명을 말합니다.

2단계는 서비스 요구사항을 네트워크 기능에 매핑하기 위한 네트워크 기능의 구성에 대한 전반적인 설명입니다.

"2단계"는 기능적 요소 및 기능적 실체들 사이의 참조점에 걸친 정보 흐름의 추상적 아키텍처를 고안하는 논리적 분석입니다.

3단계는 1단계에서 정의된 서비스를 지원하는 데 필요한 전환 및 신호 전달 기능의 정의입니다.

"3단계"는 기능 요소가 매핑된 물리적 요소 사이의 물리적 인터페이스에 나타나는 프로토콜과 기능의 구체적인 구현입니다.

- [참고1](https://www.3gpp.org/about-3gpp/3gpp-faqs#S13)
- [참고2](https://www.3gpp.org/specifications/releases)

## 3GPP 규격들의 번호는 어떤 방식으로 부여되어 있는 걸까?

All 3GPP specifications have a specification number consisting of 4 or 5 digits. (e.g. 09.02 or 29.002).

The first two digits define the series, followed by 2 further digits for the 01 to 13 series or 3 further digits for the 21 to 55 series.

- [참고1](https://www.3gpp.org/specifications/79-specification-numbering)

## 3GPP 규격은 어디서 다운로드 하지?

[블로그](https://young-cow.tistory.com/39)에 정리해놨다.

## 참고 자료
- [행복한 프로그래머 - 3GPP 규격 보는 방법](https://jhhwang4195.tistory.com/78?category=801532)
- [NETMANIAS - 세계 각국의 5G 현황 분석 (1) - 5G 표준화 현황](https://www.netmanias.com/ko/?m=view&id=reports&no=11502&kw=3gpp)