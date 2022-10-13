# kubernetes 오브젝트 이름과 ID

쿠버네티스 yaml 작성 중, hostAliases의 hostnames를 `test_tb_ipc` 와 같은 이름으로 작성했더니 아래 에러가 발생했다.

```
* spec.template.spec.hostAliases.hostnames: Invalid value: "test_tb_ipc": a lowercase RFC 1123 subdomain must consist of lower case alphanumeric characters, '-' or '.', and must start and end with an alphanumeric character (e.g. 'example.com', regex used for validation is '[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*')
```

에러 메시지 상, 알파벳 소문자 또는 '-', '.' 만 이름으로 사용할 수 있다고 나와있어서 `test.tb.ipc` 로 hostname을 변경하니 정상적으로 적용됐다.

이후에, k8s 홈페이지에서 관련 내용을 찾아봤고 아래와 같은 이름 제한 조건을 찾을 수 있었다.

## DNS 서브도메인 이름

대부분의 리소스 유형에는 RFC 1123에 정의된 대로 DNS 서브도메인 이름으로 사용할 수 있는 이름이 필요하다. 이것은 이름이 다음을 충족해야 한다는 것을 의미한다.

- 253자를 넘지 말아야 한다.
- 소문자와 영숫자 - 또는 . 만 포함한다.
- 영숫자로 시작한다.
- 영숫자로 끝난다.

오브젝트 이름와 ID에 대한 더 많은 이름 제한 조건들은 아래 참고자료를 확인. 

### 참고 자료

- https://kubernetes.io/ko/docs/concepts/overview/working-with-objects/names/