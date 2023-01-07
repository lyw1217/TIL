# 마크다운 Markdown 작성 방법

# 1. 마크다운?

## 1.1. 마크다운이란?

마크다운(Markdown)은 일반 텍스트 기반의 경량 마크업 언어다. 일반 텍스트로 서식이 있는 문서를 작성하는 데 사용되며, 일반 마크업 언어에 비해 문법이 쉽고 간단한 것이 특징이다. HTML과 리치 텍스트(RTF) 등 서식 문서로 쉽게 변환되기 때문에 응용 소프트웨어와 함께 배포되는 README 파일이나 온라인 게시물 등에 많이 사용된다. [Wikipedia](https://ko.wikipedia.org/wiki/%EB%A7%88%ED%81%AC%EB%8B%A4%EC%9A%B4)

파일 확장자가 _**.md**_ 로 된 파일들, 예를 들면 _**README.md**_ 파일이 바로 마크다운 문법으로 작성된 문서이다.

## 1.2. 마크다운을 사용하는 이유
마크다운은 아래와 같은 장점이 있다.

- 문법이 단순해서 사용하기 쉽다.
- 순수한 텍스트이기에 어디서나 편집이 가능하고 어디서나 볼 수 있다.
- html로 변환되지만, 태그 또는 서식으로 표시된 것처럼 보이지 않아서 그 자체만으로도 읽기 쉽다. 
- ...

그러나 마크다운은 표준이 오래되고 새로 나오지 않아서 그림 삽입 등 결국 HTML을 사용해야 하는 경우가 생길 수 있다.

그래서인지 GitHub Flavored Markdown 등 여러 확장 문법이 나타났다.

# 2. 마크다운 문법 Syntax
마크다운 문법 참고 사이트
- 공식 사이트 : [Daring Fireball](https://daringfireball.net/projects/markdown/syntax) (영문)
- GitHub Flavored Markdown : [Writing on GitHub](https://docs.github.com/en/github/writing-on-github) (영문), [Mastering-markdown](https://guides.github.com/features/mastering-markdown/index.html) (영문)


## 헤더 (Headers)

```
<작성 방법>
# This is an <h1> tag
## This is an <h2> tag
###### This is an <h6> tag

h7 부터는 없다.
```

># This is an <h1\> tag
>## This is an <h2\> tag
>###### This is an <h6\> tag


## 강조 (Emphasis)
```
<작성 방법>
이탤릭체(* , _)
*This text will be italic*
_This will also be italic_

볼드체(** , __)
**This text will be bold**
__This will also be bold__

이탤릭체, 볼드체 함께 사용하는 방법
_You **can** combine them_
```
>*This text will be italic*
>_This will also be italic_
>
>**This text will be bold**
>__This will also be bold__
>
>_You **can** combine them_

## 리스트 (Lists)

### 번호 없는 리스트 (Unordered)
```
<작성 방법>
* Item 1
* Item 2
    * Item 2a
    * Item 2b
```
>* Item 1
>* Item 2
>    * Item 2a
>    * Item 2b

### 번호 있는 리스트 (Ordered)
```
<작성 방법>
1. Item 1
1. Item 2
1. Item 3
    1. Item 3a
    1. Item 3b

[1. 2. 3.] 으로 적어도,
[2. 1. 3.] 으로 적더라도 위에서부터 아래로 순서대로 [1. 2. 3.] 으로 자동으로 바뀐다.
```
>1. Item 1
>1. Item 2
>1. Item 3
>    1. Item 3a
>    1. Item 3b


## 이미지 (Images)
```
<작성 방법>
![GitHub Logo](https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png)

Format: ![Alt Text](https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png)
```
>![GitHub Logo](https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png)

## 링크 (Links)
```
<작성 방법>
http://github.com - automatic!
[GitHub](http://github.com)

일반 링크는 자동으로 하이퍼링크로 적용된다.
[]() 는 []안의 문자로 ()안의 링크가 하이퍼링크 적용된다.
```
>http://github.com - automatic!\
>[GitHub](http://github.com)

## 블록 인용 (Blockquotes)
```
<작성 방법>
As Kanye West said:

> We're living the future so
> the present is our past.
```    
>As Kanye West said:
>> We're living the future so
>> the present is our past.

## 인라인 코드 (Inline code)
```
<작성 방법>
I think you should use an
`<addr>` element here instead.

라인 안에 코드를 삽입하여 보여준다.
```
>I think you should use an
>`<addr>` element here instead.


## 참고 자료
- [ihoneymon/how-to-write-by-markdown.md](https://gist.github.com/ihoneymon/652be052a0727ad59601)
- [HEROPY Tech - [MarkDown 사용법 총정리]](https://heropy.blog/2017/09/30/markdown/)
- [GitHub Guides - Mastering Markdown](https://guides.github.com/features/mastering-markdown/index.html)
- [biospin/BigBio/reference/마크다운.md](https://github.com/biospin/BigBio/blob/master/reference/%EB%A7%88%ED%81%AC%EB%8B%A4%EC%9A%B4.md)