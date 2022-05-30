# HTML `<video>` tag

HTML `<video>` 태그는 비디오 플레이백(영상 재생)을 지원하는 미디어 플레이어를 HTML 문서에 삽입한다.

오디오 콘텐츠에도 사용할 수 있으나, 오디오 콘텐츠에는 `<audio>` 태그가 좀 더 적합하다.

## Attribute

| Attribute | Description                                                                                                          |
| --------- | -------------------------------------------------------------------------------------------------------------------- |
| autoplay  | 이 속성이 존재한다면 비디오가 자동재생된다.                                                                          |
| controls  | 이 속성이 존재한다면 volumn, seek, pause/resume 등을 할 수 있는 컨트롤러를 표시한다.                                 |
| height    | 비디오 플레이어의 높이를 설정한다. 단위는 pixel                                                                      |
| width     | 비디오 플레이어의 너비를 설정한다. 단위는 pixel                                                                      |
| loop      | 이 속성이 존재한다면 비디오 재생이 마친 후 자동으로 처음으로 돌아간다.                                               |
| muted     | 비디오에 포함된 오디오의 재생 여부를 나타내는 속성                                                                   |
| buffered  | 버퍼링 된 부분을 나타내는 [TimeRanges](https://developer.mozilla.org/en-US/docs/Web/API/TimeRanges) 객체를 반환한다. |
| played    | 재생된 부분을 나타내는 [TimeRanges](https://developer.mozilla.org/en-US/docs/Web/API/TimeRanges) 객체를 반환한다.    |
| poster    | 비디오 재생 전까지 출력되는 포스터의 주소. 설정되지 않으면 첫 번째 프레임을 출력한다.                                |
| src       | 삽입할 비디오의 주소(url). `<video>` 태그 내에 `<source>` 요소를 사용하여 삽입할 비디오를 명시할 수 있다.            |

## 브라우저 호환성

[여기](https://developer.mozilla.org/ko/docs/Web/HTML/Element/Video#browser_compatibility)에서 브라우저별 호환 가능한 attribute를 확인할 수 있다.

## 예시

```html
<!-- Simple video example -->
<video src="videofile.ogg" autoplay poster="posterimage.jpg">
  Sorry, your browser doesn't support embedded videos,
  but don't worry, you can <a href="videofile.ogg">download it</a>
  and watch it with your favorite video player!
</video>

<!-- Video with subtitles -->
<video src="foo.ogg">
  <track kind="subtitles" src="foo.en.vtt" srclang="en" label="English">
  <track kind="subtitles" src="foo.sv.vtt" srclang="sv" label="Svenska">
</video>
```

## 참고 자료

- https://developer.mozilla.org/ko/docs/Web/HTML/Element/Video
- https://www.w3schools.com/tags/tag_video.asp