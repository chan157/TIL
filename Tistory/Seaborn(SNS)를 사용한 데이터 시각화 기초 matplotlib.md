# Seaborn(SNS)를 사용한 데이터 시각화 기초 matplotlib

데이터과학을 공부하는데 있어 필수적인 데이터 시각화에 대해서 공부하도록 하겠습니다.

오늘은 Seaborn 과 matplotlib를 사용하여 데이터를 시각화하는 방법에 대해서 알아보겠습니다.

데이터는 기존 라이브러리에서 제공하는 데이터를 바탕으로 진행하도록 하겠습니다.



### 데이터에 따른 그래프

우선 데이터의 형태에 따라 어떤 종류의 그래프를 사용하는 것이 좋은지 알아보겠습니다.

**1차원 데이터 + 실수값, 실수분포 플롯**
-> 커너밀도, 러그, rugplot, kdeplot, distplot

**카테고리별 데이터의 양 확인**
-> countplot

**다차원데이터 (변수가 여러개)**
-> 2차원 실수형 데이터 : 스캐터플롯(jointplot)
-> 3차원 이상의 실수형 데이터 : pairplot(그리드 형테로 출력)
-> 만약 카테고리형이 포함되어 있으면 hue 속성 활용
-> 2차원 카테고리형 데이터 : heatmap

이런식으로 각 데이터의 형태나 자신이 보고싶은 그림에 맞는 plot을 그려주는 것이 중요합니다.



### Seaborn 데이터 시각화

```python
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

tips = sns.load_dataset('tips')
tips.head(6)
```

|      | total_bill | tip  | sex    | smoker | day  | time   | size |
| ---- | ---------- | ---- | ------ | ------ | ---- | ------ | ---- |
| 0    | 16.99      | 1.01 | Female | No     | Sun  | Dinner | 2    |
| 1    | 10.34      | 1.66 | Male   | No     | Sun  | Dinner | 3    |
| 2    | 21.01      | 3.50 | Male   | No     | Sun  | Dinner | 3    |
| 3    | 23.68      | 3.31 | Male   | No     | Sun  | Dinner | 2    |
| 4    | 24.59      | 3.61 | Female | No     | Sun  | Dinner | 4    |
| 5    | 25.29      | 4.71 | Male   | No     | Sun  | Dinner | 4    |

sns 라이브러리에 기본적으로 제공하는 tips 데이터셋을 불러와서 확인해 보았습니다.

```python
iris=sns.load_dataset('iris')
titanic=sns.load_dataset('titanic')
flights=sns.load_dataset('flights')
```

tip dataset 말고도 아이리시(수채화) 데이터 셋, 타이타닉 탑승자 데이터셋, 비행기 탑승자 데이터셋도 불러올 수 있습니다.





#### Regplot  

#####  - 데이터를 점으로 나타내면서 선형성을 함께 확인한다.

```python
# 지불 금액에 따른 팁의 양 : ax 객체로 선언
ax = sns.regplot(x='total_bill',y='tip',data=tips ) 
# fit_reg=False 선형선 출력하지 않는 옵션
# ax = sns.regplot(x='total_bill',y='tip',
#                 data=tips, fit_reg=False ) 
ax.set_xlabel('TB')  # x축 이름 설정
ax.set_ylabel('Tip') # y축 이름 설정
ax.set_title('Total billl and Tip') # 그래프 제목 설정
```

![1](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\1.png)



#### Jointplot 

#####  - 안쪽은 점 데이터로 분포를 확인하고 바깥쪽은 막대 그래프로 밀집도를 확인한다.

#####  - 데이터의 경향을 파악하기 좋다.

```python
joint = sns.jointplot(x='total_bill',y='tip',data=tips)
# kind='hex' 옵션을 주면 6각 분포로 출력

joint.set_axis_labels(xlabel='TB',ylabel='Tip')
# jointplot에서는 regplot과 라벨 붙이는 방식이 다름
# set_axis_labels 함수를 사용해서 라벨 설정 가능
# 굳이 라벨을 설정하지 않아도 기본 column명으로 라벨 형성
```

![2](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\2.png)

### kde : 이차원 밀집도 그래프

##### - 등고선 형태로 밀집 정도를 확인할 수 있다.

```python
# 이차원 밀집도 그래프
kde, ax = plt.subplots()
ax = sns.kdeplot(data=tips['total_bill'],
           data2=tips['tip'],
           shade=True) # shade=True 
ax.set_title('Kernel Density Plot')
```

![3](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\3.png)



### Barplot : 막대그래프

```python
ax = plt.plot()
ax = sns.barplot(x='time',y='total_bill',data=tips)
```

![4](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\4-1580204413732.png)

### Boxplot : 박스그래프

```python
sns.boxplot(x = 'day', y = 'total_bill',data=tips,
            hue='smoker', palette='Set3')
# hue = 'smoker'
# hue 옵션을 사용해서 카테고리별 비교가 가능

# palette='Set3'
# palette 색상 옵션
```

![5](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\5-1580204527725.png)



### Pairplot(data = tips)

##### - 수치에 해당하는 그래프를 전반적으로 그려줌

##### - 관계 그래프를 확인할 수 있음

##### - 전반적인 상태를 확인할 수 있어 처음 데이터를 확인할 때 전체를 파악하기 좋음

```python
# 수치에 해당하는 그래프를 전반적으로 그려줌
# 관계그래프
sns.pairplot(data = tips)
```

![6](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\6.png)



한번에 그리지 않고 원하는 그래프와 데이터로 pairplot을 그릴 수 있습니다.


```python
pg = sns.PairGrid(tips) # pairgrid 형태 만들기
pg.map_upper(sns.regplot) # 위쪽 그래프에 넣을 plot 
pg.map_lower(sns.kdeplot) # 아래쪽 그래프에 넣을 plot 
pg.map_diag(sns.distplot) # 가운데 그래프에 넣을 plot 
```

![7](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\7-1580206714859.png)

위의 pairplot과 같이 윗쪽은 regplot을, 아래쪽은 kdeplot, 그리고 가운데는 distplot을 넣어주었습니다.



#### countplot

##### - 해당 카테고리 별 데이터의 갯수를 보여주는 그래프

```python
# 요일별 팁 받은 횟수 출력
sns.countplot(x='day',data=tips)
```

![8](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\8.png)



#### heatmap

##### - 카테고리별 데이터 분류

```python
titanic_size = titanic.pivot_table(index='class'
			,columns='sex' ,aggfunc='size') 
# aggfunc='size' 각 데이터의 건수에 대해 출력
# 그냥 pivot table은 평균, 분산 등의 결과가 출력됨
titanic_size
```

![9](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\9.PNG)



```python
sns.heatmap(titanic_size, annot=True, fmt='d', cmap=sns.light_palette('red'))
# annot=True : 숫자가 출력될 수 있게
# fmt='d' : 지수형태의 숫자가 아닌 지수형태의 숫자로 변경
# cmap=sns.light_palette('red') : 색상 결정
```

![91](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\91.png)

```python
flights.head()
fp = flights.pivot('month','year','passengers') 
				  # 열인덱스, 행인덱스, 데이터    순서로 들어감
sns.heatmap(fp, linewidths=1,annot=True, fmt='d')
```

![92](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\92.png)



#### Pandas 에서 바로 plot 그리기

```python
df = pd.DataFrame(np.random.randn(100,3),
            index=pd.date_range('1/28/2020',periods=100),
            columns=['A','B','C'])
# 랜덤으로 100행 3열의 DataFrame을 생성
# index를 pd.date_range를 통해서 2020.01.28일을 기준으로 100일

# 판다스 데이터프레임에서 각 열에 대해서 그래프를 그릴 수 있음
df.plot() # 일변 변화량 또는 변동폭을 그래프로 나타냄
df.cumsum().plot()
# cumsum() : 누적합 : 누적합으로 그래프를 그리면 해당 열의 값이 어떻게 변해가는지 확인할 수 있음
# 금융, 주식 등에서 수익률을 계산할 때 활용할 수있음
```



![93](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\93.png)

![94](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\94.png)



#### pie 그래프

```python
df = titanic.pclass.value_counts()
df.plot.pie(autopct='%.2f%%')
```

![95](C:\Users\Administrator\Desktop\TIL\Azure\images\Network\95.png)