library(arules)
help(Epub)
data(Epub)
summary(Epub)

itemFrequency(Epub[,1:10])
itemFrequencyPlot(Epub,
                  support=0.01,
                  main='item frequency')
image(sample(Epub,500))

epub_rule = apriori(data=Epub,
                    parameter = list(support = 0.001,
                                     confidence = 0.2,
                                     minlen=2))
summary(epub_rule)
inspect(epub_rule)


inspect(sort(epub_rule, by='lift')[1:10])
inspect(sort(epub_rule, by='support')[1:10])

rule_ins <- subset(epub_rule, items %in% c('doc_72f','doc_4ac'))
inspect(rule_ins)

rule_ins_lhs <- subset(epub_rule, lhs %in% c('doc_72f','doc_4ac'))
inspect(rule_ins_lhs)

# lhs 왼쪽만
# rhs 오른쪽만
# items 모두

# %pin% partitial in 부분적으로 c함수 안에 있는 애들이면 True
rule_ins_par <- subset(epub_rule, items %pin% c('60e'))
inspect(rule_ins_par)

# %ain% : 완전히 전부 있어야함
rule_ins_par <- subset(epub_rule, lhs %ain% c('doc_6e8','doc_6e9'))
inspect(rule_ins_par)

rule_ins_par <- subset(epub_rule, items %pin% c('60e') & confidence>0.25)
inspect(rule_ins_par)


install.packages('arulesViz')
# 연관규칙 전용 시각화 툴
library(arulesViz)
plot(epub_rule)
plot(sort(epub_rule, by='support')[1:20],method='grouped')
plot(epub_rule, method = 'graph',control = list(type='items'))

plot(epub_rule, method = 'graph',control = list(type='items'),
     vertex.label.cex=0.7, # 점의크기 (기본: 1) 동그란 원
     edge.arrow.size=5, # 화살표의 크기 
     edge.arrow.width=2 # 화살표 너비비
     )

# 원의 크기 : 지지도에 비례
# 원의 색깔 : 향상도에 비례
# 화살표 :lhs->rhs
 

library(readr)
teen <- read_csv("C:/rstudio_bc/r/dataset_for_ml/snsdata.csv")
#View(teen)
str(teen)
table(teen$gender, useNA = 'ifany') # NA의 데이터도 보기 위해서
# 범주별로 보면 되므로 데이터요약을 보려면 table 함수
# 수치 데이터는 ?
summary(teen$age) # summary로 확인가능
# NA 5086
# 이상치 데이터를 NA로 넣음
# 13세 미만 20세 이상으로 정의했음
# 100살이랑 3살이 sns한다는 것은 말이 안됨
teen$age <- ifelse(teen$age >= 13 & teen$age<20,teen$age,NA)
summary(teen$age)
# NA 5523 개 200개 정도가 늘어났음
# 결측값 처리가 필요


teen$female <- ifelse(teen$gender=='F' & !is.na(teen$gender),1,0)
table(teen$female)

teen$no_gender <- ifelse(is.na(teen$gender),1,0)
table(teen$gender, useNA = 'ifany')
table(teen$female)
table(teen$no_gender)

mean(teen$age, na.rm=T) # na 제외한 사람들의 나이 평균
#유용한 함수
my_agg <- aggregate(data=teen, age~gradyear,mean )
my_agg
# 그룹(졸업연도)에 대한 통계(평균) 계산 => 한번에 해주는 함수 aggregate
# groupby를 안해도됨
# 졸업 연도
# 데이터프레임으로 출력

ave_age <- ave(teen$age, teen$gradyear, FUN=
      function(x) mean(x,na.rm=TRUE))
ave_age

# =>> ave를 이용하면
# ifelse를 사용해서  NA인 경우 그 졸업연도에 따른 나이대 평균을 바로 넣어줄 수 있음

ifelse(is.na(teen$age),my_agg,teen$age) # 이렇게 하면 값이 안들어감

teen$age <- ifelse(is.na(teen$age),ave_age,teen$age) # ave를 사용한 것으로 넣어야함함
summary(teen$age)

interests<-teen[5:40]
set.seed(2345) #
# 표준화 진행
interests_z <- as.data.frame(lapply(interests, scale))
interests_z


library(stats)
help("kmeans")

head(interests_z)

teen_clusters<-kmeans(interests_z,5)
teen_clusters$size
head(teen_clusters)

teen_clusters$centers
# 컴퓨터가 해주는 부분은 여기까지
# 다음은 해석을 잘 하는 것이 가장 중요하다.
# 해당 Domain을 잘 해석해줄 수 있는 Domain 전문가가 필요하다.!


teen_clusters$cluster

teen$cluster <- teen_clusters$cluster

teen[1:20,c('cluster','gender','age','friends')]

# 클러스터 단위로 나이에 대한 평균
# aggregate(데이터, 알고싶은 것~그룹화 단위, 함수)
aggregate(data=teen, age~cluster,mean)

aggregate(data=teen, female~cluster,mean)
# female 값이 높다고 무조건 남자가 많은 것이 아니다.
# 초기 데이터의 비율에서 애초에 여자가 많았기 때문에
# 그 비율을 기반으로 생각해야한다.
# 4번5번 그룹은 남자가 더 많은 그룹일 수 있다.







# 문제
# 아이리스 data : 3개의 그룹으로 나눠짐
# 알지만 그래도 한번 나눠 보시라
# 어느정도 정확도가 나오는지 확인 해보기

iris
head(iris)
iris_data <- iris[-5]
iris_z <- as.data.frame(lapply(iris_data,scale))
set.seed(2345)
iris_cluster <- kmeans(iris_z, 3)
iris_cluster$cluster

iris_specis <- ifelse(iris$Species=='setosa',3,ifelse(iris$Species=='versicolor',2,1))
table(iris_specis, iris_cluster$cluster)




library(gmodels)
CrossTable(x=iris_cluster$cluster, y= iris_specis,
           prop.chisq = F ) # 안필요해서서


# 해당 결과 시각화
library(ggplot2)
#irisCluster$cluster <- as.factor(irisCluster$cluster)
ggplot(iris, aes(Petal.Length, Petal.Width, color = iris_cluster$cluster)) + geom_point()
plot(iris[-5], pch = iris_cluster$cluster, col = iris_cluster$cluster)

sum(iris_cluster$cluster == iris_specis)*100/length(iris_specis)












library(datasets)
head(iris)
data(iris)
iris
# ggplot2로 시각화 
library(ggplot2)
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()
iris$Cluster <- factor(iris$Species, labels = c(3,1,2))
iris$Cluster

iris$Cluster
# k-mean을 통한 분류 
iris[, 3:4]
set.seed(20)
irisCluster <- kmeans(iris[, 3:4], 3, nstart = 20)
irisCluster$cluster

# 각 종별로 클러스터 비교 
table(irisCluster$cluster, iris$Cluster)

# 해당 결과 시각화

irisCluster$cluster <- as.factor(irisCluster$cluster)
ggplot(iris, aes(Petal.Length, Petal.Width, color = irisCluster$cluster)) + geom_point()
plot(iris, pch = irisCluster$cluster, col = irisCluster$cluster)
irisCluster$cluster
# 정답률 비교
sum(iris$Cluster == irisCluster$cluster)*100/length(iris$Cluster)
