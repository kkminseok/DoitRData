#13_1 t 검점 - 두 집단의 평균 비교

mpg <- as.data.frame(ggplot2::mpg)
library(dplyr)
mpg_diff <- mpg %>% 
  select(class,cty) %>% 
  filter(class %in% c("compact","suv"))

head(mpg_diff)

table(mpg_diff$class)

t.test(data = mpg_diff, cty ~ class, var.equal = T) # 집단의 분산이 같은지 여부에 따라 적용하는 공식이 다르다. 같다고 가정하고 var.equal = T를 지정

#compact와 suv의 cty의 통계적 차이는 우연하지 않다.

#일반 휘발유와 고급 휘발유의 도시 연비 t 검정
mpg_diff2 <- mpg %>% 
  select(fl,cty) %>% 
  filter(fl %in% c("r","p")) # r: requlare, p: premium

table(mpg_diff2$fl)

t.test(data = mpg_diff2, cty ~ fl, var.equal = T)

#일반 휘발유와 고급 휘발유의 통계적 차이는 우연하다.