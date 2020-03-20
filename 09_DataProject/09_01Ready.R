#09_1한국복지패널데이터 분석 준비하기
install.packages("foreign")
install.packages("readxl")

library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

#데이터 불러오기
raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav",to.data.frame = T)

#복사본 만들기
welfare <- raw_welfare

#데이터 검토하기
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

#분석하기 쉽게 이름 바꾸기
welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_region = h10_reg7)

#09_02  성별에 따른 월급 차이 - "성별에 따라 월급이 다를까?"

#성별 변수 검토 및 전처리
class(welfare$sex)
table(welfare$sex)

#1 과 2를 제외한 값은 이상치다.
#이상치 처리
welfare$sex <- ifelse(welfare$sex ==9,NA,welfare$sex)

#결측치 확인
table(is.na(welfare$sex))

#1 과 2를 문자로 바꾸기
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)

#월급 면수 전처리 및 검토
class(welfare$income)
summary(welfare$income)
qplot(welfare$income) + xlim(0,1000)

#결측치가 12030개 존재
#이상치 결측 처리
welfare$income <- ifelse(welfare$income %in% c(0,9999),NA,welfare$income)

#결측치 확인
table(is.na(welfare$income))

#성별에 따른 월급 차이 분석하기
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))
sex_income

#그래프 만들기
ggplot(data = sex_income, aes(x = sex , y = mean_income)) + geom_col()


#09_03 나이와 월급의 관계 - "몇살 때 월급을 가장 많이 받을까?"

#나이 변수 검토 및 전처리
class(welfare$birth)
summary(welfare$birth)

#결측치 확인 나이는 1900~2014 값만 가지고 있다.
table(is.na(welfare$birth))

#이상치 결측 처리
welfare$birth <- ifelse(welfare$birth == 9999,NA,welfare$birth)
table(is.na(welfare$birth))

#파생변수 만들기 - 나이
welfare$age <- 2015 - welfare$birth +1
summary(welfare$age)
qplot(welfare$age)

#나이에 따른 월급 평균표 만들기
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))

head(age_income)

#그래프 만들기
ggplot(data = age_income, aes( x = age, y = mean_income)) + geom_line()


#09_04 연령대에 따른 월급 차이 - "어떤 연령대의 월급이 가장 많을까?"

#연령대 변수 검토 및 전처기하기
welfare <- welfare %>% 
  mutate(ageg = ifelse(age<30, "young", 
                       ifelse(age <=59,"middle","old")))
table(welfare$ageg)
qplot(welfare$ageg)

#연령대에 따른 월급 차이 분석하기

ageg_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))

ageg_income

ggplot(data = ageg_income, aes(x = ageg,y = mean_income)) + geom_col()

#나이순 정렬
ggplot(data = ageg_income, aes(x = ageg,y = mean_income)) + geom_col() + scale_x_discrete(limits = c("young","middle","old"))


#09_05 연령대 및 성별 월급 차이 - "성별 월급 차이는 연령대별로 다를까?"

#연령대 및 성별 월급 차이 분석하기
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg,sex) %>% 
  summarise(mean_income = mean(income))

sex_income

#그래프 만들기
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) + geom_col() +
  scale_x_discrete(limits = c("young","middle","old"))

#그래프 분리하기
ggplot(data = sex_income, aes(x = ageg, y = mean_income , fill = sex)) + geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young","middle","old"))

#나이 및 성별 월급 차이 분석하기
sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age,sex) %>% 
  summarise(mean_income = mean(income))

head(sex_age)

ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) + geom_line()


#09_06 직업별 월급 차이 - "어떤 직업이 월급을 가장 많이 받을까?"

#직업 변수 검토 및 전처리하기

class(welfare$code_job)
table(welfare$code_job)

#전처리
list_job <- read_excel("Koweps_Codebook.xlsx", col_names = T, sheet = 2)
head(list_job)

dim(list_job)

welfare <- left_join(welfare, list_job, id = "code_job")

welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job,job) %>% 
  head(10)

#직업별 월급 차이 분석하기

job_income <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

head(job_income)

top10 <- job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)
top10

ggplot(data = top10, aes(x = reorder(job,mean_income), y = mean_income)) +
  geom_col() +
  coord_flip() #막대 그래프 90도 회전.


#09_07 성별 직업 빈도 - "성별로 어떤 직업이 가장 많을까?"

#성별 직업 빈도 분석하기

#성별 직업 빈도표 만들기

job_male <- welfare %>% 
  filter(!is.na(job) & sex == "male") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)

job_male

#여성 직업 빈도 상위 10개 추출
job_female <- welfare %>% 
  filter(!is.na(job) & sex == "female") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)

job_female

#남성 직업 빈도 그래프
ggplot(data = job_male, aes(x = reorder(job,n), y = n)) + 
  geom_col() +
  coord_flip()

#여성 직업 빈도 그래프
ggplot(data = job_female, aes(x = reorder(job,n),y =n)) +
  geom_col() +
  coord_flip()

#09_08 종교 유무에 따른 이혼율  - " 종교가 있는 사람들이 이혼을 덜 할까? "

#종교 변수 검토 및 전처리하기
class(welfare$religion)
table(welfare$religion) # 1은 있음 2 없음 9 모름/무응답
welfare$religion <- ifelse(welfare$religion == 1 ,"yes","no")
table(welfare$religion)

qplot(welfare$religion)

#혼인 상태 변수 검토 및 전처리하기
class(welfare$marriage)
table(welfare$marriage) # 0 비해당 1 유배우 2 사별 3 이혼 4 별거 5 미혼 6 기타

welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage",
                           ifelse(welfare$marriage == 3,"divorce",NA))
table(welfare$group_marriage)

table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)

#종교 유무에 따른 이혼율 분석하기
religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,1))

religion_marriage

#이혼 추출
divorce <- religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(religion,pct)

divorce

ggplot(data = divorce, aes(x = religion, y =pct)) + geom_col()

#연령대 및 종교 우무에 따른 이혼율 분석하기

ageg_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(ageg,group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,1))

ageg_marriage

ageg_divorce <- ageg_marriage %>% 
  filter(ageg != "young" & group_marriage =="divorce") %>% 
  select(ageg,pct)

ageg_divorce

ggplot(data = ageg_divorce, aes(x = ageg, y = pct)) + geom_col()

#연령대 및 종교 우무에 따른 이혼율 표 만들기
ageg_religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage) & ageg != "young") %>% 
  group_by(ageg,religion,group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,1))

ageg_religion_marriage

df_divorce <- ageg_religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(ageg,religion,pct)

df_divorce

ggplot(data = df_divorce, aes(x = ageg, y = pct,fill = religion)) + geom_col(position = "dodge")


#09_09 지역별 연령대 비율 - "노년층이 많은 지역은 어디일까?"

#변수 검토하기
class(welfare$code_region)
table(welfare$code_region) # 1 서울 2 수도권 3 부산 4 대구 5 대전 6 강원 7 광주

#지역 코드 목록 만들기
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권",
                                     "부산",
                                     "대구",
                                     "대전",
                                     "강원",
                                     "광주"))
list_region

welfare <- left_join(welfare, list_region, id = "code_region")

welfare %>% 
  select(code_region,region) %>% 
  head

#지역별 연령대 비율 분석하기

region_ageg <- welfare %>% 
  group_by(region,ageg) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,2))
head(region_ageg)

ggplot(data = region_ageg, aes(x = region, y =pct, fill =ageg)) +
  geom_col() +
  coord_flip()

#노년층 비율이 높은 순으로 막대 정렬하기

list_order_old <- region_ageg %>% 
  filter(ageg =="old") %>% 
  arrange(pct)

list_order_old

order <-list_order_old$region
order

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)

#연령대 순으로 막대색깔 나열하기

class(region_ageg$ageg)

levels(region_ageg$ageg)

region_ageg$ageg <- factor(region_ageg$ageg,
                           level =c("old","millde","young"))
class(region_ageg$ageg)

levels(region_ageg$ageg)

ggplot(data = region_ageg, aes(x = region , y = pct, fill = ageg )) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)

