Machin Learning의 개념

* 무엇(x)으로 무엇(y)을 예측하고 싶다.
* 기계학습 또는 머신 러닝은 인공 지능의 한 분야로, 컴퓨터가 학습할 수 있도록 하는 알고리즘과 기술을 개발하는 분야를 말한다. (위키피디아)



Y =f(X)

Y : 출력 변수 / 종속 변수, 반응 변수, label

X : 입력 변수 / 독립 변수, feature

f : 모델, 모형, 머신러닝 알고리즘

* 주어진 데이터를 통해서 입력 변수와 출력 변수간의 관계인 함수 f를 만들거나 데이터 속의 특징을 찾아내는 함수 f 를 만드는 것을 머신러닝이라 할 수 있다.



Machine Learning의 예시

x: 고객 정보 및 금융 관련 정보 

y: 대출 연체 여부

대출 연체자 예측 탐지 모델





f를 구하기 위해서 입력 변수와 출력 변수가 필요하다.

Y 값 예측치

X 입력값

입실론 : 오차항





선형회귀분석(Linear Regression)

* 독립변수와 종속변수가 선형적인 관계가 있다라는 가정하에 분석
* 직선을 통해 종속변수를 예측하기 때문에 독립변수의 중요도와 영향력을 파악하기 쉬움

의사결정나무(Decision Tree)

* 독립 변수의 조건에 따라 종속변수를 분리
  * 비가온다 -> 야구를 하지 않는다
  * 비가안온다 -> 야구를 한다.
* 이해하기 쉬우나 복잡한 모형에 잘 맞지 않음
* Overfitting이 잘 발생한다.
* 단일 모델로는 잘 쓰이지 않는다.

KNN(K-Nearest Neighbor)

* 새로 들어온 데이터의 주변 k개의 데이터의 class로 분류하는 기법
* k는 사람이 지정하는 인자
  * 사람이 지정해야하는 인자 : hyper parameter

신경망(Neural Network)

* 입력, 은닉, 출력층으로 구성된 모형으로서 각 층을 연결하는 노드의 가중치를 업데이트하면서 학습
* Overfitting이 심함

SVM(Support Vector Machine)

* Class간의 거리(margin)가 최대가 되도록 decision boundary를 만드는 방법
* 학습 과정에서 어느정도의 오차를 허용함
* 학습 시간이 오래걸림, 데이터가 커지면 걸리는 시간이 다른 모델들에 비해 더 오래걸림
* 요즘은 잘 안쓰임, 다른 더 좋은 모델들이 많이 나옴

Ensemble Learning 앙상블러닝

* 여러 개의 모델(classifier or base learner)을 결합하여 사용하는 모델
* 여러 모델들을 통해 나온 결론들을 가지고 투표를 함
* 최근 성능이 가장 좋은 모델

---

Unsupervised Learning

K-means clustering

* k는 하이퍼파라미터
* Label없이 데이터의 군집으로 k개로 생성
* 고차원에서 잘 안맞는 문제







딥러닝 주요 모델

* 신경망(Neural Network)
  * 입력, 은닉, 출력층으로 구성된 모형으로서 각 층을 연결하는 노드의 가중치를 업데이트하면서 학습
  * Overfitting이 심함
* Deep Learning
  * Graphical Representation Learning (핵심)
  * 다층의 layer를 통해 복잡한 데이터의 학습이 가능하도록함
  * 알고리즘 및 GPU의 발전이 deeplerning의 부흥을 이끔