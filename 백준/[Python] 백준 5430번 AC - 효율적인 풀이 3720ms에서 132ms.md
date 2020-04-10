# [Python] 백준 5430번 AC - 효율적인 풀이 3720ms에서 132ms

# AC

| 시간 제한 | 메모리 제한 | 제출  | 정답 | 맞은 사람 | 정답 비율 |
| :-------- | :---------- | :---- | :--- | :-------- | :-------- |
| 1 초      | 256 MB      | 18083 | 3998 | 2545      | 19.681%   |

## 문제

선영이는 주말에 할 일이 없어서 새로운 언어 AC를 만들었다. AC는 정수 배열에 연산을 하기 위해 만든 언어이다. 이 언어에는 두 가지 함수 R(뒤집기)과 D(버리기)가 있다.

함수 R은 배열에 있는 숫자의 순서를 뒤집는 함수이고, D는 첫 번째 숫자를 버리는 함수이다. 배열이 비어있는데 D를 사용한 경우에는 에러가 발생한다.

함수는 조합해서 한 번에 사용할 수 있다. 예를 들어, "AB"는 A를 수행한 다음에 바로 이어서 B를 수행하는 함수이다. 예를 들어, "RDD"는 배열을 뒤집은 다음 처음 두 숫자를 버리는 함수이다.

배열의 초기값과 수행할 함수가 주어졌을 때, 최종 결과를 구하는 프로그램을 작성하시오.

## 입력

첫째 줄에 테스트 케이스의 개수 T가 주어진다. T는 최대 100이다.

각 테스트 케이스의 첫째 줄에는 수행할 함수 p가 주어진다. p의 길이는 1보다 크거나 같고, 100,000보다 작거나 같다.

다음 줄에는 배열에 들어있는 수의 개수 n이 주어진다. (0 ≤ n ≤ 100,000)

다음 줄에는 [x1,...,xn]과 같은 형태로 배열에 들어있는 수가 주어진다. (1 ≤ xi ≤ 100)

전체 테스트 케이스에 주어지는 p의 길이의 합과 n의 합은 70만을 넘지 않는다.

## 출력

각 테스트 케이스에 대해서, 입력으로 주어진 정수 배열에 함수를 수행한 결과를 출력한다. 만약, 에러가 발생한 경우에는 error를 출력한다.

## 예제 입력 1 복사

```
4
RDD
4
[1,2,3,4]
DD
1
[42]
RRD
6
[1,1,2,3,5,8]
D
0
[]
```

## 예제 출력 1 복사

```
[2,1]
error
[1,2,3,5,8]
error
```

## 소스코드

### 3720ms

```python
from sys import stdin, stdout
def AC(com, li):
    left = True
    if len(li) < com.count('D'):
        return 'error\n'
    for c in com:
        if c == 'R': left = not left
        elif c == 'D':
            p = 0 if left else -1
            if li: li.pop(p)
            else: return 'error\n'
    if li:
        if left: return '[' + ','.join(li) + ']\n'
        else: return '[' + ','.join(reversed(li)) + ']\n'
    return '[]\n'

T = int(stdin.readline())
for _ in range(T):
    com = stdin.readline()
    n = stdin.readline().rstrip()
    li = stdin.readline().rstrip()[1:-1].split(',')
    if (n == 0) or (n=='0') : li = []
    stdout.write(AC(com, li))

```

* 결과
  * 메모리 : 38616 KB
  * 시간 : 3720 ms
* 문제 풀이
  * 명령 R과 D에 따라서 뒤집거나 숫자를 빼는 동작을 수행하여 최종 결과물을 출력합니다. 명령어 R이 들어올 때마다 배열을 뒤집는 `reversed`를 수행하면 너무 많은 시간이 소요됩니다. 따라서 `left`라는 변수를 만들어서 `reversed`를 할 때마다 뒤집어줍니다. 
  * 즉, 처음에는 `left = True`상태로 시작됩니다. 이 때, `D`명령어가 나오면 `pop(0)`를 통해서 가장 앞의 요소를 뽑아냅니다. `R`명령어가 들어오면 `left = not left`를 통해서 bool값을 반대로 만들어줍니다. `left = False`인 상태에서 `D`명령어가 들어오면 `pop(-1)`을 사용해서 가장 오른쪽에 있는 요소를 뽑아줍니다.
  * 더 이상 요소가 없는데 요소를 뽑는 경우를 생각해보겠습니다. 직접 요소를 뽑지 않아도 `D`의 숫자와 배열 요소들의 숫자만 비교하면 알 수 있습니다.  배열의 길이와 `D`명령어의 개수를 비교해서 명령을 수행하지 않고 바로 `error`를 출력할 수 있게 합니다.
  * 진행도 중 요소가 없는데 요소를 `pop`시키는 경우에 `error`을 발생시킵니다.
  * 모든 명령을 다 실행하면 배열 값을 출력 형식에 맞게 합쳐서 출력합니다. 이때, `left = False` 상태라면 뒤집어진 상태이므로 `reversed`가 적용된 배열을 사용해야합니다.

### 132 ms - 시간복잡도를 줄인 풀이

```python
from sys import stdin, stdout
def AC(com,n, li):
    com.replace('RR', '')
    l, r, d = 0, 0, True
    for c in com:
        if c == 'R': d = not d
        elif c == 'D':
            if d: l += 1
            else: r += 1
    if l+r <= n:
        res = li[l:n - r]
        if d: return '[' + ','.join(res) + ']\n'
        else: return '[' + ','.join(res[::-1]) + ']\n'
    else:
        return 'error\n'

T = int(stdin.readline())
for _ in range(T):
    com = stdin.readline()
    n = int(stdin.readline())
    li = stdin.readline().rstrip()[1:-1].split(',')
    if n == 0 : []
    stdout.write(AC(com, n, li))
```

* 결과
  * 메모리 : 42596 KB
  * 시간 : 132 ms
* 문제 풀이
  * 위 풀이의 시간이 상당히 오래걸린 것을 개선시키기 위한 방법을 생각해봅니다.  
  * 위의 풀이에서 실제 요소들을 `pop`시키는 과정에서 가장 앞에 있는 요소를 제거하면 전체 리스트의 요소들을 한칸씩 앞으로 옮겨주어야합니다. 즉 `pop(0)`의 시간 복잡도는 `O(n)`이 될 것입니다. 따라서, 명령어마다 `pop`을 시키지 않고 한번에 명령어를 수행할 수 있는 방법을 생각해봅니다.
  * `R`과 `D`에 따라서 왼쪽에서 몇개를 지우고 오른쪽에서 몇개를 지울지 숫자를 센 후 한번에 지워주면 되겠습니다.
  * `l, r`은 왼쪽과 오른쪽의 지워줄 개수를 세어주고 `d`는 왼쪽인지 오른쪽인지 방향을  `True or False`로 나타내겠습니다. 위 풀이의 `left`와 같은 역할입니다. 
  * 이후 결과에 맞게 출력을 진행합니다.
* 유사한 문제
  * ㄱ
  * ㄱ
  * ㄱ

* 문제 출처

  * https://www.acmicpc.net/problem/5430
