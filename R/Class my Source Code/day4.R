install.packages("arules")
library(arules)

groceries<-read.transactions("r/dataset_for_ml/dataset_for_ml/groceries.csv",
                    sep=",")
summary(groceries)
# summary를 꼭 봐야한다.
# 최빈 item이 milk 인데 전체 9800개 중에서 가장 많이 나온게 2500건이므로
# 지지도가 0.3이 안된다는 소리이다. 그러므로 최소 지지도 설정을 잘 해주어야한다.

# 169 columns => 전체 상품의 종류가 
# 1~32 : 거래 당 구매 상품의 개수
# size 에서 1 은 1 거래에 1개의 상품을 구매한 경우 2159건
# size 에서 32 은 1 거래에서 32건의 상품을 구매한 경우 1건

# 희소 행렬 안에 있는 내용을 보기 위해서는 
# inspect 함수를 사용해야한다.
inspect(groceries[1:5])

itemFrequency(groceries[1:5,11:15]) # 아이탬의 구매 비율 

itemFrequencyPlot(groceries, support=0.1) # support 지지도 0.1 이상인 것들만
itemFrequencyPlot(groceries, topN=20) # 상위 20개
image(groceries[1:100]) # 희소행렬 
image(sample(groceries,100)) # sample 함수로 임의로 100개를 뽑아 희소행렬

# help apriori
# apriori(data, parameter = NULL, appearance = NULL, control = NULL)
apriori(groceries) # Default -> 최소 지지도가 0.1, 최대 신뢰도 0.8로 설정되어있음
# Default 조건에 맞는 경우가 없어서 실행하면 set of 0 rules : 0건이 나옴
groceryRules <- apriori(groceries, 
                       parameter = list(support=0.006, 
                                        confidence=0.25,
                                        minlen=2))
# 두 개 미만의 아이템을 갖는 규칙은 안쓰겠다. -> 최소 두개 이상의 아이템을 가지는 경우만 보겠다.
groceryRules
inspect(groceryRules[1:5])
summary(groceryRules)

inspect(sort(groceryRules, by='lift')[1:10])
# lift 높은 애들을 중점적으로 보아야한다.
# 허브를 산 사람들이 채소를 살 가능성이
# 채소를 산 일반고객보다 4배가 더 높다.

berryRules <- 
  subset(groceries, items %in% 'berries') # berries가 포함된 모든 규칙을찾아라
inspect(berryRules[1:10])

berryANDyogurt <- 
  subset(groceries, items %in% c('berries','yogurt'))
inspect(berryANDyogurt[1:10])

# 파일로 만들어 줄 수 있다.
write(groceryRules, file = 'groceryRules.csv',sep=',', quote=FALSE)
# 데이터 프레임으로 변경할 수 있다.
head(grdf)

# Epub 데이터에 대한 설명
help(Epub)

data(Epub) # Data load
summary(Epub)

