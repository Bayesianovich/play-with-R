library(tidyverse)

d <- tibble::tribble(
    ~variable, ~subject1, ~subject2, ~subject3,
    "mass", 75, 70, 55,
    "height", 154, 172, 144
)
d
#用geom_point(aes(x = mass, y = height)) 画图，却报错了
# ggplot画图需要先弄成tidy格式
d1 <- d %>% pivot_longer(
  cols = subject1:subject3,
  names_to = "subject",
  names_pattern = "subject(\\d)",
  values_to = "value"
)
d1
 
 d1 %>% 
  pivot_wider(names_from = variable,
              values_from = value)

