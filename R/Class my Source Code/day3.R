# 텍스트 마이닝 : text mine
# 텍스토로된 빅데이터를 분석하는 것
# 수많은 문자 데이터에서 가치있는 정보를 캐내는것 / 가져오는 것
"""
텍스트 마이닝을 위해서는 자바가 설치되어있어야 한다.
java 설치 : www.java.com

install.packages('rJava')
install.packages('memoise')
install.packages('KoNLP')
3개의 패키지를 설치한다.

"""
install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")
library(rJava)
Sys.setenv(JAVA_HOME=)
library(KoNLP)


library(readxl)
library(dplyr)
library(ggplot2)


###############################################
#시각화를 위한 라이브러리
#조금 더 다양한 시각화가 가능
install.packages('ggiraphExtra')
library(ggiraphExtra)

#내장 데이터 불러오기
#미국 범죄 관련 데이터
USArrests
str(USArrests)
head(USArrests) # 미국의 주 단위로 구분되어있음

#행 이름을 열로 변환
library(tibble)
crime <- rownames_to_column(USArrests, var='state')
head(crime)
crime$state <- tolower(crime$state) # 소문자로 통일
crime$state

#미국 지도 데이터 준비
library(ggplot2)
install.packages('maps')
library(maps)
states_map <- map_data('state')
str(states_map)

install.packages('mapproj')
library(mapproj)
ggChoropleth(data = crime, # 지도에 표시할 데이터
             aes(fill=Murder, # 색깔로 표시할 데이터 
                 map_id=state), # 지역 기준 변수
             map=states_map, # 지도 데이터
             interactive = T) 

install.packages('stringi')
install.packages('devtools')
library(stringi)
library(devtools)
# devtools 패키지를 통해서 github에 있는 패키지를 불러오기 위한 패키지

devtools::install_github('cardiomoon/kormaps2014')
library(kormaps2014)

str(korpop)

################################################3
"""
머신러닝
통계적 기법, 연산 능력, 빅데이터
데이터마이닝 : 데이터 속에서 통계적 기법을 통해 규칙을 찾아내는 것이다.


"""
subject_name <- c("John",'Jane','Steve')
subject_name
temp <- c(37,35,33)
flu_status <- c(TRUE,FALSE,TRUE)
temp[-2] # 마이너스는 해당 인덱스를 제외한 나머지가 추출
temp[c(TRUE, FALSE, FALSE)] # True에 해당되는 값만 추출
# 팩터 : 
# 범주 값을 가진다.
gender <- factor(c('M','F','M'))
gender
blood <- factor(c('O','AB','A'),levels=c('O','AB','A','B'))
blood

GDP <- factor(c('A','F','C'),
       levels=c('F','D','C','B','A'),
       ordered =TRUE)
GDP

subject_name
# R 에서의 리스트
# 리스트 : 순서X, 타입이 다양해도 된다.

sb1 <- list(fn=subject_name[1],
            temp=temp[1],
            flu=flu_status[1])
sb1$fn
class(sb1[1])
class(sb1[[1]])

sb1[c('temp','flu')]

df<-data.frame(sb1)
df
str(df) # factor 타입으로 들어감, 문자 자체를 타입으로 받으려면 stringAsFactors를 사용해야한다.
# 문자열 데이터를 factor형으로 읽을 것인지를 묻는 것
df<-data.frame(sb1, stringsAsFactors = FALSE)
str(df) # char 형태로 바뀐 것을 확인할 수 있다.
df

## 
# apply 계열 함수 : 함수 연산을 특정단위로 쉽게 할 수 있도록 지원한다.
iris_num <- NULL

for(x in 1:ncol(iris)){
  if(is.numeric(iris[,x]))
    iris_num<-cbind(iris_num,iris[,x])
}
iris_num <- iris[,sapply(iris,is.numeric)]
class(iris_num)

iris_num<-[1:10,1:4]
set.seed(123)

idx_r <- sample(1:10,2)
idx_c <- sample(1:4,2)
idx_r
idx_c

for(i in 1:2){
  iris_num[idx_r[i], idx_c[i]] <- NA
}

iris_num

#apply : 행(1) 또는 열(2) 단위 연산 
#입력:배열,매트릭스
#출력:매트릭스 또는 벡터
apply(iris_num,1,mean)
apply(iris_num,2,mean,na.rm=T)
iris_num

apply(iris_num,2,function(x){x*2+1})
# lappy :  list 실행결과가 list
f sapply(iris_nu,.iman?tapply(vector, index, function))

#vapply : spply+템플릿 지정

sapply(iris_num,fivenum)
vapply(iris_num,fivenum,c('Min')
       
       
usedcars<-read.csv("C:/rstudio_bc/r/dataset_for_ml/dataset_for_ml/usedcars.csv",
                   stringsAsFactors = FALSE)
usedcars
str(usedcars)
summary(usedcars$year)
summary(usedcars[c('price','mileage')])
range(usedcars$price)
diff(range(usedcars$price))
IQR(usedcars$price)
quantile(usedcars$price)
quantile(usedcars$price, seq(from=0,to=1,by=0.1))

boxplot(usedcars$price,main='Car prices',ylab='prices($)')
boxplot(usedcars$mileage,main='Car mileage',ylab='odometer')

hist(usedcars$price,main='Car prices',xlab='prices($)')

hist(usedcars$mileage,main='Car mileage',xlab='odometer')

# 분산, 표준편차
var(usedcars$price)
sd(usedcars$price)

table(usedcars$year)
table(usedcars$model)
c_table<-table(usedcars$color)

round(prop.table(c_table)*100,1)
#일변량 통계


# 이변량 통계(두 변수의 관계)
# 산포도(이변량 관계 시각화 다이아그램)
# 다변량 통계(두 개 이상의 변수 관계)

# 산포도
plot(x=usedcars$mileage,
     y=usedcars$price)
# 반비례 관계를 확인할 수 있다. 음의 상관관계를 확인할 수 있다.
# 강한 음의 상관관계를 확인할 수 있다.

usedcars$color %in% c("Black",'Gray','Silver','White')

usedcars$conservative <- usedcars$color %in% c("Black",'Gray','Silver','White')
table(usedcars$conservative)

install.packages('gmodels')
library(gmodels)
CrossTable(x=usedcars$model,
           y=usedcars$conservative)
wbcd
wbcd<-read.csv("C:/rstudio_bc/r/dataset_for_ml/dataset_for_ml/wisc_bc_data.csv",
               stringsAsFactors = F)
str(wbcd)
head(wbcd)
wbcd

# id 열은 암과 관련이 없으므로 제거한다.
head(wbcd[-1])

wbcd
str(wbcd)
wbcd <-wbcd[-1]

#################################################
table(wbcd$diagnosis)
str(wbcd)
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c('B','M'),
                        labels=c('Benign','Malignant'))
wbcd$diagnosis
table(wbcd$diagnosis)
prop.table(table(wbcd$diagnosis))
round(prop.table(table(wbcd$diagnosis))*100,1)
summary(wbcd[c('radius_mean','area_mean','smoothness_mean')])
# 3개의 값들의 단위가 너무 차이가 많이 나므로
# 데이터 자체로 거리를 구하기에는 무리가 있다. 각 값들 크기가 달라서
# 정규화가 필요하다.!

normalize<-function(x){
  return ( (x-min(x)) / (max(x)-min(x)) )
}

normalize(c(1,2,3,4,5))
# lapply 는 출력이 list형태이다.
# 적용하고 데이터프래임 형태로 타입을 바꿔준다.
wbcd_n <- as.data.frame(lapply(wbcd[2:31],normalize)) # 첫 열은 숫자아니므로
class(wbcd_n)
summary(wbcd_n$area_mean)

# train data와 test data로 나눠주자.

wbcd_train <- wbcd_n[1:469,]
wbcd_test <- wbcd_n[470:569,]

wbcd_train_labels <- wbcd[1:469,1]
wbcd_test_labels <- wbcd[470:569,1]

library(class) # knn이 class 라이브러리에 들어있음
""" knn help 검색 결과
Usage
knn(train, test, cl, k = 1, l = 0, prob = FALSE, use.all = TRUE)
"""
# knn 통상적으로 전체 데이터에 제곱근 만큼을 k 값으로 준다.
wbcd_test_pred <- knn(wbcd_train, wbcd_test, wbcd_train_labels ,k=21)
library(gmodels)
# crosstable을 사요ㅗㅇ하기 위해

score <- sum(wbcd_test_pred == wbcd_test_labels)
score / length(wbcd_test_pred)

CrossTable(x=wbcd_test_labels, y= wbcd_test_pred,
           prop.chisq = F ) # 안필요해서서

score_board <- c(1:300) # 빈칸 백터
# K의 값을 1에서 300까지 주면서 정답률 저장
for(i in 1:300){
  wbcd_test_pred <- knn(wbcd_train, wbcd_test, wbcd_train_labels ,k=i)
  true_Value <- sum(wbcd_test_pred == wbcd_test_labels)
  answer_prop <- true_Value / length(wbcd_test_pred)
  score_board[i] <- answer_prop
}
# 데이터프레임으로 타입 변경
df <- as.data.frame(score_board)
index <- c(1:300)
# ggplot을 사용해서 변화 추이 시각화
ggplot(data=df,
       aes(x = index, y = score_board))+geom_line(color='blue', size=1.5)




# 정규화 : 표준화
# 표준화는 최대 최소 값이 없다.
# 그 값이 중심 방향으로 축소되지 않는다.

# 표준화            
wbcd_z <- as.data.frame(scale(wbcd[-1])) # 매우 간단하게 표준화 가능
summary(wbcd_z$area_mean)
summary(wbcd_z$radius_mean)

# 모델 -> 테스트 -> 정확도
wbcd_train <- wbcd_z[1:469,]
wbcd_test <- wbcd_z[470:569,]

wbcd_train_labels <- wbcd[1:469,1]
wbcd_test_labels <- wbcd[470:569,1]

wbcd_knn_test <- knn(train = wbcd_train, test = wbcd_test,
                     cl = wbcd_train_labels, k=3)

CrossTable(x=wbcd_knn_test, y=wbcd_test_labels)
table(wbcd_knn_test == wbcd_test_labels)

score <- sum(wbcd_knn_test == wbcd_test_labels)
score / length(wbcd_test_pred)



score_board2 <- c(1:300) # 빈칸 백터
# K의 값을 1에서 300까지 주면서 정답률 저장
for(i in 1:300){
  wbcd_knn_test <- knn(wbcd_train, wbcd_test, wbcd_train_labels ,k=i)
  true_Value <- sum(wbcd_knn_test == wbcd_test_labels)
  answer_prop <- true_Value / length(wbcd_knn_test)
  score_board2[i] <- answer_prop
}
# 데이터프레임으로 타입 변경
df2 <- as.data.frame(score_board2)

index <- c(1:300)
# ggplot을 사용해서 변화 추이 시각화
ggplot(data=df,
       aes(x = index, y = c(score_board,score_board2)))+geom_line(color='blue', size=1.5)
max(df)











#############
# 일반적으로 데이터가 있으면
7:3 비율로 test와 train으로 나눈다.
그중에서 또 7을
7대 3으로 나눠서 
train과 valid로 사용한다.

# iris(1:35,51:85,101:135) 이 데이터ㅡㄹ 뽑아서 train으로 
# 나머지를 test로 사용해서 분류결과를 만들어 봅시다.
iris_train <- full_join(full_join(iris[1:35,],iris[51:85,]),iris[101:135,])
iris_test <- full_join(full_join(iris[36:50,],iris[86:100,]),iris[136:150,])
data <- full_join(iris_train,iris_test)

data_z <- as.data.frame(scale(data[-5]))

train_data <- data_z[1:105,]
test_data <- data_z[106:149,]
train_labels <- data[1:105,5]
test_labels <- data[106:149,5]

result <- c(1:100) # 빈칸 백터
result
for(i in 1:100){
knn_result <- knn(train = train_data,
                  test = test_data,
                  cl = train_labels,
                  k = i)
result[i] <- round(sum(knn_result == test_labels)*100/44,1)
}
index <-c(1:i)
ggplot(data=df, aes(x=index,y=result))+
  geom_point(color='red', size=2)
  

