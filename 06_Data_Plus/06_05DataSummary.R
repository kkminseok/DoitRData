#데이터 요약하기

#새 변수에 할당한다는데 객체 생성은 안되는데..?
exam %>% summarise(mean_math = mean(math))

#집단별로 요약하기

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))
#int dbl(double)

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n=n())# 학생 수  데이터가 몇행으로 이루어져있는 지 '빈도'를 구하는 기능

#이중 집단 나누기
mpg %>% 
  group_by(manufacturer,drv) %>%      #회사별, 구동 방식별 분리
  summarise(mean_cty = mean(cty)) %>% # cty 평균 산출
  head(10)

#회사별로 "suv" 자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로 정렬하고, 1~5위까지 출력하기
library(ggplot2)
mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == "suv") %>% 
  mutate(tot = (cty + hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)
  