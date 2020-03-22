#미국 주별 강력 범죄율 단계 구분도 만들기
install.packages("ggiraphExtra")
install.packages("maps")
install.packages("mapproj")
library(ggiraphExtra)
library(tibble)
library(ggplot2)
#미국 주별 범죄 데이터 준비하기

str(USArrests)
head(USArrests)

crime <- rownames_to_column(USArrests, var = "state")
crime$state <- tolower(crime$state)

str(crime)

#미국 주 지도 데이터 준비하기
states_map <- map_data("state") #package maps R에 내장되어 있지 않다.
str(states_map)

#단계 구분도 만들기
ggChoropleth(data = crime, # 지도에 표시할 데이터
             aes(fill = Murder, # 색깔로 표현할 변수
                 map_id = state), # 지역 기준 변수
             map = states_map)   # 지도 데이터

#인터랙티브 단계 구분도 만들기
ggChoropleth(data = crime,    # 지도에 표현할 데이터 
             aes(fill = Murder,   # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map,    # 지도 데이터
             interactive = T)    #인터랙티브

