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
# ����ʽ�Ͽ����൱����ԭ��d�Ļ����ϲ�����һ���µ����ݿ�
# ����mutate()��������ʶ�Ĳ�һ���� ����������
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
# �����ٿ���across()������
# ��mutate() �� across() ���صľ������ݿ�
# ���ò���ԭ��d��������һ���ġ�
d %>%
  mutate(
    across(x, list(f1 = ~ .x * 2, f2 = ~ .x^2))
  )
# across()�ķ������ݿ�����ԣ�
# ���mutate()�Ĳ������ݿ��ܣ������ݴ��������ˮ���绢����
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
