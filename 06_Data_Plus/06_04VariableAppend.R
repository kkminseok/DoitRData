#파생변수 추가하기
exam %>% 
  mutate(total = math + english + science) %>% 
  head

exam %>% 
  mutate(total = math + english +science,
         mean = total/3) %>% 
  head

exam %>% 
  mutate(test = ifelse(science >= 60,"pass","fasil")) %>% 
  head

exam %>% 
  mutate(total = math + english + science) %>% 
  arrange(total) %>% 
  head

#기존 파생변수 추가하기 보다 좋은점은 코드쓰는양이 줄어든다는 점이다.

