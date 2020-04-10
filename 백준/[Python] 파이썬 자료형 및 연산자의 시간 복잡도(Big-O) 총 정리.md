# [Python] 파이썬 자료형 및 연산자의 시간 복잡도(Big-O) 총 정리

## 시간복잡도를 알아야하는 이유

백준에서 알고리즘을 풀다보니 '시간초과'되는 경우를 자주 겪었습니다. 문제를 풀고 나서도 결과 시간이 다른 사람들보다 상당히 높게 나오는 경우가 있었는데요. 확실히 파이썬 연산자들의 시간복잡도(Big-O)를 정확히 알고있어야한다는 필요성을 느꼈습니다. 이번 포스팅을 통해서 파이썬 자료형들과 자료형에 따른 연산자, 메소드에 따른 시간 복잡도가 얼마나 걸리는지 알아보겠습니다.

## 시간복잡도

계산 복잡도 이론에서 **시간 복잡도**는 문제를 해결하는데 걸리는 시간과 입력의 함수 관계를 가리킨다. 컴퓨터과학에서 알고리즘의 시간복잡도는 입력을 나타내는 문자열 길이의 함수로서 작동하는 알고리즘을 취해 시간을 정량화하는 것이다. 알고리즘의 시간복잡도는 주로 빅-오(Big-O)표기법을 사용하여 나타낸다. reference 위키백과

시간복잡도 = 한마디로 시간이 얼마나 걸리느냐

파이썬의 기본 산술 연산들은  `O(1)`으로 즉각적인 결과가 나타납니다.

길이가 `n`인 리스트를 처음부터 끝까지 요소를 하나씩 출력한다면, `print`함수를 `n`번 사용하므로 `O(1) x n`이므로 `O(n)`이라고 생각할 수 있습니다. 이중 for문은 `O(n²)`, 삼중 for문은 `O(n³)` 과 같은 방식으로 진행됩니다.

* 복잡한 정도

  $$
  O(1) < O(log(n)) < O(nlog(n)) < O(n^2)
  $$
  
  
  `n`의 차수가 높아질수록 시간 복잡도가 올라가고 그만큼 시간이 오래걸린다고 생각하면 됩니다. 전체적인 test case가 적으면 문제가 안됩니다. 하지만 `n`이 100,000 이상이나 가끔 백만 이상의 값들이 들어갈 경우 `n`의 차수에 따라서 걸리는 시간이 아주 급격하게 증가합니다.

![img](C:\Users\chan\Desktop\Tistory\image\시간복잡도)

출처 : https://debugdaldal.tistory.com/158



## 자료형에 따른 시간 복잡도

각 자료형과 해당 메소드, 연산자에 따른 시간 복잡도가 얼마나 되는지 알아보겠습니다. 각 자료형의 구성과 동작이 어떻게 돌아가는지 생각해보면 쉽게 시간 복잡도를 유추할 수 있습니다. 각 자료형이 어떻게 동작하는지 생각하면서 아래의 표를 보시면 쉽게 이해하실 수 있을 것입니다.



### 리스트 자료형과 메소드의 시간 복잡도

|      | Operation     | Example       | Class       | Notes                                   |
| ---- | ------------- | ------------- | ----------- | --------------------------------------- |
| 1    | Index         | l[i]          | O(1)        | 인덱스로 값 찾기                        |
| 2    | Store         | l[i] = 0      | O(1)        | 인덱스로 데이터 저장                    |
| 3    | Length        | len(l)        | O(1)        | 리스트 길이                             |
| 4    | Append        | l.append(5)   | O(1)        | 리스드 뒤에 데이터 저장                 |
| 5    | Pop           | l.pop()       | O(1)        | 가장 뒤의 데이터 pop                    |
| 6    | Clear         | l.clear()     | O(1)        | l = []                                  |
| 7    | Slice         | l[a:b]        | O(b-a)      | 슬라이싱되는 요소들 수 만큼 비례        |
| 8    | Extend        | l.extend(...) | O(len(...)) | 확장되는 길이만큼                       |
| 9    | Construction  | list(...)     | O(len(...)) | 리스트 길이만큼                         |
| 10   | check ==, !=  | l1 == l2      | O(N)        | 전체 리스트가 동일한지 확인             |
| 11   | Insert        | l[a:b] = ...  | O(N)        | 데이터 삽입                             |
| 12   | Delete        | del l[i]      | O(N)        | 데이터 삭제                             |
| 13   | Containment   | x in/not in l | O(N)        | 포함 여부 확인                          |
| 14   | Copy          | l.copy()      | O(N)        | 복제                                    |
| 15   | Remove        | l.remove(...) | O(N)        | 제거                                    |
| 16   | Pop           | l.pop(i)      | O(N)        | 제거된 값 이후를 전부 한칸씩 당겨줘야함 |
| 17   | Extreme value | min(l)/max(l) | O(N)        | 전체 데이터를 확인해야함                |
| 18   | Reverse       | l.reverse()   | O(N)        | 뒤집기                                  |
| 19   | Iteration     | for v in l:   | O(N)        | 전체 데이터 확인하므로                  |
| 20   | Sort          | l.sort()      | O(N Log N)  | 파이썬 기본 정렬 알고리즘               |
| 21   | Multiply      | k*l           | O(k N)      | 리스트의 곱은 리스트 개수 늘어남        |



### 집합(set) 자료형과 메소드의 시간 복잡도

|      | Operation      | Example       | Class            | Notes                    |
| ---- | -------------- | ------------- | ---------------- | ------------------------ |
| 1    | Add            | s.add(5)      | O(1)             | 집합 요소 추가           |
| 2    | Containment    | x in/not in s | O(1)             | 포함 여부 확인           |
| 3    | Remove         | s.remove(..)  | O(1)             | 요소 제거                |
| 4    | Discard        | s.discard(..) | O(1)             | 특정 요소 제거           |
| 5    | Pop            | s.pop()       | O(1)             | 랜덤하게 하나 pop        |
| 6    | Clear          | s.clear()     | O(1)             | similar to s = set()     |
| 7    | Construction   | set(...)      | O(len(...))      | 길이만큼                 |
| 8    | check ==, !=   | s != t        | O(len(s))        | 전체 요소 동일 여부 확인 |
| 9    | <=/<           | s <= t        | O(len(s))        | 부분집합 여부            |
| 10   | >=/>           | s >= t        | O(len(t))        | 부분집합 여부            |
| 11   | Union          | s, t          | O(len(s)+len(t)) | 합집합                   |
| 12   | Intersection   | s & t         | O(len(s)+len(t)) | 교집합                   |
| 13   | Difference     | s - t         | O(len(s)+len(t)) | 차집합                   |
| 14   | Symmetric Diff | s ^ t         | O(len(s)+len(t)) | 여집합                   |
| 15   | Iteration      | for v in s:   | O(N)             | 전체 요소 순회           |
| 16   | Copy           | s.copy()      | O(N)             | 복제                     |



### 딕셔너리(Dictionary) 자료형과 메소드의 시간 복잡도

|      | Operation      | Example     | Class       | Notes                                |
| ---- | -------------- | ----------- | ----------- | ------------------------------------ |
| 1    | Store          | d[k] = v    | O(1)        | 데이터 저장                          |
| 2    | Length         | len(d)      | O(1)        | 길이 출력                            |
| 3    | Delete         | del d[k]    | O(1)        | 요소 제거                            |
| 4    | get/setdefault | d.get(k)    | O(1)        | key에 따른 value 확인                |
| 5    | Pop            | d.pop(k)    | O(1)        | pop                                  |
| 6    | Pop item       | d.popitem() | O(1)        | 랜덤하게 선택해서 pop                |
| 7    | Clear          | d.clear()   | O(1)        | similar to s = {} or = dict()        |
| 8    | View           | d.keys()    | O(1)        | same for d.values() / 키값 전체 확인 |
| 9    | Construction   | dict(...)   | O(len(...)) | (key, value) 튜플 개수만큼           |
| 10   | Iteration      | for k in d: | O(N)        | 전체 딕셔너리 순회                   |



### 자료형에 따른 시간 복잡도 비교

메소드들의 시간 복잡도가 다르기 때문에 필요에 따라서 어떤 자료형을 사용하는 것이 좋은지 생각하면 더욱 좋은 알고리즘으로 파이썬 코드를 작성하실 수 있을 것입니다. 



List 자료형은 **삽입, 제거, 탐색, 포함여부확인 ** 모두 `O(n)`에 해당하는 시간 복잡도를 가지고 있습니다.

Set과 Dictionary는 **삽입, 제거, 탐색, 포함여부확인** 연산에 `O(1)`의 시간 복잡도를 가지고 있습니다.

탐색과 확인이 주로 필요한 연산이라면 Set이나 Dictionary를 사용하는 것이 좋고 순서와 index에 따른 접근이 필요하다면 List 자료형을 사용하는 것이 좋을 것입니다.



### 자료형에 따라서 시간 결과가 차이나는 알고리즘 예시

* 링크 추가 예정



* Reference : https://www.ics.uci.edu/~pattis/ICS-33/lectures/complexitypython.txt

  