#07_01Data_Refine1.R 혼자서 해결해보기

mpg <-as.data.frame(ggplot2::mpg)
mpg[c(65,124,131,153,212),"hwy"] <- NA # NA할당하기
is.na(mpg$hwy)

#Q1 drv별로 hwy 평균이 어떻게 다른지 알아보려고 합니다. 분석을 하기전에 우선 두 변수에 결측치가 있는지 확인해야합니다.
#   drv변수와 hwy 변수에 결측치가 몇 개 있는지 알아보세요.

table(is.na(mpg$drv))
table(is.na(mpg$hwy))

#Q2 filter()를 이용해 hwy 변수의 결측치를 제외하고, 어떤 구동 방식의 hwy 평균이 높은지 알아보세요. 하나의 dplyr구문으로작성
mpg %>% filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(hwymean = mean(hwy)) %>% 
  head(5)

#07_02Data_Refine2.R 혼자서 해보기
#이상치 넣기
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10,14,58,93),"drv"] <- "k"  # 이상치 k
mpg[c(29,43,129,203),"cty"] <- c(3,4,39,42) # 극단치

#Q3 drv에 이상치가 있는지 확인하세요. 이상치를 결측 처리한 후 이상치가 사라졌는지 확인하세요. 결측 처리를 할 때는 %in% 기호를 활용하세요.

table(mpg$drv) # k가 4개 들어있음
mpg$drv <- ifelse(mpg$drv %in% c("4","f","r"),mpg$drv,NA) #결측치로 만듬
table(mpg$drv)

#Q4 상자 그림을 이용해 cty에 이상치가 있는지 확인하세요. 상자 그림의 통계치를 이용해 정상 범위를 벗어난 값을 결측 처리한 후 다시 상자 그림을 만들어 이상치가 사라졌는지 확인하세요.

boxplot(mpg$cty)
boxplot(mpg$cty)$stats
mpg$cty <- ifelse( mpg$cty <9 | mpg$cty >26 , NA, mpg$cty)
boxplot(mpg$cty)


#Q5 두 변수의 이상치를 결측 처리 했으니 이제 분석할 차례입니다. 이상치를 제외한 다음 drv별로 cty 평균이 어떻게 다른지 알아보세요. 하나의 dplyr 구문으로 만들어야 합니다.

mpg %>% 
  filter(!is.na(drv) & !is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head(5)

  