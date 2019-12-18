# BAEKJOON : 1003번 피보나치 함수

## Problem

다음 소스는 N번째 피보나치 수를 구하는 C++ 함수이다.

```c++
int fibonacci(int n) {
    if (n == 0) {
        printf("0");
        return 0;
    } else if (n == 1) {
        printf("1");
        return 1;
    } else {
        return fibonacci(n‐1) + fibonacci(n‐2);
    }
}
```

`fibonacci(3)`을 호출하면 다음과 같은 일이 일어난다.

- `fibonacci(3)`은 `fibonacci(2)`와 `fibonacci(1)` (첫 번째 호출)을 호출한다.
- `fibonacci(2)`는 `fibonacci(1)` (두 번째 호출)과 `fibonacci(0)`을 호출한다.
- 두 번째 호출한 `fibonacci(1)`은 1을 출력하고 1을 리턴한다.
- `fibonacci(0)`은 0을 출력하고, 0을 리턴한다.
- `fibonacci(2)`는 `fibonacci(1)`과 `fibonacci(0)`의 결과를 얻고, 1을 리턴한다.
- 첫 번째 호출한 `fibonacci(1)`은 1을 출력하고, 1을 리턴한다.
- `fibonacci(3)`은 `fibonacci(2)`와 `fibonacci(1)`의 결과를 얻고, 2를 리턴한다.

1은 2번 출력되고, 0은 1번 출력된다. N이 주어졌을 때, `fibonacci(N)`을 호출했을 때, 0과 1이 각각 몇 번 출력되는지 구하는 프로그램을 작성하시오.

* 입력

첫째 줄에 테스트 케이스의 개수 T가 주어진다.

각 테스트 케이스는 한 줄로 이루어져 있고, N이 주어진다. N은 40보다 작거나 같은 자연수 또는 0이다.

* 출력

각 테스트 케이스마다 0이 출력되는 횟수와 1이 출력되는 횟수를 공백으로 구분해서 출력한다.

* 예제 입력 1 복사

```
3
0
1
3
```

* 예제 출력 1 복사

```
1 0
0 1
1 2
```

* 출처

- 문제를 번역한 사람: [baekjoon](https://www.acmicpc.net/user/baekjoon)
- 어색한 표현을 찾은 사람: [cyj101366](https://www.acmicpc.net/user/cyj101366)
- 데이터를 추가한 사람: [doju](https://www.acmicpc.net/user/doju)



## Solution

### Solution 01

```python
def fibonacci(n):
    if n < 0:
        return 1
    elif n == 0 :
        return 0
    elif n == 1:
        return 1
    else:
        return fibonacci(n-1) + fibonacci(n-2)

T = int(input())
list1 = []
for t in range(T):
    list1.append(int(input()))
    
for n in list1:
    print(fibonacci(n-1),fibonacci(n))
```



* 위 솔루션 => 제한시간 초과 => 피보나치를 2번 돌았기 때문이라고 판단함



### Solution 02

```python
def fibonacci(n):
    global x
    if n == 0 :
        x[0] += 1
        return 0
    elif n == 1:
        x[1] += 1
        return 1
    else:
        return fibonacci(n-1) + fibonacci(n-2)

T = int(input())
list1 = []
for t in range(T):
    list1.append(int(input()))
    
for n in list1:
    x = [0,0]
    y = fibonacci(n)
    print(x[0],x[1])
```



* 여전히 제한시간 초과 발생 => 많은 고민의 시간을 보냄
* 그냥 방정식으로 풀자고 생각함



### Solution 3

```python
def fibo_number(n):
    x = (alpha**n - beta**n)/(alpha-beta)
    return int(x)

alpha = (1+5**(1/2))/2
beta = (1-5**(1/2))/2

T = int(input())
list1 = []

for t in range(T):
    list1.append(int(input()))

for n in list1:
    if n < 1:
        print(1,0)
    else :
        print(fibo_number(n-1),fibo_number(n))
    
```



* 피보나치 수열을 사용해 그냥 값을 찾아서 넣도록 함
* 문제 해결 성공, 제한시간 통과



### What I leanred

* Python은 확실히 느리다. 
* 다른 C++ 같은 언어들을 사용한 풀이를 보았을 때 sol1, sol2로 문제를 해결하여도 빠른 시간안에 문제가 해결되는 것을 확인하였다.
* Python은 확실히 진짜 느리다.
* 알고리즘 대회나 코딩테스트를 위해서는 확실히 C 나 C++ 등을 해야한다는 것을 느꼈다.