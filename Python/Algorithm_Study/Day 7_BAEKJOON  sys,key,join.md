# Day 7_BAEKJOON  sys,key,join

## Solution Only

### Problem. 2775 부녀회장이 될테야

```python
apt = []
apt.append(list(range(1,15)))

for i in range (1,15):
    apt.append([sum(apt[i-1][:n]) for n in range(1,15)])

t = int(input())

for _ in range(t):
    a = int(input())
    b = int(input())
    print(apt[a][b-1])
```

```python
import sys
inin = sys.stdin.readline
apt = []
apt.append(list(range(1,15)))

for i in range (1,15):
    apt.append([sum(apt[i-1][:n]) for n in range(1,15)])

t = int(input())

for _ in range(t):
    a = int(inin())
    b = int(inin())
    print(apt[a][b-1])
```

* `input()` 으로 입력을 받는 것 보다 `import sys`를 통해 라인단위로 입력 받는 것이 훨씬 빠르다
* 전체 apt 인원을 계산 식을 통해 한번에 풀어준 경우

```python
cache = [[0] * 15 for _ in range(15)]
print(cache)
for i in range(15):
    cache[0][i] = i
```

* empty list를 만들어 준 후 각 자리에 맞는 값을 넣어 준 경우



### Problem. 1316 그룹 단어 체커

#### My solution

```python
def group_checker(string):
    checker = []
    for i in range(len(string)-1):
        if string[i] in checker:
            return False
        elif string[i] != string[i+1]:
            checker.append(string[i])
    if string[-1] in checker:
        return False
    return True

n = int(input())
st = []
for i in range(n):
    st.append(input())

cnt = 0
for j in st:
    if group_checker(j) :
        cnt += 1 
print(cnt)
```

#### Ranker's Solution

```python
result = 0
for i in range(int(input())):
    word = input()
    if list(word) == sorted(word, key=word.find):

        result += 1
print(result)
print(list(word))
print(sorted(word, key=word.find))
```

* Far much shorter than mine

```python
s = 'abcdefgffg'
list(s)
=> ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'f', 'f', 'g']
sorted(s, key = word.find)
=> ['a', 'b', 'c', 'd', 'e', 'f', 'f', 'f', 'g', 'g']

```



* 생각하지 못한 풀이 방법
* `key = word.find`  : Key 값을 word.find 를 사용해서 처음 발견된 순서를 바탕으로 정렬함
* 뒤에서 이미 발견된 알파벳이 발생될 경우 앞으로 정렬되면서 비교할 수 있다.

* 내장함수 활용의 중요성 !!



### Problem. 10818 최소, 최대

```python
import sys
n = int(input())
nums = list(map(int,sys.stdin.readline().split()))
print(min(nums),max(nums))
```

##### 문제 : 입력

첫째 줄에 정수의 개수 N (1 ≤ N ≤ 1,000,000)이 주어진다. 둘째 줄에는 N개의 정수를 공백으로 구분해서 주어진다. 모든 정수는 -1,000,000보다 크거나 같고, 1,000,000보다 작거나 같은 정수이다.

* 이와같이 입력되는 인수가 많을 때, `input`으로 하나씩 입력 받을 수 없다. `sys`를 잘 활용할 수 있어야한다.





### Problem. 4344 평균은 넘겠지

```python
result = []
for i in range(int(input())):
    scores = list(map(int,input().strip().split()))
    avg = sum(scores[1:])/scores[0]
    over_avg = len([x for x in scores[1:] if x > avg])
    result.append(over_avg*100/scores[0])

for i in result:
    print( '%.3f%%' % (i))
```

### Problem. 10871 X보다 작은 수

#### 문제 

* 정수 N개로 이루어진 수열 A와 정수 X가 주어진다. 이때, A에서 X보다 작은 수를 모두 출력하는 프로그램을 작성하시오.

#### 입력

* 첫째 줄에 N과 X가 주어진다. (1 ≤ N, X ≤ 10,000)

  둘째 줄에 수열 A를 이루는 정수 N개가 주어진다. 주어지는 정수는 모두 1보다 크거나 같고, 10,000보다 작거나 같은 정수이다.

#### My sol 01

```python
import sys
n,x = map(int,input().split())

for i in range(1, n + 1):
    inputs = list(map(int,sys.stdin.readline().split()))
    for i in inputs:
        if i < x :
            print(i,end = ' ')
```

##### My sol 02

```python
n,x = map(int,input().split())
score = [ i for i in input().split() if int(i) < x]
print(' '.join(score))
```

* 두 풀이의 속도 차이가 10배 차이난다.
* 두번째 솔루션이 첫 번째의 10% 시간만 소비한다.
* 첫 번째의 경우 for 문을 2번 돌면서 출력해야한다.
* 두번째는 점수 리스트를 만들때 필요한 해당되는 애들만 받아와서 리스트를 형성해준다. 
* 해당 리스트의 값들을 `join` 내장 함수를 사용해서 한번에 쫙 붙여서 출력한다.

### Problem. 2908 상수

```python
num1, num2 = input().split()
num1_s = int(num1[-1::-1])
num2_s = int(num2[-1::-1])
print(max(num1_s,num2_s))
```
### Problem. 2941 크로아티아 알파벳

```python
croa = ['c=','c-','dz=','d-','lj','nj','s=','z=']
string = input()
for i in croa:
    string = string.replace(i,' ')
print(len(string))
```


### Problem. 5622 다이얼

#### Sol 01

```python
string = input()
dic = {'A': 3, 'B' : 3, 'C' : 3,
       'D': 4, 'E' : 4, 'F' : 4,
       'G': 5, 'H' : 5, 'I' : 5,
       'J': 6, 'K' : 6, 'L' : 6, 
       'M': 7, 'N' : 7, 'O' : 7,
       'P': 8, 'Q' : 8, 'R' : 8, 'S' : 8,
       'T': 9, 'U' : 9, 'V' : 9,
       'W': 10, 'X' : 10, 'Y' : 10, 'Z' :10 }

print(sum(dic[i] for i in string))
```

#### Sol 02

```python
string = input()
dic = {'ABC': 3,'DEF': 4, 'GHI': 5,
       'JKL': 6,'MNO': 7,'PQRS': 8,
       'TUV': 9,'WXYZ': 10}
            
print(sum([dic[word] for i in string for word in dic if i in word ]))
```

#### Sol 03

```python
print(sum('ABC DEF GHI JKL MNO PQRSTUV WXYZ'.find(c)//4+3for c in input()))
```





