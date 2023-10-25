library(tidyverse)

penguins <- palmerpenguins::penguins %>% drop_na()

d <- tibble(
  x = 3:5
)

d %>% 
  mutate(x1 = x*2)

d %>% 
  mutate(
    x1 = x*2,
    x2 = x^2
  )
# 从形式上看，相当于在原来d的基础上并入了一个新的数据框。
# 或许mutate()和我们认识的不一样， 于是我试试
t <- tibble(
  y = 4:6
)

d %>% 
  mutate(t)

my_fun <- function(x) {
  tibble(
    x1 = x * 2, 
    x2 = x^2)
}

d %>%
  mutate(
    my_fun(x)
  )
# 我们再看看across()函数，
# 在mutate() 中 across() 返回的就是数据框，
# 正好并入原来d，道理是一样的。
d %>%
  mutate(
    across(x, list(f1 = ~ .x * 2, f2 = ~ .x^2))
  )
# across()的返回数据框的特性，
# 结合mutate()的并入数据框功能，让数据处理如鱼得水、如虎添翼。
d <- tibble::tribble(
  ~water, ~food,
  10.0,   10.0,
  12.1,   10.3,
  13.5,   19.1,
  17.4,   16.0,
  25.8,   15.6,
  27.4,   19.8
)
d

d %>%
  rownames_to_column() %>%
  pivot_longer(
    cols = !rowname
  ) %>%
  group_by(rowname) %>%
  mutate(
    percent = 100 * value / sum(value)
  ) %>%
  ungroup() %>%
  pivot_wider(
    names_from = name,
    values_from = c(value, percent),
    names_glue = "{name}_{.value}"
  )

d %>%
  mutate(100 * across(.names = "%{.col}") / rowSums(across())) %>%
  ungroup()

rowPercent <- function(df) {
  df / rowSums(df) * 100
}

rowPercent <- function(df) {
  df / rowSums(df) * 100
}

d %>%
  mutate(rowPercent(across(.names = "%{.col}")))

d %>% 
  rowwise() %>% 
  mutate(
    across(everything(), ~ .x / sum(c_across()) )
  )


d %>% 
  rowwise() %>% 
  mutate(
    across(everything(), .names = "prop_{.col}", ~ .x / sum(c_across())  )
  )


d %>% 
  rowwise() %>% 
  mutate(
    across(.names = "prop_{.col}", .fns =  ~ .x / sum(c_across())  )
  )
