a<-1
a
v1 <- c(1,2,5,8,9)
v1
v2 <-seq(1,5)
v2


v3 + 1


s1<-'a'
s2<-'text'
s3<-'hi'
s4 <- c(s1,s2,s3)
s4

s5 <- paste(s4, collapse=",")
s5


install.packages('ggplot2')

library(ggplot2)

x <- c("a","a","b","c")
x
qplot(x)
# 빈도그래프
mpg
qplot(data=mpg, x=hwy)
qplot(data=mpg, x=hwy)

qplot(data=mpg, x=drv, y=hwy)

qplot(data=mpg, x=drv, y=hwy, geom='line')
qplot(data=mpg, x=drv, y=hwy, geom='boxplot', color=drv)

eng <- c(90,80,60,70)
math <- c(50,10,20,90)
class <-c(1,1,2,2)

math
math + eng


# DataFrame 만들기
data.frame(eng,math)
df_mid <- data.frame(eng,math)
df_mid
str(df_mid)
df_mid <- data.frame(eng, math, class)
df_mid

df_mid$eng
mean(df_mid$eng)


install.packages('readxl')
library(readxl)

df <- read_excel('C:/rstudio_bc/r/Data/excel_exam.xlsx')
df
df <- read_excel('r/Data/excel_exam.xlsx')
df


df$english


novar_df <- read_excel('C:/rstudio_bc/r/Data/excel_exam_novar.xlsx', col_names=F)
novar_df


df <- read.csv('r/Data/csv_exam.csv')
df

str(df)

write.csv(df, file='mydf.csv')
head(df,10)


tail(df,10)

View(df)

install.packages('dplyr')
library(dplyr)

df2 <- data.frame(v1=c(1,2,1),v2=c(2,3,2))
df2
df2 <- rename(df2, var1=v1)
df2


df2$vsum <- df2$var1 + df2$v2
df2

str(mpg)

# total 컬럼 추가 hwy와 cty의 평균으로

mpg$total <- (mpg$hwy + mpg$cty)/2

mpg$hwy
mpg$cty


summary(mpg$total)

mpg$test <- ifelse(mpg$total>=20,'pass','fail')
head(mpg$test,20)
table(mpg$test)

qplot(mpg$test)


mpg$grade <- ifelse(mpg$total>30,'A',ifelse(mpg$total>20,'B',ifelse(mpg$total>10,'C','D')))
mpg$grade

qplot(mpg$grade)

exam = read.csv('r/Data/csv_exam.csv')
exam

# ctrl + shift + M => %>% 
exam %>% filter(class==1) %>% filter(math>=60) 

exam %>% filter(class==2) %>% filter(english>=80)
exam %>% filter(class==2 & english>=80)

exam %>% filter(class ==1 | class == 3 | class == 5)


exam %>% select(math)
exam %>% select(-math, -class)

#class가 1인 행에 대해 english를 추출하라
exam %>% 
  filter(class==1) %>% 
  select(english)

exam %>% 
  select(id,math) %>% 
  head(6)

exam %>%
  arrange(math)

# desending 내림차순 정렬
exam %>%  arrange(desc(math))

# class 기준 오름차순 정력
exam %>%  arrange(class)

# class 기준 정렬 후 그 다음 인자는 math로 정렬하기
exam %>%  arrange(class,math)


#science가 60점 이상 pass, 미만 fail
# test 열을 추가
exam$test = ifelse(exam$science >= 60,'pass','fail')
exam
df
exam %>% 
  mutate(test2=ifelse(exam$science >= 60,'pass','fail'))

exam$total_score = exam$english + exam$science + exam$math
exam %>% arrange(total_score) %>% head(6)
