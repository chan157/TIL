# [Python] 백준 1260번 DFS와 BFS

# DFS와 BFS

| 시간 제한 | 메모리 제한 | 제출  | 정답  | 맞은 사람 | 정답 비율 |
| :-------- | :---------- | :---- | :---- | :-------- | :-------- |
| 2 초      | 128 MB      | 86574 | 28391 | 16516     | 31.453%   |

## 문제

그래프를 DFS로 탐색한 결과와 BFS로 탐색한 결과를 출력하는 프로그램을 작성하시오. 단, 방문할 수 있는 정점이 여러 개인 경우에는 정점 번호가 작은 것을 먼저 방문하고, 더 이상 방문할 수 있는 점이 없는 경우 종료한다. 정점 번호는 1번부터 N번까지이다.

## 입력

첫째 줄에 정점의 개수 N(1 ≤ N ≤ 1,000), 간선의 개수 M(1 ≤ M ≤ 10,000), 탐색을 시작할 정점의 번호 V가 주어진다. 다음 M개의 줄에는 간선이 연결하는 두 정점의 번호가 주어진다. 어떤 두 정점 사이에 여러 개의 간선이 있을 수 있다. 입력으로 주어지는 간선은 양방향이다.

## 출력

첫째 줄에 DFS를 수행한 결과를, 그 다음 줄에는 BFS를 수행한 결과를 출력한다. V부터 방문된 점을 순서대로 출력하면 된다.

## 예제 입력 1 복사

```
4 5 1
1 2
1 3
1 4
2 4
3 4
```

## 예제 출력 1 복사

```
1 2 4 3
1 2 3 4
```

## 예제 입력 2 복사

```
5 5 3
5 4
5 2
1 2
3 4
3 1
```

## 예제 출력 2 복사

```
3 1 2 5 4
3 1 4 2 5
```

## 예제 입력 3 복사

```
1000 1 1000
999 1000
```

## 예제 출력 3 복사

```
1000 999
1000 999
```

...

##  Python 소스 코드

```python
from sys import stdin
n, m, v = map(int, stdin.readline().split())
matrix = [[0] * (n + 1) for _ in range(n + 1)]
for _ in range(m):
    line = list(map(int, stdin.readline().split()))
    matrix[line[0]][line[1]] = 1
    matrix[line[1]][line[0]] = 1

def bfs(start):
    visited = [start]
    queue = [start]
    while queue:
        n = queue.pop(0)
        for c in range(len(matrix[start])):
            if matrix[n][c] == 1 and (c not in visited):
                visited.append(c)
                queue.append(c)
    return visited

def dfs(start, visited):
    visited += [start]
    for c in range(len(matrix[start])):
        if matrix[start][c] == 1 and (c not in visited):
            dfs(c, visited)
    return visited

print(*dfs(v,[]))
print(*bfs(v))
```

* 결과
  * 메모리 : 37516 KB
  * 시간 : 460 ms
* 문제 풀이
  * DFS와 BFS를 함수로 구현하는 방법에 대해서는 알고 있을 것이라 예상됩니다.
  * DFS와 BFS에 대해서 모르신다면 해당 부분에 대해서 정확하게 이해하고 오는 것이 좋을 것 같습니다.
  * DFS와 BFS를 구현하기 위해서 트리나 그래프의 구조를 가지고 있어야 서로 연결된 노드들을 파악할 수 있습니다. 하지만 해당 문제에서 class node를 하면서 node를 만들고 연결해서 문제를 해결하기에는 무리가 있습니다.
  * 따라서 인접행렬 방식으로 행과 열을 통해서 값을 해당 숫자들이 연결되어 있는지 확인하도록 합니다.
  * N개의 숫자가 있으므로 `N+1 x N+1`의 행렬을 리스트를 통해서 만들고 0으로 채워줍니다.
  *  인덱스와 값을 일치시키기 위해서 `N+1`개의 숫자를 사용합니다. 0행 0열은 숫자가 없으므로 당연히 0 값으로 비어있을 것입니다.
  * 연결된 숫자들 값을 입력 받아서 해당 행과 열의 값을 `1`로 바꿔줍니다. 이를 통해서 행의 숫자와 열의 숫자가 연결되어 있다는 표시를 해줍니다.
  * DFS와 BFS를 구현한 후 해당 값을 출력합니다.

* 문제 출처

  * https://www.acmicpc.net/problem/1260

    