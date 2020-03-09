#04_03 Import outData
install.packages("readxl")
library(readxl)

#엑셀 파일 불러오기
df_exam <- read_excel("excel_exam.xlsx")
df_exam

#평균 분석하기
mean(df_exam$math)
mean(df_exam$english)
mean(df_exam$science)

#첫번째 행이 변수명이 아니면 데이터를 불러올 때 유실되는 문제가 발생한다.

df_exam_novar <- read_excel("excel_exam_novar.xlsx")
df_exam_novar #첫번째 행 유실됨

#해결 방법
#첫번째 행을 변수명이 아닌 데이터로 인식해 불러옴
df_exam_novar <- read_excel("excel_exam_novar.xlsx", col_names = F) #F는 false를 의미 열이름을 가져올 것인가 ? ->false
df_exam_novar

#엑셀 파일에 시트가 여러 개 있다면?

df_exam_sheet <- read_excel("excel_exam_sheet.xlsx",sheet = 3)
df_exam_sheet

#csv파일 불러오기 
#csv는 ,(콤마)로 구분된 파일이고, 엑셀 파일에 비해 용량이 작고 호한성이 좋다.
#첫번째 행이 변수명이 아닐 경우 header = F 를 사용

df_csv_exam <- read.csv("csv_exam.csv")
df_csv_exam

#문자가 들어 있는 파일을 불러올 때는 stringsAsFactors = F 사용

df_csv_exam <- read.csv("csv_exam.csv",stringsAsFactors = F)
df_csv_exam

#데이터 프레임을 csv 파일로 저장하기

#1 데이터 프레임 만들기
df_subject <- data.frame(english = c(90,80,60,70), math = c(50,60,100,20), class = c(1,1,2,2))
df_subject

#저장하기 !데이터 프레임!과 파일을 같이 저장
write.csv(df_subject,file = "df_subject.csv")

#Rdata 활용하기
#Rdata(.rda or .rdata)는 R전용 데이터 파일이라 R에서 읽고 쓸 때 속도가 빠르고 용량이 작다는 장점이 있다.

#1 데이터 프레임을 RData 파일로 저장하기
save(df_subject, file = "df_subject.rda")

#2 Rdata 불러오기

#rm()로 해당 데이터 삭제
rm(df_subject)
df_subject

load("df_subject.rda")

df_subject

#read.csv()나 read.excel()은 파일을 불러와 새 변수에 할당해야 활용이 가능 but load()로 rda는자동으로 만들어져서 변수 #할당 불필요

#엑셀 파일 불러와 df_exam에 할당
df_exam <- read_excel("excel_exam.xlsx")

#csv 파일 불러와 df_csv_exam에 할당
df_csv_exam <- read.csv("csv_exam.csv")

#Rda 파일 불러오기
load("df_subject.rda")
