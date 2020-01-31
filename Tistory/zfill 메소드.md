





파이썬에서는 모든 것이 객체 



가변 타입 객체 : 한번 생성한 인스턴스의 속성, 변경 가능

ex) 리스트 클래스

```python
mutable_object = [1,2,3]
mutable_object[0] = 4
print(mutable_object)
>> [4,2,3]
```

불변 타입 객체 : 한번 생성한 인스턴스의 속성, 변경 불가

ex) 튜플

```python
immutable_object = (1,2,3)
immutable_object[0] = 4
print(immutable_object)
>> TypeError
```

이미 생성된 객체의 속성을 바꾸는 것은 불가능하지만 새로운 인스턴스를 지정하는 것은 문제가 없다.

튜플의 속성을 바꾸는 것이 아니라 새로운 튜플 인스턴스를 생성하면된다.







### `zfill` 메소드

이 메소드는 문자열을 최소 몇 자리 이상을 가진 문자열로 변환시켜줍니다. 이때 만약 모자란 부분은 왼쪽에 “0”을 채워주는데요. 예를 들어 만약 `"1".zfill(2)`을 하면 "01"을 리턴합니다. 그리고 설정된 자릿수보다 이미 더 긴 문자열이라면 그 문자열을 그대로 출력합니다. 그러니까 `"333".zfill(2)` 와 같이 하면 문자열 그대로 “333”을 리턴합니다. 아래 코드를 보면 더 쉽게 이해할 수 있습니다. 이 메소드는 문자열을 예쁘고 통일감있게 출력하고자 할 때 자주 사용되니까 꼭 기억해주세요.

```python
print("1".zfill(6))
print("333".zfill(2))
print("a".zfill(8))
print("ab".zfill(8))
print("abc".zfill(8))
```

### 실행 결과

```
000001
333
0000000a
000000ab
00000abc
```







---

# 시계 프로그램

```python
class Counter:
    """
    시계 클래스의 시,분,초를 각각 나타내는데 사용될 카운터 클래스
    """

    def __init__(self, limit):
        """
        인스턴스 변수 limit(최댓값), value(현재까지 카운트한 값)을 설정한다.
        인스턴스를 생성할 때 인스턴스 변수 limit만 파라미터로 받고, value는 초깃값 0으로 설정한다.
        """    
        self.limit = limit
        self.value = 0


    def set(self, new_value):
        """
        파라미터가 0 이상, 최댓값 미만이면 value에 설정한다.
        아닐 경우 value에 0을 설정한다.
        """
        if 0 <= new_value < self.limit:
            self.value = new_value
        else:
            self.value = 0


    def tick(self):
        """
        value를 1 증가시킨다.
        카운터의 값 value가 limit에 도달하면 value를 0으로 바꾼 뒤 True를 리턴한다.
        value가 limit보다 작은 경우 False를 리턴한다.
        """
        self.value += 1

        if self.value == self.limit:
            self.value = 0
            return True
        return False


    def __str__(self):
        """
        value를 최소 두 자릿수 이상의 문자열로 리턴한다. 
        일단 str 함수로 숫자형 변수인 value를 문자열로 변환하고 zfill을 호출한다. 
        """
        return str(self.value).zfill(2)
    

class Clock:
    """
    시계 클래스
    """
    HOURS = 24 # 시 최댓값
    MINUTES = 60 # 분 최댓값
    SECONDS = 60 # 초 최댓값

    def __init__(self, hour, minute, second):
        """
        각각 시, 분, 초를 나타내는 카운터 인스턴스 3개(hour, minute, second)를 정의한다.
        현재 시간을 파라미터 hour시, minute분, second초로 지정한다.
        """
        # 코드를 쓰세요
        self.hour = Counter(Clock.HOURS)
        self.minute = Counter(Clock.MINUTES)
        self.second = Counter(Clock.SECONDS)
        Clock.set(self,hour,minute,second)

    def set(self, hour, minute, second):
        """현재 시간을 파라미터 hour시, minute분, second초로 설정한다."""
        # 코드를 쓰세요
        self.hour.set(hour)
        self.minute.set(minute)
        self.second.set(second)

    def tick(self):
        """
        초 카운터의 값을 1만큼 증가시킨다.
        초 카운터를 증가시킬 때, 분 또는 시가 바뀌어야하는 경우도 처리한다.
        """
        # 코드를 쓰세요
        if self.second.tick():
            if self.minute.tick():
                self.hour.tick()

    def __str__(self):
        """
        현재 시간을 시:분:초 형식으로 리턴한다. 시, 분, 초는 두 자리 형식이다.
        예시: "03:11:02"
        """
        # 코드를 쓰세요
        return "{}:{}:{}".format(self.hour, 
                                 self.minute,
                                 self.second)

# 초가 60이 넘을 때 분이 늘어나는지 확인하기
print("시간을 1시 30분 48초로 설정합니다")
clock = Clock(1, 30, 48)
print(clock)

# 13초를 늘린다
print("13초가 흘렀습니다")
for i in range(13):
    clock.tick()
print(clock)

# 분이 60이 넘을 때 시간이 늘어나는지 확인
print("시간을 2시 59분 58초로 설정합니다")
clock.set(2, 59, 58)
print(clock)

# 5초를 늘린다
print("5초가 흘렀습니다")
for i in range(5):
    clock.tick()
print(clock)

# 시간이 24가 넘을 때 00:00:00으로 넘어가는 지 확인
print("시간을 23시 59분 57초로 설정합니다")
clock.set(23, 59, 57)
print(clock)

# 5초를 늘린다
print("5초가 흘렀습니다")
for i in range(5):
    clock.tick()
print(clock)
```





---

# 객체 지향 프로그래밍을 하기 위해 알아야할 **4가지 기본 개념**

- 추상화(Abstraction)
- 캡슐화(Encapsulation)
- 상속(Inheritance)
- 다형성(Polymorphism)







