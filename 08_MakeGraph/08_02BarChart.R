#막대 그래프 - 집단 간 차이 표현하기

#1. 집단별 평균표 만들기
library(dplyr)

df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))

df_mpg

#2. 그래프 만들기

ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

#3. 크기 순으로 정렬하기
ggplot(data = df_mpg , aes(x = reorder(drv,-mean_hwy),y = mean_hwy)) + geom_col()


# 빈도 막대 그래프 만들기
ggplot(data = mpg, aes(x = drv)) + geom_bar()

ggplot(data = mpg, aes(x = hwy)) + geom_bar()
