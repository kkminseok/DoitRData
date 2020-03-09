exam <- read.csv("D:/Code/DoitR/04_DataFrame/csv_exam.csv")

#exam 데이터 파악하기

exam
#1 head() - 데이터 앞 부분 파악하기
head(exam) # 앞에서 6행까지 출력
head(exam,10)# 앞에서 10행까지 출력

#2 tail() - 데이터 뒷 부분 파악하기
tail(exam) # 뒤에서 6행까지 출력
tail(exam,10) # 뒤에서 10행까지 출력

#3 View() - 뷰어 창에서 데이터 확인하기

View(exam) # 데이터 뷰어 창에서 exam 데이터 확인

#4 dim() - 데이터가 몇 행,몇 열로 구성되어 있는지 알아보기
dim(exam)

#5 str() - 속성 파악하기
str(exam)

#6 summary() - 요약 통계량 산출하기
summary(exam)



##mpg 데이터 파악하기

library(ggplot2)
# ggplot2의 mpg데이터를 데이터 프레임 형태로 불러오기
mpg <- as.data.frame(ggplot2::mpg)

# head, tail, View, dim, str, summary 이용
head(mpg)
tail(mpg)
View(mpg)
dim(mpg)
str(mpg)
summary(mpg)
?mpg

