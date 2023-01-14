# svn remote repository의 URL이 변경 되었을 때(svn 서버 URL 변경)

command line 환경에서 svn 을 사용 중 서버에 이상이 생겨 백업 서버로 repository URL을 변경해야 하는 일이 생겼다.

레파지토리를 체크아웃한 경로로 이동해서 아래 명령을 수행하면 된다.

## svn 버전 1.6 이하

```bash
svn switch --relocate FROM-URL TO-URL
```

### 예시

```shell
- 'http://svn.repo.com/src' 에서 'http://svn2.repo.com/src' 으로 저장소 변경

$ svn switch --relocate http://svn.repo.com/src http://svn2.repo.com/src
```

## svn 버전 1.7 이상

```bash
svn relocate TO-URL [PATH]
```

### 예시

```shell
- 'http://svn.repo.com/src' 에서 'http://svn2.repo.com/src' 으로 저장소 변경

$ svn relocate http://svn2.repo.com/src
```

## 참고 자료
- [https://svnbook.red-bean.com/en/1.7/svn.ref.svn.c.relocate.html](https://svnbook.red-bean.com/en/1.7/svn.ref.svn.c.relocate.html)
- [https://svnbook.red-bean.com/en/1.6/svn.ref.svn.c.switch.html](https://svnbook.red-bean.com/en/1.6/svn.ref.svn.c.switch.html)
- [https://www.lesstif.com/software-architect/subversion-repository-url-url-6717460.html](https://www.lesstif.com/software-architect/subversion-repository-url-url-6717460.html)