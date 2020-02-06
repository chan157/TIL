install.packages("arules")
library(arules)
#groceries<-read.csv("Data/groceries.csv", sep=",")
groceries<-read.transactions("Data/groceries.csv", 
                             sep=",")
summary(groceries)
#169:거래내역에서 전체 상품의 종류의 갯수
#1~32:거래 당 구매 상품의 갯수

inspect(groceries[1:5])

itemFrequency(groceries[, 150:169])

itemFrequencyPlot(groceries, support=0.1)
itemFrequencyPlot(groceries, topN=20)
image(groceries[1:5])
image(sample(groceries,100))
#apriori(groceries)
groceryRules<-
  apriori(groceries, 
          parameter =list(support=0.006, 
                          confidence=0.25,
                          minlen=2) )
#min=2는 2개 미만의 아이템을 갖는 규칙은 제거
summary(groceryRules)
inspect(groceryRules[1:3])

inspect(sort(groceryRules, by="lift")[1:5])
#3.956477의 의미는 대략 4
#허브를 산 사람들이 채소를 살 가능성이
#채소를 산 일반고객보다 4배가 더 높다.

berryRules<-subset(groceryRules, items %in% c("berries","yogurt"))

inspect(berryRules)

write(groceryRules, 
      file='groceryRules.csv',sep=",")
class(groceryRules)
grdf<-as(groceryRules, "data.frame")
grdf
str(grdf)

data(Epub) #load
help(Epub)
summary(Epub)











