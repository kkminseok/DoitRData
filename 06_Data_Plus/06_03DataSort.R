#순서대로 정렬하기

exam %>% arrange(math)

#내림차순 정렬

exam %>% arrange(desc(math))

#기준 여러개로 정하기

exam %>% arrange(class,math)
