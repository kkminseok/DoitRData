#mpg 데이터명 바꾸기

library(ggplot2)

mpg_old <- as.data.frame(ggplot2::mpg)
mpg_old

mpg_new <- mpg_old
mpg_new <- rename(mpg_new,city = cty, highway = hwy)
head(mpg_new)

#분석 도전 !

df_midwest <-as.data.frame(ggplot2::midwest)
df_midwest

library(dplyr)

df_newmw <-df_midwest
df_newmw <- rename(df_newmw,total = poptotal, asian = popasian)
head(df_newmw)

df_newmw$per <- df_newmw$asian / df_newmw$total*100
head(df_newmw)
hist(df_newmw$per)

asianavg <- mean(df_newmw$per)
asianavg

df_newmw$size <- ifelse(df_newmw$per>asianavg , "large","small")
table(df_newmw$size)
qplot(df_newmw$size)
