# [Python] 백준 1021번 회전하는 큐

# 회전하는 큐

| 시간 제한 | 메모리 제한 | 제출  | 정답 | 맞은 사람 | 정답 비율 |
| :-------- | :---------- | :---- | :--- | :-------- | :-------- |
| 2 초      | 128 MB      | 12880 | 5549 | 4562      | 44.416%   |

## 문제

지민이는 N개의 원소를 포함하고 있는 양방향 순환 큐를 가지고 있다. 지민이는 이 큐에서 몇 개의 원소를 뽑아내려고 한다.

지민이는 이 큐에서 다음과 같은 3가지 연산을 수행할 수 있다.

1. 첫 번째 원소를 뽑아낸다. 이 연산을 수행하면, 원래 큐의 원소가 a1, ..., ak이었던 것이 a2, ..., ak와 같이 된다.
2. 왼쪽으로 한 칸 이동시킨다. 이 연산을 수행하면, a1, ..., ak가 a2, ..., ak, a1이 된다.
3. 오른쪽으로 한 칸 이동시킨다. 이 연산을 수행하면, a1, ..., ak가 ak, a1, ..., ak-1이 된다.

큐에 처음에 포함되어 있던 수 N이 주어진다. 그리고 지민이가 뽑아내려고 하는 원소의 위치가 주어진다. (이 위치는 가장 처음 큐에서의 위치이다.) 이때, 그 원소를 주어진 순서대로 뽑아내는데 드는 2번, 3번 연산의 최솟값을 출력하는 프로그램을 작성하시오.

## 입력

첫째 줄에 큐의 크기 N과 뽑아내려고 하는 수의 개수 M이 주어진다. N은 50보다 작거나 같은 자연수이고, M은 N보다 작거나 같은 자연수이다. 둘째 줄에는 지민이가 뽑아내려고 하는 수의 위치가 순서대로 주어진다. 위치는 1보다 크거나 같고, N보다 작거나 같은 자연수이다.

## 출력

첫째 줄에 문제의 정답을 출력한다.

## 예제 입력 1 복사

```
10 3
1 2 3
```

## 예제 출력 1 복사

```
0
```

## 예제 입력 2 복사

```
10 3
2 9 5
```

## 예제 출력 2 복사

```
8
```

## 예제 입력 3 복사

```
32 6
27 16 30 11 6 23
```

## 예제 출력 3 복사

```
59
```

## 예제 입력 4 복사

```
10 10
1 6 3 2 7 9 8 4 10 5
```

## 예제 출력 4 복사

```
14
```

## 소스코드

```python
f = lambda:map(int,input().split())
n, m = f()
que = [*range(1,n+1)]
ix, cnt= 0, 0
for _ in f():
    q = que.index(_)
    m1 = abs(q-ix)
    m2 = len(que) - m1
    cnt += min(m1,m2)
    ix = q
    del que[q]
print(cnt)
```

* 결과
  * 메모리 : 29284 KB
  * 시간 : 56 ms
* 문제 풀이
  * 길이가 1부터 n까지인 `que`라는 리스트로 만들어줍니다.
  * `ix`는 현재의 인덱스의 위치를 의미하며 `q`는 `que`리스트 내에서 원하는 숫자가 있는 위치의 인덱스를 의미합니다. 현재 인덱스 `ix`에서 `q`의 위치로 `2`번 연산 혹은 `3`번 연산을 통해서 움직여야합니다.  왼쪽과 오른쪽으로 가는 방법인 `m1`과 `m2` 중 더 작은 값의 방법으로 해당 위치로 이동할 것이며 이동한 만큼의 값을 `cnt`에 더해서 총 이동거리의 값을 계산합니다.
  * 실제로 que의 요소들을 `pop`시켜서 꺼내도 되지만 index만을 가지고 문제를 해결하였습니다.  꺼내기로 결정한 값은 `remove`나 `del`을 사용해서 제거합니다.

* 문제 출처

  * https://www.acmicpc.net/problem/1021

* 유사한 문제
  * ㄱ
  * ㄱ
  * ㄱ