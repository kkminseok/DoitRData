#빠진 데이터를 찾아라! 결측치(missing value) 정제하기.


df <- data.frame(sex = c("M","F",NA,"M","F"),
                 score = c(5,4,3,4,NA))
df

is.na(df) #결측치 확인

table(is.na(df)) #결측치 빈도 출력

table(is.na(df$sex)) # sec 결측치 빈도 출력
table(is.na(df$score))# score 결측치 빈도 출력

mean(df$score) #결측치 포함 시 NA가 출력된다.
sum(df$score) # ""

#1 결측치 제거하기

library(dplyr) # dplyr 패키지 로드
df %>% filter(is.na(score)) # score가 NA인 데이터만 출력
df %>% filter(!is.na(score)) # score 결측치 제거 출력
df_nomiss <- df %>% filter(!is.na(score)) # 결측치 제거 데이터 넣기
mean(df_nomiss$score) # score 평균 산출

sum(df_nomiss$score)

df_nomiss <- df %>% filter(!is.na(score)& !is.na(sex)) # 결측지 없는 두 조건 넣기
df_nomiss # 출력

df_nomiss2 <- na.omit(df) # 모든 변수에 결측치 없는 데이터 추출
df_nomiss2 # 출력


#2 함수의 결측치 제외 기능 이용하기

mean(df$score, na.rm = T) # 결측치 제외하고 평균 산출출
sum(df$score,na.rm = T)

exam <- read.csv("csv_exam.csv")
exam[c(3,8,15),"math"] <- NA # 3,8,15 행의 math에 NA 할당당
exam
exam %>% summarise(mean_math = mean(math))  #math 평균 산출

#math 결측치 제외하고 평균 산출
exam %>% summarise(mean_math = mean(math, na.rm = T))

exam %>% summarise(mean_math = mean(math,na.rm = T), #평균 산출
                   sum_math = sum(math, na.rm = T), # 합계 산출
                   median_math = median(math,na.rm = T)) # 중앙값 산출

#3 결측치 대체하기

mean(exam$math, na.rm = T) # 결측치 제외하고 math 평균 산출

exam$math <- ifelse(is.na(exam$math),55,exam$math) # math가 NA면 55로 대체
table(is.na(exam$math)) # 결측치 빈도표 생성
exam
mean(exam$math) # mean 평균 산출 정상


