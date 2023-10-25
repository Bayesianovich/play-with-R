library(tidyverse)

penguins <- read_csv("penguins.csv")
penguins

c(NA, 1) + 2

isTRUE(NA)

isFALSE(NA)

c(TRUE, FALSE) | NA

c(1, 2, NA, 4) %>% is.na()


c(TRUE, FALSE, NA) %>% class()

c("1", "2", NA, "4") %>% class()

c(TRUE, NA, FALSE) 

c(TRUE, NA, FALSE) %>% class()

# c() 函数要求数据类型必须一致，因此就会发生强制转换
c(1, 2, TRUE, 4)

c(1, 2, TRUE, 4) %>% class()

c(1, 2, NA, 4) 

c(1, 2, NA, 4) %>% class()

c(1, 2, NA_real_, 4)

c(1, 2, NA_real_, 4) %>% class()


c(123, NA, NA_real_) %>% 
  purrr::map(., ~is.numeric(.))


c(1, 2, NA, 4) %>% is.na() %>% as.integer() %>% sum()

c(1, 2, NA, 4) %>% is.na() %>% sum()

sum_of_na <- function(x){
  sum(is.na(x))
}

c(1, 2, NA, 4) %>% sum_of_na()


penguins$bill_length_mm %>% sum_of_na()


penguins %>% summarise(
  across(everything(), sum_of_na)
)

penguins %>% summarise(
  across(everything(), ~sum(is.na(.x)))
)

d <- tibble(x = c(1, 3, 6, NA, 8, NA))
d



