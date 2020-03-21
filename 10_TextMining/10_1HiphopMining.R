#자바 설치가 선행 되어야 한다.
install.packages("rJava")
install.packages("memoise")
library()
install.packages("multilinguer")
library(multilinguer)
install_jdk()
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages(c("fansi", "vctrs"))

library(KoNLP)
library(dplyr)

#사전 설정하기
useNIADic()

#데이터 준비하기
txt <- readLines("hiphop.txt")
head(txt)


#특수문자 제거하기

install.packages("stringr")
library(stringr)

txt <- str_replace_all(txt,"\\W"," ")

#가장 많이 사용딘 단어 알아보기

#1. 명사 추출하기
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다다")

#가사에서 명사 추출
nouns <- extractNoun(txt)

#2. 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))

#데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word
#변수명 수정
df_word <- rename(df_word, word = Var1, freq = Freq)

#3. 자주 사용된 단어 빈도표 만들기

#두 글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >= 2)

top_20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

top_20

#워드 클라우드 만들기

#1. 패키지 준비하기
install.packages("wordcloud")

#패키지 로드
library(wordcloud)
library(RColorBrewer)

#2. 단어 색상 목록 만들기

pal <- brewer.pal(8,"Dark2")

#3. 난수 고정하기 wordcloud는 함수가 호출 될 때마다 난수를 이용해 매번 다른 모양의 워드 클라우드를 만들어내기 때문
set.seed(1234)

#4. 워드 클라우드 만들기
wordcloud(words = df_word$word, # 단어
          freq = df_word$freq,  # 빈도
          min.freq = 2,         # 최소 단어 빈도
          max.words = 200,      # 표현 단어 수
          random.order = F,     # 고빈도 단어 중앙 배치
          rot.per = .1,         # 회전 단어 비율
          scale = c(4,0.3),     # 단어 크기 범위
          colors = pal)         # 색상 목록


#5. 단어 색상 바꾸기

pal <- brewer.pal(9,"Blues")[5:9]
set.seed(1234)

wordcloud(words = df_word$word, # 단어
          freq = df_word$freq,  # 빈도
          min.freq = 2,         # 최소 단어 빈도
          max.words = 200,      # 표현 단어 수
          random.order = F,     # 고빈도 단어 중앙 배치
          rot.per = .1,         # 회전 단어 비율
          scale = c(4,0.3),     # 단어 크기 범위
          colors = pal)         # 색상 목록
