# Markdown 을 Github-style로 변환하는 방법

## 1. Installing pandoc

[여기(github)](https://github.com/jgm/pandoc/blob/master/INSTALL.md)를 참고하여 pandoc 설치

[바로 다운로드](https://github.com/jgm/pandoc/releases)

## 2. pandoc를 이용해서 Markdown 변환

## 2-1. Github Style CSS 다운로드

[여기(github)](https://gist.github.com/dashed/6714393)서 github style sheet 다운받기

## 2-2. 설치한 pandoc를 이용하여 파일 변환하기

### 내가 사용한 예시

`pandoc README.md -f markdown -t html -s --css=github-pandoc.css -o README.html`

### 각 옵션들의 의미

- 현재 디렉토리에 있는 `README.md` 문서는
- `-f markdown` : 마크다운 형식의 문서인데
- `-t html` : 이걸 html 형식으로 변환하여 저장할 것이고
- `-s --css=github-pandoc.css` : 현재 디렉토리에 있는 css파일인 `github-pandoc.css` 파일을 입력받아서
- `-o README.html` : `README.html` 이라는 파일로 출력할 것이다.

### 아래 링크들을 참고하였음

- https://pandoc.org/MANUAL.html
- https://sihan-son.github.io/git/pandoc-github-style-render/
