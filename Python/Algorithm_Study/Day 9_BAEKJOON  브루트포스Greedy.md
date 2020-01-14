## Day 9_BAEKJOON  브루트포스Greedy

### Problem 01. 투자 귀재 규식이 1

```python
def sublist_max(profits):
    # 코드를 작성하세요. 
    max_profit = 0
    for i in range(len(profits)-1):
        profit = 0
        for j in range(1,len(profits)+1):
            profit = sum(profits[i:j])
            max_profit = max(profit,max_profit)
    return max_profit        
    
# 테스트
print(sublist_max([4, 3, 8, -2, -5, -3, -5, -3]))
print(sublist_max([2, 3, 1, -1, -2, 5, -1, -1]))
print(sublist_max([7, -3, 14, -8, -5, 6, 8, -5, -4, 10, -1, 8]))
```



### Problem 02. 거듭 제곱 빠르게 계산하기

```python
def power(x, y):
    # 코드를 작성하세요.
    if y == 0:
        return 1
    subpower = power(x,y//2)
    ## subpower에 power 계산한 값을 저장해서 사용함으로써
    ## 재사용시에 함수 계산을 반복해야하는 것을 줄일 수 있다.
    if y % 2 == 0:
        return subpower * subpower
    elif y % 2 == 1:
        return x * subpower * subpower

# 테스트
print(power(3, 5))
print(power(5, 6))
print(power(7, 9))
```



### Problem 03. 빠르게 산 오르기

```python
ㅇㅇ

```