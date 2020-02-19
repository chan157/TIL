# [Kaggle] Bike Sharing Demand

![0.kaggle](../../Azure/images/Network/0.kaggle.png)



그동안 기본 임시 데이터를 가지고 Python 데이터 분석에 대해서 공부했습니다.

이제는 이론적인 공부를 넘어서 Kaggle에서 실제 데이터를 가지고 데이터 분석을 진행하려고 합니다.

## What is Kaggle?

Kaggle은 데이터 분석 및 머신러닝에 대한 경쟁과 학습을 위한 플랫폼입니다. 사실 교육 보다는 Kaggle의 핵심은 Competition에 있다고 생각합니다.

실제 데이터를 바탕으로 누가 더 높은 정확도를 가지는 model을 설계하여 예측할 수 있는지를 경쟁합니다. 결과가 바로 Leader Board에 올라가서 등수와 점수가 게시됩니다. 그래서 더욱 흥미진진하게 경쟁할 수 있겠죠.

또한, 다양한 기관과 기업에서 자기들의 데이터를 competition에 상금과 함께 올려 solution을 찾아가기도 합니다. 

## Kaggle 첫 번쨰 도전

그 첫 번째 도전으로 **<Bike Sharing Demand>**에 도전하려고합니다.

이미 끝난 대회이지만, 실습 느낌으로 진행하려고해요.



## 자전거 공유 시스템 수요 예측

사람들은 한 장소에서 자전거를 빌려서 필요에 따라 다른 장소로 반납할 수 있습니다. 이러한 시스템에서 생성된 데이터는 이동 기간, 출발 위치, 도착 위치 및 경과 시간을 명시적으로 기록하기 때문에 연구자들에게 매력적입니다. 따라서 자전거 공유 시스템은 도시의 이동성을 연구하는 데 사용될 수 있는 센서 네트워크 역할을 합니다. 이번 대회에서 참가자들은 워싱턴 D.C.의 캐피털 바이케쉬 프로그램에서 자전거 대여 수요를 예측하기 위한 것입니다. 과거 사용 패턴을 날씨 데이터와 결합해서 몇대의 자전거가 필요할 것인지 예측하여 확률을 도출하면 됩니다.



* 한줄 요약

  주어진 데이터를 바탕으로 자전거 수요를 예측하는 것입니다.

  

자전거 예측 시스템 kaggle link: 

https://www.kaggle.com/c/bike-sharing-demand



## Data Fields 데이터 구성

**datetime** - hourly date + timestamp  
**season** -  1 = spring, 2 = summer, 3 = fall, 4 = winter 
**holiday** - whether the day is considered a holiday
**workingday** - whether the day is neither a weekend nor holiday
**weather** 

1: Clear, Few clouds, Partly cloudy, Partly cloudy
2: Mist + Cloudy, Mist + Broken clouds, Mist + Few clouds, Mist
3: Light Snow, Light Rain + Thunderstorm + Scattered clouds, Light Rain + Scattered clouds
4: Heavy Rain + Ice Pallets + Thunderstorm + Mist, Snow + Fog 
**temp** - temperature in Celsius
**atemp** - "feels like" temperature in Celsius
**humidity** - relative humidity
**windspeed** - wind speed
**casual** - number of non-registered user rentals initiated
**registered** - number of registered user rentals initiated
**count** - number of total rentals



traindata

![1.traindata](../../Azure/images/Network/1.traindata.jpg)

testdata

![2. testdata](../../Azure/images/Network/2. testdata.JPG)



testdata에는 casual(비회원 사용횟수), registered(회원 사용횟수), count(총 랜트해간 사용횟수) 데이터가 빠져있습니다.

결과물에는 count 값만 확인해서 해당 조건에서 자전거를 얼마나 빌려갈 것인지를 예측하면 됩니다.



지금까지 Kaggle을 시작 도입이야기와 자전거 공유 시스템 수요 예측 데이터에 대해서 간단하게 애기하였습니다.



다음 게시글을 통해서 계속해서 파이썬을 이용한 데이터 분석을 진행하겠습니다.