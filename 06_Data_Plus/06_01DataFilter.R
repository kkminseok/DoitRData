library(dplyr)
exam <- read.csv("csv_exam.csv")
exam


#filter() 함수 사용  dplyr라이브러리에 있다.
#exam에서 class가 1인 행만 출력

# %>% 은 파이프연산자(pipe operator)
exam %>% filter(class==1)

#2반인 경우만 출력
exam %>% filter(class==2)

#1반이 아닌경우
exam %>% filter(class!=1)

#3반이 아닌경우
exam %>% filter(class!=3)

#초과, 미만, 이상, 이하 조건 걸기
exam %>% filter(math>50)
exam %>% filter(math<50)
exam %>% filter(english>80)
exam %>% filter(english<=80)

#여러 조건을 만족하는 행 추출

#&(and)연산 c++에서는 &&인데..
exam %>% filter(class==1& math>=50)

exam %>% filter(class==2&english>=80)

#or
exam %>% filter(math>=90 | english>=90)

exam %>% filter(english<90 | science <50)

#여러조건 나열
exam %>% filter(class==1 | class==3 | class==5)

#매치 연산자(Matching Operator) %in% c()함수와 같이 목록을 나열하면 된다.
exam %>% filter(class %in% c(1,3,5))

#추출한 행으로 데이터 만들기

class1 <- exam %>% filter(class==1)
class2 <- exam %>% filter(class==2)

mean(class1$math)
mean(class2$math)
