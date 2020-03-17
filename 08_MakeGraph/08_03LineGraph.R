#선 그래프 - 시간에 따라 달라지는 데이터 표현하기

#시계열 그래프 만들기
ggplot(data = economics , aes(x = date, y =unemploy)) + geom_line()

