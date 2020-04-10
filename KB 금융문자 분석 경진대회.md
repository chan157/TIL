# KB 금융문자 분석 경진대회

## Description

**배경**

올해 1월부터 7월까지 스미싱 범죄 건수는 17만6220건으로 지난해 같은 기간(14만5093건)에 비해 21.5% 증가했습니다.

특히 최근 교묘하고 지능적인 스미싱 문자 패턴으로 인해 고객들의 피해가 증가하고 있습니다. 이를 방지하기 위해 kb 금융그룹과 KISA는 데이코너들에게 도움을 요청합니다.



총 글자수 50,000,000개의 데이터를 활용해 스미싱 탐지 모델을 개발하고 명예와 상금을 동시에 누리세요!!



**주최/주관**

\- 주최 : KB금융지주, DACON , KISA(한국인터넷진흥원)

\- 주관 : DACON

 

**참가자 대상**

\- 금융문자 분석 알고리즘 및 자연어 처리 빅데이터를 활용한 알고리즘 개발 혹은

스미싱 구분 알고리즘 개발에 관심을 보유한 일반인, 학생, 기업 등 누구나



\- **데이터 설명**

\- KB금융그룹 및 KISA(한국인터넷진흥원)에서 제공받은 정상문자와 스미싱 문자 

\- 문제 및 답안 제출 : 해당 train,public_test.csv 파일을 활용하여,public_test.csv파일에서 없는 항목인**smishing 변수의 각 예측값 확률**을 만들어제출하시면 됩니다. 

\* 주의: 제공되는 데이터에는 개인정보 보호를 위해, 개인정보로 간주될 수 있는 이름, 전화번호, 은행 이름, 지점명은 X 혹은 *로 필터링 되어 제공되며 무단 배포를 금지합니다.



## Project

```python
import pandas as pd # 데이터 전처리
import numpy as np # 데이터 전처리
import random #데이터 전처리
from pandas import DataFrame #데이터 전처리
from collections import Counter #데이터 전처리

from tqdm import tqdm #시간 측정용

from sklearn.feature_extraction.text import CountVectorizer # model setting
from sklearn.model_selection import train_test_split  # model setting

from sklearn.naive_bayes import MultinomialNB  # model 관련
from sklearn.metrics import roc_auc_score  # model 성능 확인

import konlpy  # 한글 형태소 분석
from konlpy.tag import Mecab  # Mecab 형태소 분석 
%matplotlib inline
import matplotlib.pyplot as plt  # 그래프 그리기

from tensorflow.keras.preprocessing.text import Tokenizer  # Keras Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences

from tensorflow.keras.layers import SimpleRNN, Embedding, Dense  # Model learning
from tensorflow.keras.models import Sequential

import re  # 정규식

# pandas 데이터 입력
trainData = pd.read_csv('train.csv')  # Training Data
Data = pd.read_csv('public_test.csv')  # Submission Data
submission = pd.read_csv("submission_제출양식.csv")  # submission Format
```



