install.packages("ggplot2")

library(ggplot2)
library()
.libPaths()
x <- c("a","a","b","c")
x
qplot(x)

#data�� mpg, x�࿡ hwy ���� ������ �׷��� ����
qplot(data=mpg, x = hwy)

#x�� cty
qplot(data = mpg, x = cty)

#x�� drv, y�� hwy
qplot(data = mpg, x = drv, y =hwy)

#x�� drv, y�� hwy �� �׷��� ����
qplot(data = mpg, x =drv, y =hwy, geom = "line")

#x�� drv, y�� hwy ���� �׸� ������
qplot(data = mpg, x= drv, y = hwy, geom = "boxplot")

#x�� drv, y�� hwy, ���� �׸�����, drv�� �� ǥ��
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv)

# qplot �Լ� �޴��� ���
?qplot
