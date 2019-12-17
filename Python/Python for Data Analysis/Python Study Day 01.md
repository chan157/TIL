# Python Basic Study Day 01

### bisect


```python
import bisect
```


```python
c = [1, 2, 2, 2, 3, 4, 7]
```


```python
c.sort()
```


```python
bisect.bisect(c,2)
```




    4




```python
bisect.bisect(c,3)
```




    5




```python
c
```




    [1, 2, 2, 2, 3, 4, 7]




```python
bisect.bisect(c,1)
```




    1




```python
bisect.bisect(c,7)
```




    7




```python
bisect.insort(c,1.5)
```


```python
c
```




    [1, 1.5, 2, 2, 2, 3, 4, 7]



* 내장 bisect 모듈은 이진 탐색과 정렬된 리스트에 값을 추가하는 기능을 제공한다.

* 정렬된 상태를 유지할 수 있는 위치를 반환하고 bisect.insort는 실제로 정렬된 상태를 유지한 채 값을 추가한다.

* 주의할점은 bisect 모듈 함수는 리스트가 정렬된 상태인지 검사하지 않는다.

* 정렬되지 않은 리스트는 값이 정확하지 않을 수 있다.


```python

```


```python
a = [1,2,3,4]
```


```python
a
```




    [1, 2, 3, 4]




```python
a.sort(reverse = True)
```


```python
a
```




    [4, 3, 2, 1]



### 리스트 표기법 활용하기

#### 1번


```python
string = ['a','as','bdb','ert','dove']
```


```python
for i in range(len(string)):
    string[i] = string[i].title()
string
```




    ['A', 'As', 'Bdb', 'Ert', 'Dove']




```python
[x.replace(x[0],x[0].upper()) for x in string]
```




    ['A', 'As', 'Bdb', 'Ert', 'Dove']




```python
[x.title() for x in string]
```




    ['A', 'As', 'Bdb', 'Ert', 'Dove']




```python

```

### 몫과 나머지


```python
type(divmod(4,1.5))
```




    tuple



### 글로벌 변수


```python
a = None
```


```python
def bind_va():
    global a
    a = []
    
bind_va()
```


```python
a
```




    []



### 함수의 객체화, 문장부호 제거


```python
import re
```


```python
clean_ops = [str.strip,str.title]
```


```python
list1 = ['hi', 'whatThE!@','H@@cker']
```


```python
def remove_puctuation(value):
    return re.sub('[!@#]','',value)
```


```python
def adder(value):
    return value + '1'
```


```python
for x in map(remove_puctuation,list1):
    print(x)
```

    hi
    whatThE
    Hcker
    


```python
list1
```




    ['hi', 'whatThE!@', 'H@@cker']




```python
for x in map(adder,list1):
    print(x)
```

    hi1
    whatThE!@1
    H@@cker1
    

### 숫자 인식 오류


```python
0.1+0.2 == 0.3
```




    False




```python
import math,sys
```


```python
# math 는 수학과 관련된 함수들의 모음
# system과 관련된 함수들의 모음

```


```python
x = 0.1 + 0.2
```


```python
x
```




    0.30000000000000004




```python
sys.float_info.epsilon # 2 * 10의 -16승
# 판단의 기준으로 많이 씀
```




    2.220446049250313e-16




```python
math.fabs(x-0.3) <= sys.float_info.epsilon
```




    True




```python
x
```




    0.30000000000000004




```python
round(x,4)
```




    0.3




```python
0.3 == round(x,5)
```




    True




```python
math.isclose(0.1+0.2,0.3)
```




    True




```python

```

###  제너레이터


```python
def squares(n=10):
    print('Generating Squares from 1 to {0}'.format(n ** 2))
    for i in range(1, n+1):
        yield i ** 2
```


```python
gen = squares()
```


```python
gen
```




    <generator object squares at 0x000001BB3728D8C8>




```python
print(gen)
```

    <generator object squares at 0x000001BB3728D8C8>
    


```python
for x in gen:
    print(x, end = ' ')
```

    Generating Squares from 1 to 100
    1 4 9 16 25 36 49 64 81 100 


```python
gen 
```




    <generator object squares at 0x000001BB3728D8C8>






```python
for x in gen:
    print(x, end = ' ')
```

* 단일 값만 발생한다. 두번 실행 안먹힘


```python
gen = (x ** 2 for x in range(100))
```

* 제너레이터를 간단하게 표현 가능 


```python
gen
```




    <generator object <genexpr> at 0x000001BB3728DB48>



### itertools 모듈


```python
import itertools

first_letter = lambda x: x[0]
```


```python
names = ['Alan','Adam','Wes','Will','Albert','Steven']
```


```python
for letter, names in itertools.groupby(names, first_letter):
    print(letter, list(names))

```

    A ['Alan', 'Adam']
    W ['Wes', 'Will']
    A ['Albert']
    S ['Steven']
    


```python

```


```python

```
