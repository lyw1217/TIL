# Visual Studio Code(VSCode)에서 멀티커서 사용하기

## Multiple selections(multi-cursor)

| 사용법                    | 내용                                                                                 |
| ------------------------- | ------------------------------------------------------------------------------------ |
| `Alt + Click`             | 클릭한 부분에 커서를 추가함                                                          |
| `Ctrl + Alt + ↓(↑)`       | 현재 커서 기준 위, 아래에 커서를 추가함(방향키 이용)                                 |
| `Ctrl + D`                | 현재 커서가 위치한 단어를 선택하고, 일치하는 다음 단어도 하나하나씩 선택함           |
| `Ctrl + Shift + L`        | `Ctrl + D` 방식은 하나하나 선택하는 방식이라면, 이 방식은 한 번에 모든 것을 선택해줌 |
| `Shift + Alt + 드래그`    | Column (box) selection, 현재 커서 기준 드래그한 곳까지 다중 선택                     |
| `마우스 휠 클릭 + 드래그` | Column (box) selection, 휠 클릭한 부분부터 드래그한 곳까지 다중 선택                 |
| `ESC`                     | 멀티 커서 취소                                                                       |

- `Ctrl + Alt + ↓` 으로 멀티플 셀렉션
![Ctrl+Alt+Down](https://code.visualstudio.com/assets/docs/editor/codebasics/multicursor.gif)

- `Ctrl + D` 로 멀티플 셀렉션 
![Ctrl+D](https://code.visualstudio.com/assets/docs/editor/codebasics/multicursor-word.gif)

- `Shift + Alt + Drag` 로 Column selection
![Shift+Alt+Drag](https://code.visualstudio.com/assets/docs/editor/codebasics/column-select.gif)

(이미지는 VSCode의 User Guide에서 가져왔습니다. 참고자료 링크)

글로만 보는 것보다 직접 사용해보면 감이 온다.

매우매우 유용하게 쓰이니 숙지하고 있자.

### 참고자료
- https://code.visualstudio.com/docs/editor/codebasics#_multiple-selections-multicursor