#04_02 데이터 프레임 만들기

#english 변수 생성
english <- c(90, 80, 60, 70)
english

#math 변수 생성
math <- c(50,60,100,20)
math

#Data Frame 만들기
#df_midterm에 english, math 데이터 프레임 생성해서 할당
df_midterm <-data.frame(english,math)
df_midterm

#Append Data Frame
class <- c(1,1,2,2)
class

df_midterm <-data.frame(english,math,class)
df_midterm

#분석하기

#df_midterm의 english로 평균 산출
mean(df_midterm$english)
#df_midterm의 math로 평균 산출
mean(df_midterm$math)

#데이터 프레임 한 번에 만들기

df_midterm2 <- data.frame(english = c(90,80,60,70), math = c(50,60,100,20), class = c(1,1,2,2))
df_midterm2


