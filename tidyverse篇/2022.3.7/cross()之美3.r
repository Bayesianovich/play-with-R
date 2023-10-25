library(tidyverse)
library(palmerpenguins)

penguins <- palmerpenguins::penguins %>% drop_na()

penguins %>%
  mutate(
    across(where(is.numeric), log),
    across(where(is.character), as.factor)
  )

penguins %>% 
  group_by(species) %>%
  summarise(
    across(starts_with("bill_length_"), mean),
    Area = mean(bill_length_mm * bill_depth_mm),
    across(starts_with("bill_depth_"), min)
  )

penguins %>% 
  select(species, sex, bill_length_mm) %>% 
  summarise(
    mean = mean(bill_length_mm),
    across(-bill_length_mm)
  )

penguins %>% 
  group_by(across(c(species, island, sex))) %>% 
  summarise(
   across(bill_length_mm, mean, na.rm = TRUE)
  )

penguins %>% 
  group_by(across(where(is.factor))) %>% 
  summarise(
    across(bill_length_mm, mean, na.rm = TRUE)
  )

sum_group_vars <- function(df, group_vars, sum_vars) {
  df %>% 
    group_by(across({{ group_vars }})) %>% 
    summarise(n = n(), 
              across({{ sum_vars }}, 
                     list(mean = mean, sd = sd))
              )
}

penguins %>% 
  sum_group_vars(
    c(species, year), c(bill_length_mm, bill_depth_mm)
  )
# filter()
df <- tibble(
  a = letters[1:5],
  b = 1:5,
  c = 6:10,
  d = 11:15
)


df %>%
  dplyr::filter(
    across(where(is.numeric), .fns = ~ .x > 2)
  )

# 等价
df %>%
  dplyr::filter(
    if_all(where(is.numeric), .fns = ~ .x > 2)
  )

# 用在distinct函数
penguins %>% 
  distinct(
    across(c(island, species))
  )

penguins %>% 
  arrange(across(bill_length_mm))

penguins %>% 
  arrange(across(ends_with("_mm")))

f <- function(.data, order_by) {
  .data %>%
    arrange(across({{order_by}}))
}

penguins %>% 
  f(sex)

penguins %>% 
  count(across(sex))

penguins %>% 
  count(
    across(where(is.factor))
  )

count_multiple <- function(df, ...) {
  df %>% 
    select(...) %>% 
    names() %>% 
    map( ~ count(df, across(all_of(.x)), sort = TRUE))
}

penguins %>%
  count_multiple(where(is.factor))

# 用在purrr::map函数中
tibble(
  x = 1:3,
  y = 2:4
) %>% 
  rowwise() %>% 
  mutate(
    min = mean(c_across())
  )


tibble(
  x = 1:3,
  y = 2:4
) %>% 
  pmap_dfr(
    ~list(z = mean(c(...)))
  )
