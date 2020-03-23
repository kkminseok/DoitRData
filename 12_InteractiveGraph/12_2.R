#12_2dygraphs 패키지로 인터랙티브 시계열 그래프 만들기

#인터랙티브 시계열 그래프 만들기
install.packages("dygraphs")
library(dygraphs)

economics <- ggplot2::economics
head(economics)
library(xts)
eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)

#인터랙티브 시계열 그래프 만들기
dygraph(eco)

#날짜 범위 선택 기능
dygraph(eco) %>% dyRangeSelector()

#여러 값 표현하기

#저축률
eco_a <- xts(economics$psavert, order.by = economics$date)

#실업자 수
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)

eco2 <- cbind(eco_a,eco_b)
colnames(eco2) <- c("psavert","unemploy")
head(eco2)

dygraph(eco2) %>% dyRangeSelector()
