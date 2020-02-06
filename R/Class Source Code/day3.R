#텍스트마이닝:text mining
#문장->형태소분석->명사,동사...->빈도표->시각화

#java설치:www.java.com

install.packages("ggiraphExtra")
library(ggiraphExtra)

str(USArrests)

head(USArrests)

library(tibble)

crime<-rownames_to_column(USArrests, 
                          var='state')
head(crime)
crime$state<-tolower(crime$state)
crime$state
str(crime)

#미국 지도 데이터 준비
library(ggplot2)
install.packages("maps")
library(maps)
states_map<-map_data('state')
str(states_map)

install.packages("mapproj")
library(mapproj)

ggChoropleth(data=crime,#지도에 표시할 데이터
             aes(fill=Murder, #색깔로 표시할 변수
                 map_id=state),#지역 기준 변수
             map=states_map)#지도 데이터

ggChoropleth(data=crime,#지도에 표시할 데이터
             aes(fill=Murder, #색깔로 표시할 변수
                 map_id=state),#지역 기준 변수
             map=states_map,#지도 데이터
             interactive = T
             )

remove.packages("devtools")

install.packages("stringi")
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)

library(dplyr)
korpop1<-rename(korpop1, 
                pop=총인구_명,name=행정구역별_읍면동)
names(korpop1)

korpop1=changeCode(korpop1)
library(ggplot2)
library(maps)
library(mapproj)
library(ggiraphExtra)
class(korpop1)
str(korpop1)
ggChoropleth(data=korpop1,#지도에 표시할 데이터
             aes(fill=pop,#색깔로 나타낼 변수
                 map_id=code,#지역 기준 변수
                 tooltip=name),
             map=kormap1)
             #interactive = T
             #)#지도 위에 표시할 지역명




ggplot(korpop1,
       aes(map_id=code, fill="총인구_명"))+
  geom_map(map=kormap1,colour="black",size=0.1)+
  expand_limits(x=kormap1$long, y=kormap1$lat)+
  scale_fill_gradientn(colours = c("white","orange","red"))+
  ggtitle("2015년 인구분포도")+
  coord_map()
  
devtools::install_github("cardiomoon/moonBook2")
ggChoropleth(korpop2,kormap2,fillvar="남자_명")

#######머신러닝#########
#통계적 기법, 연산 능력, 빅데이터
#데이터마이닝?


subject_name<-c("John", "Jane", "Steve")
temp<-c(37,35,33)
flu_status<-c(TRUE, FALSE, FALSE)
temp[2:3]
temp[-2]
temp[c(TRUE, FALSE, TRUE)]
#팩터:명목형 데이터를 표현

gender<-factor(c("M","F","M"))
gender

blood<-factor(c("O","AB","A"), 
              levels=c("O","AB","A","B"))
blood

factor(c("A","F","C"),
       levels=c("A","B","C","D","F"),
       ordered = TRUE)

subject_name
#리스트:순서x, 타입이 다양

sb1<-list(fn=subject_name[1],
     temp=temp[1],
     flu=flu_status[1])
sb1

sb1$fn
class(sb1[1])
class(sb1[[1]])

sb1[c("temp","flu")]

df<-data.frame(sb1,stringsAsFactors =FALSE)
#stringsAsFactors:팩터형으로 문자열을 읽을것인가?
str(df)

iris
#apply계열함수:함수연산을 특정단위로 쉽게 
#할 수 있도록 지원
#for,while(소규모 반복연산)
#apply(대규모 반복연산)


class(iris)
str(iris)
ncol(iris)

iris_num<-NULL
for(x in 1:ncol(iris)){
  if(is.numeric(iris[,x]))
    iris_num<-cbind(iris_num,iris[,x])
  #print(iris[,x])
}
class(iris_num)
iris_num<-data.frame(iris_num)

iris_num<-iris[,sapply(iris,is.numeric)]
class(iris_num)

iris_num<-iris[1:10, 1:4]
set.seed(123)

idx_r<-sample(1:10,2)
idx_c<-sample(1:4,2)

idx_r
idx_c
for(i in 1:2){
  iris_num[idx_r[i], idx_c[i]]<-NA
}

iris_num

#apply:행(1) 또는 열(2) 단위 연산 (MARGIN)
#입력:배열,매트랙스(같은 변수형)
#출력:매트릭스 또는 벡터

class(apply(iris_num,1,mean))
apply(iris_num,2,mean,na.rm=T)

apply(iris_num,2, function(x){x*2+1})

apply(iris_num,2, function(x){median(x*2+1, na.rm=T)})

#lappy:list +  apply => 실행 결과가 list로 출력

#데이터프레임: 
#모든 변수가 벡터를 가져야 함
#리스트:
#벡터,매트릭스,데이터프레임

apply(iris_num, 2, mean, na.rm=T)#벡터
class(lapply(iris_num, mean, na.rm=T))#리스트

#sapply : lapply와 비슷, 간단하게 기술
#연산결과가 벡터, 리스트(길이가 다른 경우)

class(sapply(iris_num, mean, na.rm=T))#벡터
class(sapply(iris_num, mean, na.rm=T, simplify = F))
#리스트

#vapply:sapply+템플릿 지정
sapply(iris_num,fivenum)
vapply(iris_num,fivenum,c("Min."=0,"1st."=0,"med"=0,"3rd"=0,"max"=0))



usedcars<-read.csv("Data/usedcars.csv", stringsAsFactors =FALSE )
str(usedcars)

summary(usedcars$year)
summary(usedcars[c("price", "mileage")])
range(usedcars$price)

diff(range(usedcars$price))
IQR(usedcars$price)
quantile(usedcars$price)

quantile(usedcars$price, seq(from=0,to=1,by=0.1))

boxplot(usedcars$price, 
        main="Car prices", ylab="price($)")
boxplot(usedcars$mileage, 
        main="Car mileage", ylab="odometer")

hist(usedcars$price, 
        main="Car prices", xlab="price($)")
hist(usedcars$mileage, 
        main="Car mileage", xlab="odometer")

var(usedcars$price)
sd(usedcars$price)
#분산(데이터-평균)의제곱의합의평균(n-1)
#표준편차 : 분산의 제곱근

table(usedcars$year)
table(usedcars$model)
table(usedcars$color)

c_table<-table(usedcars$color)
round(prop.table(c_table)*100,1)

#일변량 통계
#이변량 통계(두 변수의 관계)
#다변량 통계(두 개 이상의 변수 관계)
#산포도(이변량)

plot(x=usedcars$mileage,
     y=usedcars$price)

usedcars$conservative<-usedcars$color %in% c("Black","Gray",
                      "Silver","White")
table(usedcars$conservative)

install.packages("gmodels")
library(gmodels)
CrossTable(x=usedcars$model,
           y=usedcars$conservative)

wbcd<-read.csv("Data/wisc_bc_data.csv", stringsAsFactors = FALSE)
str(wbcd)

wbcd<-wbcd[-1]
str(wbcd)

table(wbcd$diagnosis)
str(wbcd)

wbcd$diagnosis<-factor(wbcd$diagnosis, 
                       levels = c("B","M"), 
       labels=c("Benign","Malignant"))
table(wbcd$diagnosis)
round(prop.table(
  table(wbcd$diagnosis))*100,1)
summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])



normalize<-function(x){
  return ((x-min(x)) / (max(x)-min(x)))
}
normalize(c(1,2,3,4,5))

wbcd_n<-as.data.frame(lapply(wbcd[2:31],normalize))
class(wbcd_n)
summary(wbcd_n$area_mean)

wbcd_train<-wbcd_n[1:469,]
wbcd_test<-wbcd_n[470:569,]

wbcd_train_labels<-wbcd[1:469,1]
wbcd_test_labels<-wbcd[470:569,1]

library(class)
wbcd_test_pred<-knn(train = wbcd_train,
    test = wbcd_test,
    cl = wbcd_train_labels,
    k=21)
wbcd_test_pred
library(gmodels)

CrossTable(x=wbcd_test_labels, 
           y=wbcd_test_pred,
           prop.chisq = FALSE)

#정규화:표준화는 최대/최소값이 없음.
#그값이 중심 방향으로 축소되지 않음.

wbcd_z<-as.data.frame(scale(wbcd[-1]))
summary(wbcd_z$area_mean)

#모델 -> 테스트 -> 정확도
#iris(1:35, 51:85, 101:135)=>train
#나머지 데이터 => test

install.packages("arules") 


