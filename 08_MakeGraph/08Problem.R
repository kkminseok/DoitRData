#08_02 혼자서 해보기

#Q1 mpg 데이터의 cty 와 hwy 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 cty, y축은 hwy로 된 산점도를 만들어 보세요.
library(ggplot2)
ggplot(data = mpg, aes(x = cty,y = hwy)) + geom_point()

#Q2 미국 지역별 인구통계를 담은 ggplot2 패키지의 midwest 데이터를 이용해 전체 인구와 아시아인 인구 간에 어떤 관계가있는지알아보려 합니다. x축은 poptotal, y축은 popasian으로 된 산점도를 만들어 보세요. 전체 인구는 50만명 이하, 아시아인 인구는 1만명 이하인 지역만 산점도에 표시되게 설정하세요.

ggplot(data = midwest, aes(x = poptotal, y = popasian)) + geom_point() + xlim(0,500000) + ylim(0,10000)


#08_03 혼자서 해보기

#Q3 어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 알아보려고 합니다. "suv" 차종을 대상으로 평균 cty가 가장 높은
#   회사 다섯 곳을 막대 그래프로 표현해 보세요. 막대는 연비가 높은 순으로 정렬하세요.
df_Problem <- mpg %>% 
  filter(class == "suv") %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)

df_Problem
ggplot(data = df_Problem, aes(x = reorder(manufacturer, -mean_cty),y = mean_cty)) + geom_col()

#Q4 자동차 중에서 어떤 class가 가장 많은지 알아보려고 합니다. 자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.

ggplot(data = mpg, aes(x = class)) + geom_bar()

#08_4 혼자서 해보기

#Q5 psavert가 시간에 따라 어떻게 변해 왔는지 알아보려고 합니다. 시계열 그래프를 만들어보세요.
ggplot(data = economics, aes(x = date, y= psavert)) + geom_line()

#08_5 혼자서 해보기

#Q6 class가 "compact","subcompact","suv"인 자동차의 cty가 어떻게 다른지 비교해 보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만들어 보세요.

mpg_new <- mpg %>% 
  filter(class %in% c("compact","subcompact","suv"))
mpg_new

ggplot(data = mpg_new, aes(x = class, y = cty)) + geom_boxplot()
