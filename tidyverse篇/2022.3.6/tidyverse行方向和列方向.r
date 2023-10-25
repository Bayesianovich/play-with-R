library(tidyverse)
df <- tibble(
  grp = rep(c("a", "b"), each = 5),
  x = c(rnorm(5, -0.25, 1), rnorm(5, 0, 1.5)),
  y = c(rnorm(5, 0.25, 1), rnorm(5, 0, 0.5))
)
df

df %>%
  group_by(grp) %>%
  summarise(rng = mean(x))

# 返回min、max
df %>%
  group_by(grp) %>%
  summarise(rng = range(x))
# quantile,返回多个值
df %>%
  group_by(grp) %>%
  summarise(rng = quantile(x, c(0.25, 0.5, 0.75))
  )

df %>%
  group_by(grp) %>%
  summarise(
    x = quantile(x, c(0.25, 0.5, 0.75)),
    q = c(0.25, 0.5, 0.75)
  )

my_quantile <- function(x, probs) {
  tibble(x = quantile(x, probs), probs = probs) # nolint
}
mtcars %>%
  group_by(cyl) %>%
  summarise(my_quantile(disp, c(0.25, 0.75)))

mtcars %>%
  group_by(cyl) %>%
  summarise(
    broom::tidy(lm(mpg ~ wt))
  )
# 通过位置索引进行选取
df %>% select(1, 3)

df %>% select(2:3)

 # 通过列名
 df %>% select(grp, x, y)

df %>% select(x:y)

#通过函数来选
df %>% select(starts_with("x"))

df %>% select(ends_with("p"))

df %>% select(contains("x"))

df %>% select(matches("x"))

# 通过类型来选
df %>% select(where(is.character))
df %>% select(where(is.numeric))

# 通过各种组合
df %>% select(!where(is.character))

df %>% select(where(is.numeric) & starts_with("x"))

df %>% select(starts_with("g") | ends_with("y"))

vars <- c("x", "y", "z")
df %>% select(all_of(vars))
df %>% select(any_of(vars))

#重命名某列
df %>% rename(group = grp)

df %>% rename_with(toupper)

df %>% rename_with(toupper, is.numeric)

df %>% rename_with(toupper, starts_with("x"))

# arrange排序，这是行方向的排序
df %>% arrange(desc(abs(x)))

df %>% select(x, grp, y)

# 列数多了推荐relocate函数
df %>% relocate(grp, .after = y)

df %>% relocate(x, .before = grp)


df %>% relocate(grp, .after = last_col())

# 需要对数据框的多列执行相同的操作
iris <- iris %>% as_tibble()
iris

iris %>%
  group_by(Species) %>%
  summarise(
    mean_Sepal_Length = mean(Sepal.Length),
    mean_Sepal_Width = mean(Sepal.Width),
    mean_Petal_Length = mean(Petal.Length),
    mean_Petal_Width = mean(Petal.Width)
  )

# across函数简化操作
iris %>%
    group_by(Species) %>%
    summarise(
        across(everything(), mean)
    )
iris %>%
  group_by(Species) %>%
  summarise(
    across(is.numeric, mean)
  )


std <- function(x) {
  (x - mean(x)) / sd(x)
}

iris %>%
  group_by(Species) %>%
  summarise(
    across(starts_with("Sepal"), std)
  )


# purrr style
iris %>%
  group_by(Species) %>%
  summarise(
    across(starts_with("Sepal"), ~ (.x - mean(.x)) / sd(.x))
  )

iris %>%
  group_by(Species) %>%
  summarise(
    across(starts_with("Sepal"), mean),
    Area = mean(Petal.Length * Petal.Width),
    across(c(Petal.Width), min),
    n = n()
  )

iris %>% mutate(across(is.numeric, mean))

df <- tibble(id = letters[1:6], w = 10:15, x = 20:25, y = 30:35, z = 40:45)
df

df %>% mutate(avg = mean(c(w, x, y, z)))

df %>%
  pivot_longer(
    cols = -id,
    names_to = "variable",
    values_to = "value"
  ) %>%
  group_by(id) %>%
  summarize(
    r_mean = mean(value)
  )

library(purrr)
df %>%
  mutate(r_mean = pmap_dbl(select_if(., is.numeric), lift_vd(mean)))

df %>%
  rowwise() %>%
  mutate(avg = mean(c(w, x, y, z)))

# rowwise函数加上c_across函数

df %>%
  rowwise() %>%
  mutate(
    avg = mean(c_across(w:z))
  )

# 这个很好的解决方案中，rowwise()工作原理类似与group_by()，
# 是按每一行进行分组，然后按行（行方向）统计

df %>%
  rowwise(id) %>%
  mutate(total = mean(c_across(w:z)))

tb <- tibble(
  x = list(1, 2:3, 4:6)
)
tb %>% mutate(l = purrr::map_int(x, length))

tb %>%
  rowwise() %>%
  mutate(l = length(x))

mtcars <- mtcars %>% as_tibble()
mtcars

# 以cyl分组，计算每组中mpg ~ wt的线性模型的系数.
mtcars %>%
  group_by(cyl) %>%
  nest()

# 列方向的做法
mtcars %>%
  group_by(cyl) %>%
  nest() %>%
  mutate(model = purrr::map(data, ~ lm(mpg ~ wt, data = .))) %>%
  mutate(result = purrr::map(model, ~ broom::tidy(.))) %>%
  unnest(result)

mtcars %>%
  nest_by(cyl) %>%
  mutate(model = list(lm(mpg ~ wt, data = data))) %>%
  summarise(broom::tidy(model))


# or
mtcars %>%
  nest_by(cyl) %>%
  summarise(
    broom::tidy(lm(mpg ~ wt, data = data))
  )
