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

# ����min��max
df %>%
  group_by(grp) %>%
  summarise(rng = range(x))
# quantile,���ض��ֵ
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
# ͨ��λ����������ѡȡ
df %>% select(1, 3)

df %>% select(2:3)

 # ͨ������
 df %>% select(grp, x, y)

df %>% select(x:y)

#ͨ��������ѡ
df %>% select(starts_with("x"))

df %>% select(ends_with("p"))

df %>% select(contains("x"))

df %>% select(matches("x"))

# ͨ��������ѡ
df %>% select(where(is.character))
df %>% select(where(is.numeric))

# ͨ���������
df %>% select(!where(is.character))

df %>% select(where(is.numeric) & starts_with("x"))

df %>% select(starts_with("g") | ends_with("y"))

vars <- c("x", "y", "z")
df %>% select(all_of(vars))
df %>% select(any_of(vars))

#������ĳ��
df %>% rename(group = grp)

df %>% rename_with(toupper)

df %>% rename_with(toupper, is.numeric)

df %>% rename_with(toupper, starts_with("x"))

# arrange���������з��������
df %>% arrange(desc(abs(x)))

df %>% select(x, grp, y)

# ���������Ƽ�relocate����
df %>% relocate(grp, .after = y)

df %>% relocate(x, .before = grp)


df %>% relocate(grp, .after = last_col())

# ��Ҫ�����ݿ�Ķ���ִ����ͬ�Ĳ���
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

# across�����򻯲���
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

# rowwise��������c_across����

df %>%
  rowwise() %>%
  mutate(
    avg = mean(c_across(w:z))
  )

# ����ܺõĽ�������У�rowwise()����ԭ��������group_by()��
# �ǰ�ÿһ�н��з��飬Ȼ���У��з���ͳ��

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

# ��cyl���飬����ÿ����mpg ~ wt������ģ�͵�ϵ��.
mtcars %>%
  group_by(cyl) %>%
  nest()

# �з��������
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
