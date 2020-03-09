library(ggplot2)
#변수 조합해 파생변수 만들기

df <- data.frame(var1 = c(4,3,8),
                 var2 = c(2,6,1))
df

df$var_sum <- df$var1 + df$var2 # 파생변수 만들기
df

df$var_mean <- (df$var1 + df$var2)/2
df

#mpg 통합 연비 변수 만들기

mpg$total <- (mpg$cty + mpg$hwy)/2
head(mpg)
mean(mpg$total)


#조건문을 이용하여 파생변수 만들기
#1 기준값 정하기
summary(mpg$total)
hist(mpg$total)

#2 합격판정 변수 만들기
mpg$test <- ifelse(mpg$total >= 20, "pass","fail")
head(mpg,20)

#3 빈도표로 합격 판정 자동차 수 살펴보기
table(mpg$test)

#4 막대그래프로 빈도 표현하기
qplot(mpg$test)



##중첩 조건문 활용하기
mpg$grade <- ifelse(mpg$total >= 30, "A", ifelse(mpg$total >=20,"B","C"))
head(mpg,20)
                    

#_2빈도표, 막대 그래프로 연비 등급 살펴보기
table(mpg$grade)
qplot(mpg$grade)

mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >=25,"B",
                            ifelse(mpg$total>=20,"C","D")))
table(mpg$grade2)
qplot(mpg$grade2)
