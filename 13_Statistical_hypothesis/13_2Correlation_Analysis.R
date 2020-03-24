#13_2 상관분석 - 두 변수의 관계성 분석
#두 연속 변수가 서로 관련이 있는지 검정하는 통계 분석기법

economics <- as.data.frame(ggplot2::economics)
cor.test(economics$unemploy,economics$pce)

# p - value가 0.05 미만이므로 통계적으로 유의하다 해석이 가능하다.
# 마지막 cor은 상관계수를 의미  cor이 0.61이고 양수이므로 정비례 관계라는 뜻

#상관행렬 히트맵 만들기

head(mtcars)

car_cor <- cor(mtcars)
round(car_cor,2)

#알아보기 힘드므로 히트맵을 만든다.
install.packages("corrplot")
library(corrplot)

corrplot(car_cor)

#숫자로 표현
corrplot(car_cor, method = "number" )

#다양한 파라미터 지정
col <- colorRampPalette(c("#BB4444","#EE9988","#FFFFFF","#77AADD","#4477AA"))

corrplot(car_cor,
         method = "color",           # 색깔로 표현
         col = col(200),             # 색상 200개 선정
         type = "lower",             # 왼쪽 아래 행렬만 표시
         order = "hclust",           # 유사한 상관계수끼리 군집화
         addCoef.col = "black",      # 상관계수 색깔
         tl.col = "black",           # 변수명 색깔
         tl.srt = 45,                # 변수명 45도 기울임
         diag = F)                   # 대각 행렬 제외
