#Q1 - 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다.
#   - displ(배기량)이 4이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 
#알아보세요.
library(dplyr)
library(ggplot2)

mpg <- as.data.frame(ggplot2::mpg)

lowdispl <- mpg %>% filter(displ<=4)
highdispl <- mpg %>% filter(displ>=5)

mean(lowdispl$hwy)
mean(highdispl$hwy)

#W1 4이하인 자동차가 hwy평균이 더 높다.

#Q2 자동차 제조 회사에 따라 도시 연비가 다른지 알아보기. "audi" 와 "toyota" 중 어느 manufacturer(자동차 제조 회사)
#   의 cty(도시 연비)가 평균적으로 더 높은지 알아보세요.

audi <- mpg %>% filter(manufacturer == "audi")
toyota <- mpg %>% filter(manufacturer == "toyota")

mean(audi$cty)
mean(toyota$cty)

#W2 toyota 회사의 cty가 평균적으로 더 높다.

#Q3 "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 한다. 이 회사들의 데이터를 추출한 뒤, hwy 전체 평균을 구해보기

result <- mpg %>% filter(manufacturer %in% c("chevrolet","ford","honda"))
mean(result$hwy)



#---------- Q4 mpg데이터는 11개의 변수로 구성되어 있습니다. 이 중 일부만 추출해 분석에 활용하려고 합니다
#              mpg 데이터에서 class, cty 변수를 추출해 새로운 데이터를 만드세요. 새로 만든 데이터의 일부를 출력해 두 변수로만 구성되어 있는지 확인하세요.

mpg <- as.data.frame(ggplot2::mpg)
new_mpg <- mpg %>% select(class,cty)
new_mpg

#Q5 자동차 종류에 따라 도시 연비가 다른지 확인해 보려고 한다. 앞에서 추출한 데이터를 이용해 class가 "suv"인 자동차와 "compact"인 자동차 중 어떤 자동차의 cty 평균이 더 높은지 알아보세요.

suv <- mpg %>% filter(class == "suv")
compact <- mpg %>% filter(class == "compact")
mean(suv$cty)
mean(compact$cty)



#데이터 정렬하기 
#Q6 "audi" 에서 생상한 자동차 중에 어떤 자동차 모델의 hwy가 높은지 알아보려고 합니다. "audi"에서 생산한 자동차 중
#   hwy가 1 ~ 5위에 해당하는 자동차의 데이터를 출력하세요.

audi6 <- mpg %>% filter(manufacturer == "audi")
audi6 %>% arrange(desc(hwy)) %>% 
  head(5)

#파생변수 추가하기
#Q7 mpg()데이터 복사본을 만들고, cty와 hwy를 더한 '합산 연비 변수'를 추가하세요.

temp_mpg <- mpg %>% mutate(sumCtyHwy = cty + hwy)
head(temp_mpg,5)
#Q8 앞에서 만든 '합산 연비 변수'를 2로 나눠 '평균 연비 변수'를 추가하세요.
temp_mpg2 <- temp_mpg %>% mutate(meanCtyHwy = sumCtyHwy/2)
head(temp_mpg2,5)

#Q9 평균 연비 변수가 가장 높은 자동차 3종의 데이터를 출력하세요.
temp_mpg2 %>% arrange(desc(meanCtyHwy)) %>% 
  head(5)

#Q10 Q7 ~ Q9를 하나의문장으로 만들어 실행 복사본대신 원본을 이용하세요.
mpg %>% 
  mutate(SumctyHwy = cty + hwy ,
         meanCtyHwy = SumctyHwy/2) %>% 
  arrange(desc(meanCtyHwy)) %>% 
  head(5)


#집단별로 요약하기
#Q11 mpg 데이터의 "suv", "compact", 등 자동차의 특징에 따라 일곱 종류로 분류한 변수입니다. 어떤 차종의 도시 연비가 높은지 비교해 보려고 합니다. class 별 cty 평균을 구해보세요.
mpg %>% 
  group_by(class) %>% 
  summarise(meancty = mean(cty)) %>% 
  head(5)

#Q12 앞 문제의 출력결과는 class 값 알파벳 순으로 정렬되어 있습니다. 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 cty 평균이 높은 순으로 정렬해 출력해보세요.
mpg %>% 
  group_by(class) %>% 
  summarise(meancty = mean(cty)) %>% 
  arrange(desc(meancty)) %>% 
  head(5)

#Q13 어떤 회사의 자동차의 hwy가 가장 높은지 알아보려고 합니다. hwy 평균이 가장 높은 회사 세 곳을 출력하세요.
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(meanhwy = mean(hwy)) %>% 
  arrange(desc(meanhwy)) %>% 
  head(3)

#Q14 어떤 회사에서 "compact" 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.
mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == "compact") %>% 
  summarise(numcar = n()) %>% 
  arrange(desc(numcar))


#데이터 합치기
#Q15 mpg 데이터에는 연료 종류를 나타낸 f1 변수는 있지만 연료 가격을 나타낸 변수는 없습니다. 위에서 만든 fuel 데이터를 이용해 mpg데이터에 price_fl 변수를 추가하세요.

mpg <- as.data.frame(ggplot2::mpg)
fuel <-data.frame(fl = c("c","d","e","p","r"),
                  price_fl = c(2.35,2.38,2.11,2.76,2.22),
                  stringsAsFactors = F)
fuel  

mpg <- left_join(mpg,fuel,by = "fl")
mpg

#Q16 연료 가격 변수가 잘 추가됐는지 확인하기 위해 model, fl, price_fl 변수를 추출해 앞부분 5행을 출력
mpg %>% select(model,fl,price_fl) %>% 
  head(5)


#분석 도전!
df_midwest <- as.data.frame(ggplot2::midwest)

df_midwest <- df_midwest %>% 
  mutate(ratio_blue = ((poptotal-popadults)/poptotal*100))
head(df_midwest,5)

df_midwest %>% 
  arrange(desc(ratio_blue)) %>% 
  select(county,ratio_blue) %>% 
  head((5))

df_midwest <- df_midwest %>% 
  mutate(grade = ifelse(ratio_blue>=40 , "large",ifelse(ratio_blue>=30, "middle","small")))
table(df_midwest$grade)

df_midwest2 <- as.data.frame(ggplot2::midwest)

df_midwest2 %>% 
  mutate(ratio_asian = popasian/poptotal *100) %>% 
  arrange(ratio_asian) %>% 
  select(state,county,ratio_asian) %>% 
  head(10)

