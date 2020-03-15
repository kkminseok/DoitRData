#이상한 데이터를 찾아라 1 - 이상치 정제하기
# 정상 범주에서 크게 벗어난 값을 '이상치' 라고 한다.

#1 이상치 제거하기 - 존재할 수 없는 값
# 밑에서 sex가 3은 이상치, score가 6은 이상치라고 가정
outlier <- data.frame(sex = c(1,2,1,3,2,1),
                      score = c(5,4,3,4,2,6))
outlier

table(outlier$sex)
table(outlier$score)

#sex가 3이면 NA할당
outlier$sex <-ifelse(outlier$sex == 3, NA, outlier$sex)
outlier

#score가 5초과면 NA할당
outlier$score <- ifelse(outlier$score >5, NA, outlier$score)
outlier

#결측치를 제외한 후 성별에 따른 score평균을 구하기
outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))


#2 이상치 제거하기 - 극단적인 값

library(ggplot2)
boxplot(mpg$hwy)$stats  # 상자 그림 통계치 출력

# 12 ~ 37 벗어나면 NA 할당
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy,na.rm = T))
      