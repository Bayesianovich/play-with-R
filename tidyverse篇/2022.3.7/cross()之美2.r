library(tidyverse)
library(palmerpenguins)

# 结果不对
penguins %>% 
  filter( across(everything(), any_vars(is.na(.)))
)

# 发现只能用dplyr 1.0.0之前的filter_all()函数实现
penguins %>% 
  filter_all( any_vars(is.na(.)) )

#dplyr 1.0.4推出了 if_any() and if_all() 两个函数，正是弥补这个缺陷

penguins %>% 
    filter(if_any(everything(), is.na))

penguins %>% 
    filter(if_all(contains("bill"), ~ . > 21))

penguins %>% 
  filter(if_any(contains("bill"), ~ . > 21))

bigger_than_mean <- function(x) {
  x > mean(x, na.rm = TRUE)
}

penguins %>% 
  filter(if_all(contains("bill"), bigger_than_mean))

penguins %>% 
  filter(!is.na(bill_length_mm)) %>% 
  mutate(
    category = case_when(
      if_all(contains("bill"), bigger_than_mean) ~ "both big", 
      if_any(contains("bill"), bigger_than_mean) ~ "one big", 
      TRUE                          ~ "small"
    ))
