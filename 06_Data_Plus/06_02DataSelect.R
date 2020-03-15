#필요한 변수만 추출

library(ggplot2)
library(dplyr)

exam %>% select(math)
exam %>% select(english)
exam %>% select(class,math,english)

#변수 제외
exam %>% select(-math)
exam %>% select(-math,-english)

#filter() 와 select() 조합하기
# class가 1인 행만 추출한 다음 english 추출
exam %>% filter(class == 1) %>% select(english)

# 들여쓰는 문법
exam %>% select(id,math) %>%
  head
exam %>% 
  select(id,math) %>% 
  head(10)

