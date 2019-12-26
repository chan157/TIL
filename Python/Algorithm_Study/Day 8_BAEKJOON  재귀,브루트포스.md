# Day 8_BAEKJOON  재귀,브루트포스

## Solution Only

### Problem. 10872 팩토리얼

```python
def fectorial(n):
    if n > 1 :
        return n * fectorial(n-1)
    elif n == 0:
        return 1
    else :
        return n
print(fectorial(int(input())))
```

### Problem. 10870 피보나치 수 5

```python
def fibonacci(n):
    if n == 0 :
        return 0
    elif n == 1 :
        return 1
    else:
        return fibonacci(n-1) + fibonacci(n-2)

n = int(input())
print(fibonacci(n))
```

### Problem. 2798 블랙잭

```python
n, m = map(int,input().split())
st = list(sorted(map(int,input().split())))
opt_res = 0
for i in range(len(st)-2):
    for j in range(i+1,len(st)-1):
        for k in range(j+1,len(st)):
            res = st[i] + st[j] + st[k]
            if res >= opt_res and res <= m:
                opt_res = res
print(opt_res)
                
```

### Problem. 2231 분해합

```python
n = input()
num = int(n)
start = max(num - 9*len(n),0)
res = []
for i in range(start, num):
    if num == sum(map(int,str(i)))+i:
        res.append(i)
if len(res) == 0 :
    print(0)
else:
    print(min(res))
```
```python
n = int(input())
cnt = 0
for i in range(max(n-54, 1), n):
    if n == i + sum(map(int, str(i))):
        print(i)
        cnt = 1
        break
if cnt == 0:
    print(0)
```

* 범용성을 위해서는 위의 것이 더 편할 수도 있지만 한정된 N 값에 대한 경우 속도를 위해 아래와 같이 범위를 지정하는 것도 나쁘지 않을 수 있어 보인다.

### Problem. 7568 덩치

#### My sol 01

```python
n = int(input())
guies = []
for i in range(n):
    guies.append(list(map(int,input().split())))
ranking = [ 1 for _ in range(n)]
for i in range(n):
    for j in range(n):
        if guies[i][0] < guies[j][0] and guies[i][1] < guies[j][1]:
            ranking[i] += 1
for i in ranking:
    print(i, end = ' ')
```

#### My sol 02

```python
n = int(input())
guies = [list(map(int,input().split())) for _ in range(n)]        
for a, b in guies:
    rank = 1
    for i, j in guies:
        if a < i and b < j:
            rank+= 1
    print(rank, end = ' ')
```



