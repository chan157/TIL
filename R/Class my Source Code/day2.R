library(readxl)
library(dplyr)
library(ggplot2)
df <- read_excel('r/Data/excel_exam.xlsx')
exam

exam %>% group_by(class) %>% summarise(mm=mean(math),
                          md=median(math),
                          cnt=n())

mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mc=mean(cty)) %>% 
  head(10)

mpg

# 제조사별로 그룹화한 후 class가 suv인 항목으로 필터
# total = cty와 hwy의 평균으로 새로운 열을 생성
mpg %>%
  group_by(manufacturer) %>% 
  filter(class=='suv') %>% 
  mutate(tot=(cty + hwy)/2) %>% 
  summarise(mt=mean(tot)) %>% 
  arrange(desc(mt)) %>% 
  head(5)

# 같은 id열을 기준으로 데이터를 합치기
test1 <- data.frame(id=c(1,2,3,4,5),
                    midterm = c(60,80,70,90,55))
test2 <- data.frame(id=c(1,2,3,4,5),
                    final = c(70,80,40,80,75))

total <- left_join(test1, test2, by='id')
total


# 기존의 데이터에서 기준에 맞게 원하는 데이터를 넣고 싶은 경우
# name이 들어있는 데이터프레임 생성
name <- data.frame(class=c(1,2,3,4,5),
                   teacher=c('kim','lee','bak','choi','jo'))
name

# 왼쪽 데이터로 합치기
# exam과 name을 class를 기준으로 합친다.
exam_new = left_join(exam, name, by='class')
exam_new
  
# 행 단위로 인덱스가 늘어나 
# 행 방향으로 합치고 싶은 경우
test1 <- data.frame(id=c(1,2,3,4,5),
                    midterm = c(60,80,70,90,55))
test2 <- data.frame(id=c(6,7,8,9,10),
                    midterm = c(70,80,40,80,75))
bind_rows(test1, test2)


# 원하는 조건으로 필터링 하기
exam %>% filter(english >= 80 & class==1)
# %in% : in연산자 
# 특정 조건에 속하는지 확인할 수 있다.
# class가 1,3,5 중에 해댕되는 것
exam %>% filter(class %in% c(1,3,5))

# 원하는 행만 선택해서 가져오기
exam %>% 
  select(id,math)

# test 열 추가
# english 점수를 80점 기준으로 pass/fail
exam %>% mutate(test=ifelse(english >= 80, 'pass', 'fail')) %>% 
  arrange(test) # 특정 컬럼 기준으로 정렬하기

# left_join으로 합치면 왼쪽 기준으로 합쳐진다.
# index가 되는 번호가 없으므로 test2의 점수가 다 사라짐
test1 <- data.frame(id=c(1,2,3,4,5),
                    midterm = c(60,80,70,90,55))
test2 <- data.frame(id=c(6,7,8,9,10),
                    final = c(70,80,40,80,75))
left_join(test1,test2)


# left_join으로 합치면 왼쪽 기준으로 합쳐진다.
# by='id' id 기준으로 합쳐진다.
test1 <- data.frame(id=c(1,2,3,4,5),
                    midterm = c(60,80,70,90,55))
test2 <- data.frame(id=c(1,2,3,4,5),
                    final = c(70,80,40,80,75))
left_join(test1,test2, by='id')


# 결측치 관련
df <- data.frame(sex=c('M','F',NA,'M','F'),
             score=c(5,4,3,5,NA))
df 
# 결측값인지 확인하기
is.na(df)
# table 함수 : 빈도 조사
table(is.na(df))
# => 전체 데이터 프레임에서 격측치의 숫자를 알 수 있다.

# 특정 열을 기준으로 결측치 빈도수 확인
table(is.na(df$sex))
# 결측치 떄문에 평균값이 구해지지 않는다.
mean(df$score)

# score가 na가 아닌 값들만 출
df %>% filter(!is.na(score))
df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)

# score, sex 열에서 na가 아닌 데이터만 추출
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex)) 
df_nomiss
# omit 이라는 함수를 사용하면 더 쉽게 결측치를 제거할 수 있다.
df_nomiss2 <- na.omit(df)
df_nomiss2

# rm : remove
# na 값을 제거하고 평균을 구할 수 있도록 옵션을 줄 수 있다.
mean(df$score, na.rm = T)
sum(df$score, na.rm = T)


exam <- read.csv('r/Data/csv_exam.csv')
exam
exam[c(3,8,15),'math'] <- NA
exam
exam %>%  summarise(mm=mean(math, na.rm = T),
                    sm=sum(math, na.rm = T),
                    med=median(math, na.rm = T))
# math 열 값이 na 이면 55 대입, 아니면 해당 값 그대로
exam$math <- ifelse(is.na(exam$math),55,exam$math)
exam$math
table(is.na(exam$math))
mean(exam$math)


# sex col에 1이나 2로 나와야 하는데 3이 들어있는 경우
# score 에서 5점 만점인 경우 그 이상의 값은 이상치
# outlier를 제거하기
df <- data.frame(sex=c(1,2,1,3,2,1),
                 score=c(5,4,3,5,6,3))
table(df$sex)
table(df$score)

df$sex <- ifelse(df$sex==3, NA, df$sex)
df$score <- ifelse(df$score>5, NA, df$score)
df # 이상치는 NA로 바뀐 상태

df %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(ms=mean(score))


# boxplot 그리기
boxplot(mpg$hwy)
# boxplot의 특징 값들을 구할 수 있다.
boxplot(mpg$hwy)$stats

mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA,mpg$hwy)
table(is.na(mpg$hwy))

# drv를 기준으로 그룹화
# mean_hwy <- hwy의 평균, 결측값은 제외
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy=mean(hwy,na.rm=T))


table(is.na(df$score))


#시각화
# + 기호를 기준으로 왼쪽은 배경을 설정하고
# + 기호를 기준으로 오른쪽은 데이터를 설정한다.
ggplot(data = mpg, aes(x=displ,y=hwy))+
  geom_point()+
  xlim(1,7)+
  ylim(10,35)


df_mpg <- mpg %>% 
        group_by(drv) %>% 
        summarise(mean_hwy=mean(hwy))
df_mpg

ggplot(data=df_mpg, aes(x=drv, y=mean_hwy))+
  geom_col()

economics
ggplot(data=economics, aes(x=date, y=unemploy))+
  geom_line()
  
install.packages('foreign')
library(foreign) # SPSS 파일로드
library(dplyr) # 데이터 전처리
library(ggplot2) # 데이터 시각화
library(readxl) # 엑셀파일 입출력
# 한국복지패널에서 발행한 데이터
# Koweps_hpc10_2015 2015년에 7000여 가족을 추적

#데이터프레임으로 변경해서 읽어올 수 있는 옵션
raw_welfare <- read.spss(file="r/Data/Koweps_hpc10_2015_beta1.sav", to.data.frame=T)
welfare <- raw_welfare
welfare

str(welfare)
View(welfare)
dim(welfare)
summary(welfare)

# 열 이름이 너무 어렵기 때문에 일부 다룰 데이터만
# 선택적으로 열 이름을 바꿔서 보도록 하겠다.
welfare <- rename(welfare, 
       sex = h10_g3,
       birth = h10_g4,
       marriage = h10_g10,
       religion = h10_g11,
       code_job = h10_eco9,
       income = p1002_8aq1,
       code_region = h10_reg7)
str(welfare)
class(welfare$sex)
table(welfare$sex)
# 이상치 결측값 처리
# 무응답 또는 모름인 경우 NA처리하기
welfare$sex = ifelse(welfare$sex==9,NA,welfare$sex)
table(is.na(welfare$sex))
str(welfare)
View(welfare)


welfare$sex <- ifelse(welfare$sex==1,'male',ifelse(welfare$sex==2,'female',welfare$sex))
welfare$sex

class(welfare$income)
summary(welfare$income)
# median과 mean 값의 차이가 많이난다.
# 소득이 매우 높은 사람의 영향
qplot(welfare$income)+xlim(0,1000)
# 그래프를 보면 대부분이 1만 이하인 것을 확인할 수 있음


# 9999 => NA
ifelse(welfare$income %in% c(0, 9999),NA,welfare$income)


sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mi=mean(income))

ggplot(data=sex_income, aes(x=sex,y=mi))+ geom_col()

summary(welfare$birth)
table(is.na(welfare$birth))


# 9999 => NA
ifelse(welfare$birth %in% c(9999),NA,welfare$birth)
table(is.na(welfare$birth))
welfare$age <- 2015-welfare$birth +1
summary(welfare$age)
qplot(welfare$age)


age_income = welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mi=mean(income))

ggplot(data=age_income,
       aes(x=age,y=mi))+
  geom_line()


welfare <- welfare %>% 
  mutate(ageg=ifelse(welfare$age < 30, 'young', ifelse(welfare$age <= 59, 'mid', 'old')))
welfare$ageg         
table(welfare$ageg)
qplot(welfare$ageg)

ageg_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mi=mean(income))
age_income


ggplot(data=ageg_income, aes(x=ageg,y=mi))+
  geom_col()
# 축을 정렬하고 싶은 경우 
ggplot(data=ageg_income, aes(x=ageg,y=mi))+
  geom_col()+
  scale_x_discrete(limits=c('young','mid','old'))


sex_income <-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg,sex) %>% 
  summarise(mi=mean(income))
sex_income

ggplot(data=sex_income, aes(x=ageg, y=mi, fill=sex))+
  geom_col()+
  scale_x_discrete(limits=c('young','mid','old'))

ggplot(data=sex_income, aes(x=ageg, y=mi, fill=sex))+
  geom_col(position = 'dodge')+
  scale_x_discrete(limits=c('young','mid','old'))

# 성별 연령별 월급에 대한 평균
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age,sex) %>% 
  summarise(mi=mean(income))
age_income

ggplot(data=age_income, aes(x=age, y=mi, fill=sex))+
  geom_col()

ggplot(data=age_income, aes(x=age, y=mi, col=sex))+
  geom_line()


welfare$code_job
# 직업 코드별 인원수 확인
table(welfare$code_job)


list_job <- read_excel('r/Data/Koweps_Codebook.xlsx',sheet = 2)
list_job
str(welfare)
welfare$code_job

welfare <- left_join(welfare,list_job,id="code_job")
str(welfare)

