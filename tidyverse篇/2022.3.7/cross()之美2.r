library(tidyverse)
library(palmerpenguins)

# �������
penguins %>% 
  filter( across(everything(), any_vars(is.na(.)))
)

# ����ֻ����dplyr 1.0.0֮ǰ��filter_all()����ʵ��
penguins %>% 
  filter_all( any_vars(is.na(.)) )

#dplyr 1.0.4�Ƴ��� if_any() and if_all() ���������������ֲ����ȱ��

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
