# [Python] 백준 4195번 친구 네트워크 - 유니온 파인드(Union Find)활용

# 친구 네트워크  

| 시간 제한 | 메모리 제한 | 제출  | 정답 | 맞은 사람 | 정답 비율 |
| :-------- | :---------- | :---- | :--- | :-------- | :-------- |
| 3 초      | 256 MB      | 11608 | 3704 | 1925      | 26.658%   |

## 문제

민혁이는 소셜 네트워크 사이트에서 친구를 만드는 것을 좋아하는 친구이다. 우표를 모으는 취미가 있듯이, 민혁이는 소셜 네트워크 사이트에서 친구를 모으는 것이 취미이다.

어떤 사이트의 친구 관계가 생긴 순서대로 주어졌을 때, 두 사람의 친구 네트워크에 몇 명이 있는지 구하는 프로그램을 작성하시오.

친구 네트워크란 친구 관계만으로 이동할 수 있는 사이를 말한다.

## 입력

첫째 줄에 테스트 케이스의 개수가 주어진다. 각 테스트 케이스의 첫째 줄에는 친구 관계의 수 F가 주어지며, 이 값은 100,000을 넘지 않는다. 다음 F개의 줄에는 친구 관계가 생긴 순서대로 주어진다. 친구 관계는 두 사용자의 아이디로 이루어져 있으며, 알파벳 대문자 또는 소문자로만 이루어진 길이 20 이하의 문자열이다.

## 출력

친구 관계가 생길 때마다, 두 사람의 친구 네트워크에 몇 명이 있는지 구하는 프로그램을 작성하시오.

## 예제 입력 1 복사

```
2
3
Fred Barney
Barney Betty
Betty Wilma
3
Fred Barney
Betty Wilma
Barney Betty
```

## 예제 출력 1 복사

```
2
3
4
2
2
4
```

...

## 소스코드

```python
from sys import stdin
def find(x):
    if parent[x] == x: return x
    else:
        p = find(parent[x])
        parent[x] = p
        return p

def union(x, y):
    x, y = find(x), find(y)

    if x != y:
        parent[y] = x
        number[x] += number[y]
    print(number[x])

for _ in range(int(stdin.readline())):
    num = int(stdin.readline())
    parent, number = {}, {}
    for i in range(num):
        a, b = stdin.readline().split()
        if a not in parent:
            parent[a] = a
            number[a] = 1
        if b not in parent:
            parent[b] = b
            number[b] = 1
        union(a, b)
```

* 결과
  * 메모리 : 30488 KB
  * 시간 : 304 ms
* 문제 풀이
  * 이 문제를 해결하기 위해서는 유니온 파인드(Union Find) 알고리즘에 대한 기본적인 내용을 알고있어야 문제를 해결하기 수월합니다.
  * 유니온 파인드는 기본 Root노드를 기준으로 원소들을 가지는 집합을 만듭니다. 유니온 파인드에 대한 내용은 https://twpower.github.io/115-union-find-disjoint-set 에서 참고하시면 되겠습니다.
  * 일반적인 유니온 파인드와 다르게 숫자가 아닌 문자열이 들어가므로 친구의 숫자를 저장하기 위한 리스트를 하나 더 선언해주어야합니다.
  * 나머지 문제 풀이는 유니온 파인드와 동일하게 문제를 해결해주시면 되겠습니다. 

* 문제 출처

  * https://www.acmicpc.net/problem/4195
