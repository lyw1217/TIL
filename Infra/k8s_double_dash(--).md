# kubernetes | kubectl double dash 더블 대쉬(--) 왜 쓸까

```bash
$ kubectl exec -it mysql-0 -- mysql -u root -p
```

위 명령어는 `mysql-0` 이라는 pod에 접근하기 위한 명령어이다.

중간에 `--` 더블 대쉬가 있는데 무슨 의미를 갖고 있는 걸까?


## 명령어를 구분하기 위함

`kubectl exec -it mysql-0 -- mysql -u root -p` 명령어는 `--`를 기준으로 2개로 구분지을 수 있다.

- `kubectl exec -it mysql-0` : kubectl exec 명령어 및 옵션

- `mysql -u root -p` : pod 내부에서 실행되어야할 명령어

만약 `--` 더블 대쉬가 없다면 `mysql -u root -p` 의 `-u`, `-p` 옵션들이 `kubectl exec` 에 대한 옵션으로 해석될 여지가 있다.

즉, `--` 더블 대쉬는 `kubectl` 에 대한 옵션의 끝을 알려주어서 오해의 소지가 없도록 하는 역할을 한다고 볼 수 있다.


### 참고 자료
- https://stackoverflow.com/questions/69684693/why-does-kubectl-exec-need-a
- 