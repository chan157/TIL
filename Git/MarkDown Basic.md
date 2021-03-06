# 마크다운 활용법

## 1. 제목(Heading)

### 한국어

제목은 `#`  을 통해 구성할 수 있다. `#`의 갯수로 제목의 레벨을 표현한다.

제목의 레벨은 6단계까지 표현 가능하다.

### English

Heading can be composed using `#`.

The number of `#` show the level of title

Heading has 6 levels.

## 2. 목록

목록은 순서가 있는 목록과 순서가 없는 목록이 있다.

1. 순서가 있는 목록
2. 순서가 있는 목록2

* 순서가 없는 목록
*  `*` 기호를 사용하여 순서가 없는 목록 작성
* Bullet Point
  * tab을 통해 레벨 다운하여 사용할 수 있다.
    * 계속해서 사용가능

## 3. 인용문

> 부등호 기호 `>` 를 통해 인용문을 작성합니다.
>
> 다양한 정의나 강조 글을 이 기능을 사용해서 활용할 수 있다.

## 4. 링크

[마크다운 활용법]()

`[]()`

`[제목 부분](링크를 추가할 부분)` 이런 구조를 사용해서 링크를 달아줄 수 있다.

대괄호에 단어, 소괄호에 링크

## 5. 이미지

Typora의 장점

이미지를 끌어서 올릴 수 있음.

![다운로드](images/다운로드.png)

설정이 필요함

* 파일 > 환경설정 > 이미지
  * Copy image to Custom folder 를 설정하여준다.
  * 가능하다면 상대적 위치 사용
  * 온라인 이미지에도 위 규칙 적용 
* 특별한 동작 없음을 원하는 폭더 구조로 작성할 것.
  * ex) `./images`
* 위처럼 설정하면 온라인에서도 이미지가 깨져서 보이지 않음.

## 6. 코드

코드 블록을 통해 원하는 프로그래밍 언어의 syntax highlighting도 지원 가능하다.

" ```언어 이름"

```python
# 파이썬 주석
print("hi")
while(J < 0):
    a += 5
```

```javascript
// 자바스크립트 주석
console.log('hi')
```

```bash
$ ls hihihi
```

Oh this tool is awesome !

## 7. 기타

수평선은 `---` 으로 표현 가능하다.

---

오오오

---

*이탤릭체*

**볼드체**

~~취소선~~

이탤릭체는 `*` 으로 단어를 감싸면 됨

볼드체는 `**` 두 개를 사용해서 

`~~` 은 취소선

| 표     | 구분1                         | 구분2                     |
| ------ | ----------------------------- | ------------------------- |
| 홍길동 | 이 부분이 더 길게 하고 싶으면 | 더 글씨를 많이 쓰면 된다. |
| 김길동 |                               |                           |
| 박길동 |                               |                           |

표는 직접 문법을 사용하는 것 보다는 `본문 서식`을 활용해서 직접 만드는 것이 좋다.













