# Python TIL Day 01

## Source Code

### Problem : 완전탐색 - 모의고사

---

Reference : Programmers

URL : https://programmers.co.kr/learn/courses/30/parts/12230

Programmers Website에서 직접 실습하실 수 있습니다.

---

#### 문제 설명

수포자는 수학을 포기한 사람의 준말입니다. 수포자 삼인방은 모의고사에 수학 문제를 전부 찍으려 합니다. 수포자는 1번 문제부터 마지막 문제까지 다음과 같이 찍습니다.

1번 수포자가 찍는 방식: 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, ...
2번 수포자가 찍는 방식: 2, 1, 2, 3, 2, 4, 2, 5, 2, 1, 2, 3, 2, 4, 2, 5, ...
3번 수포자가 찍는 방식: 3, 3, 1, 1, 2, 2, 4, 4, 5, 5, 3, 3, 1, 1, 2, 2, 4, 4, 5, 5, ...

1번 문제부터 마지막 문제까지의 정답이 순서대로 들은 배열 answers가 주어졌을 때, 가장 많은 문제를 맞힌 사람이 누구인지 배열에 담아 return 하도록 solution 함수를 작성해주세요.

#### My Code

```python
def solution(answers):
    list1 = [1,2,3,4,5]
    list2 = [2,1,2,3,2,4,2,5]
    list3 = [3,3,1,1,2,2,4,4,5,5]

    length = len(answers)
    cnt1 = cnt2 = cnt3 = 0

    for i in range(length) :
        if answers[i] == list1[(i%5)]:
            cnt1 += 1
        if answers[i] == list2[(i%8)]:
            cnt2 += 1
        if answers[i] == list3[(i%10)]:
            cnt3 += 1       

    score = [cnt1, cnt2, cnt3]

    for i, s in enumerate(score):
        if s == max(score):
            answer.append(i+1)

    return answer    
```

#### What I Learn

My_Answer_Code

```python
    answer = []
    for i, s in enumerate(score):
        if s == max(score):
            answer.append(i+1)
	return answer
```

Teacher

```python
    return [i + 1 for i, v in enumerate(score) if v == max(score)]
```

* 5줄의 코드를 1줄로 간단하게 작성할 수 있는 Python Code 작성 테크닉을 배웠습니다.