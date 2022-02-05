# 메모리 누수 검사 valgrind macOS에서 설치하기

## valgrind?

valgrind는 프로그램 성능을 프로파일링하고 분석하는 데 사용할 수 있는 여러 도구를 갖는 프레임워크이다. 메모리 관리나 쓰레드 버그들을 자동으로 탐지해준다.

## macOS에서 설치하는 방법

[LouisBrunner/valgrind-macos](https://github.com/LouisBrunner/valgrind-macos/tree/feature/macos_11pp)

아주 착하신 개발자분께서 macOS 플랫폼에 지원 가능하도록 개선해서 배포 중이시다.

위 링크를 타고 레파지토리로 들어가서 REAME에 따라 brew 명령어 몇 개만 수행하면 된다. (homebrew는 설치되어있어야 한다!)

    brew tap LouisBrunner/valgrind

    brew install --HEAD LouisBrunner/valgrind/valgrind

그런데 나는 두 번째 명령어를 수행했을 때 아래와 같은 에러가 발생했고, 

    Error: Your Command Line Tools are too outdated.
    Update them from Software Update in System Preferences or run:
    softwareupdate --all --install --force

    If that doesn't show you any updates, run:
    sudo rm -rf /Library/Developer/CommandLineTools
    sudo xcode-select --install

    Alternatively, manually download them from:
    https://developer.apple.com/download/all/.
    You should download the Command Line Tools for Xcode 13.0.****

말해주는 대로 softwareupdate를 했지만 if문에 걸려서,

    ❯ softwareupdate --all --install --force
    Software Update Tool

    Finding available software
    No updates are available.

역시나 에러에서 하라는 대로 명령어를 수행했고

    ❯ sudo rm -rf /Library/Developer/CommandLineTools
    ❯ sudo xcode-select --install

다시 아래 명령어를 재수행해서

    ❯ brew install --HEAD LouisBrunner/valgrind/valgrind

설치를 완료했다.

## 사용 방법

1. 첫 번째 방법

   - 컴파일한 다음, 실행파일(`a.out`)이 생성되면
   - `valgrind --leak-check=full ./a.out` 하면 파일이 실행되면서 메모리 누수를 검사한다.

2. 두 번째 방법

   - 컴파일한 다음, 실행파일(`a.out`)이 생성되면
   - `leaks a.out`
   - 파일이 실행 중이어야 한다.

3. 세 번째 방법

    - 소스에 leaks를 삽입하여 프로그램이 종료되기 전에 누수를 탐지하도록 한다.
            
            system("leaks a.out > leaks_result_temp; cat leaks_result_temp | grep leaked" && rm -rf leaks_result_temp);

## 참고 자료
- [Valgrind.org](https://www.valgrind.org/)
- [LouisBrunner/valgrind-macos](https://github.com/LouisBrunner/valgrind-macos/tree/feature/macos_11pp)
- [Red Hat Training - 5.3 프로파일 메모리 사용에 VALGRIND 사용](https://access.redhat.com/documentation/ko-kr/red_hat_enterprise_linux/6/html/performance_tuning_guide/s-memory-valgrind)
- [Better me than yesterday - Mac Os Valgrind 설치하기](https://42kchoi.tistory.com/263)
- [taelee.log - C 메모리 누수 검사하기](https://velog.io/@taelee/C-%EB%A9%94%EB%AA%A8%EB%A6%AC-%EB%88%84%EC%88%98-%EA%B2%80%EC%82%AC%ED%95%98%EA%B8%B0)