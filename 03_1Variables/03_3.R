install.packages("ggplot2")

library(ggplot2)
library()
.libPaths()
x <- c("a","a","b","c")
x
qplot(x)

#data에 mpg, x축에 hwy 변수 지정해 그래프 생성
qplot(data=mpg, x = hwy)

#x축 cty
qplot(data = mpg, x = cty)

#x축 drv, y축 hwy
qplot(data = mpg, x = drv, y =hwy)

#x축 drv, y축 hwy 선 그래프 형태
qplot(data = mpg, x =drv, y =hwy, geom = "line")

#x축 drv, y축 hwy 상자 그림 형태태
qplot(data = mpg, x= drv, y = hwy, geom = "boxplot")

#x축 drv, y축 hwy, 상자 그림형태, drv별 색 표현
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv)

# qplot 함수 메뉴얼 출력
?qplot

