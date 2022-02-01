# Node.js 의 특징

Node.js®는 Chrome V8 JavaScript 엔진으로 빌드된 JavaScript 런타임입니다.

브라우저 밖에서도 자바스크립트를 실행할 수 있도록 개발된 것

### 참고 자료
- [Node.js®에 대해서](https://nodejs.org/ko/about/)

## 논블로킹(Non-blocking) I/O

블로킹 : 함수를 호출하고 나면 함수가 완전히 종료가 될 때까지 다른 작업을 진행하지 못하고 기다려야함

논블로킹 : 함수를 호출한 후 호출된 함수가 실행되는 중에도 다른 작업을 동시에 진행할 수 있음

### 참고 자료
- [블로킹과 논블로킹 살펴보기](https://nodejs.org/ko/docs/guides/blocking-vs-non-blocking/)

## 싱글 스레드(Single Thread)

스레드 하나를 사용하는 것

자바스크립트를 실행하는 부분에 대해서만 싱글 스레드로 구성되고, 논블로킹 I/O와 이벤트 루프를 통해서 동시에 여러 작업을 가능하게 한다.

## 이벤트 루프(Event Loop)

Node.js는 Chrome V8 자바스크립트 엔진과 libuv, llhttp, c-ares, OpenSSL, zlib 라이브러리로 구성되어 있다.

자바스크립트 엔진은 비동기 처리를 할 수 없는데, 비동기로 처리되는 코드를 만나면 libuv 라이브러리를 통해 비동기 처리하게 된다.

자바스크립트 엔진은 아래 2가지 주요 컴포넌트로 이루어져있는데,

- 메모리 힙(Memory Heap) : 메모리 할당이 일어나는 컴포넌트
- 콜 스택(Call Stack) : 코드 실행을 위한 컴포넌트

자바스크립트는 처리해야하는 작업을 콜 스택에 올리고 하나하나씩 처리한다.

자바스크립트가 콜 스택에서 실행한 비동기 함수는 Web APIs를 호출하고, Web APIs는 콜백 함수를 콜백 큐(Callback Queue)에 넣는다.

이벤트 루프는 콜 스택과 콜백 큐의 상태를 체크하고, 콜 스택이 빈 상태가 되면 콜백 큐의 첫 번째 콜백을 콜 스택으로 이동시킨다.

### 참고 자료
- [Node.js 이벤트 루프, 타이머, process.nextTick()](https://nodejs.org/ko/docs/guides/event-loop-timers-and-nexttick/)

## npm(Node Package Manager)

Python의 pip나 Ruby의 gem처럼 Node.js의 패키지를 관리할 수 있는 도구이다.

npm을 통해 패키지 또는 모듈을 설치해서 자신의 프로젝트에 사용할 수 있다.

### 참고 자료
- [About npm](https://docs.npmjs.com/about-npm)