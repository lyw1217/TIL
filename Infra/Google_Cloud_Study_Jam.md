# 구글 클라우드 스터디잼 쿠버네티스 입문과정 참고

Google Cloud Skills Boost

Quest : Kubernetes in Google Cloud

## Lab : Continuous Delivery with Jenkins in Kubernetes Engine

(Kubernetes Engine에서 Jenkins로 지속적 배포)

### Content : Connect to Jenkins

(Jenkins에 연결하기)

⚪ Cloud Shell 에서 Web Preview가 제대로 안될 때 참고

```
Error: Could not connect to Cloud Shell on port 8080 
```
- https://stackoverflow.com/questions/51793485/error-could-not-connect-to-cloud-shell-on-port-8080-deploying-jenkins-in-googl

요약 : `kubectl port-forward $POD_NAME 8080:8080 >> /dev/null &` 명령어를 통해 `$POD_NAME` 에게 포트포워딩 해주어야 한다.
