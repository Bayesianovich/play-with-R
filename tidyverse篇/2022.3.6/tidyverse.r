library(tidyverse)
iris <- iris %>% as_tibble()
iris
df_iris <- iris %>% head(5)
# mutate_if
df_iris %>% mutate_if(is.double, as.integer)

df_iris %>% mutate_if(is.numeric, list(scale, log))

df_iris %>% mutate_if(is.numeric, list(~ scale(.), ~ log(.)))

df <- tibble::tibble(
  x = letters[1:3],
  y = c(1:3),
  z = c(0, 0, 0)
)
df
# select_if
df %>% select_if(is.numeric)

df %>% select_if(~ n_distinct(.) > 2)


df %>% select_if(
  list(~ (is.numeric(.) | is.character(.)))
)

to_keep <- function(x) is.numeric(x) | is.character(x)
df %>% select_if(to_keep)

df %>% select_if(
    list(~(is.numeric(.) && sum(.) > 2))
)

df %>% select_if(
  list(~ (is.numeric(.) && mean(.) > 1))
)

# 改成函数形式
to_want <- function(x) is.numeric(x) && sum(x) > 3

df %>% select_if(to_want)

#summarise_if

msleep <- ggplot2::msleep
msleep %>% 
    dplyr::group_by(vore) %>%
    dplyr::summarise_if(is.numeric, mean, na.rm = TRUE)

# filter_if
msleep <- ggplot2::msleep
msleep %>%
  dplyr::select(name, sleep_total) %>%
  dplyr::filter(sleep_total > 18)

#filter_if()配合all_vars(), any_vars()函数，
# 可以完成很酷的工作. 比如，要求一行中所有变量的值都大于150
mtcars <- mtcars %>% as_tibble()
mtcars
mtcars %>% filter_all(all_vars(. > 150))

# group_by
mtcars %>% dplyr::group_by(cyl)
# or 
mtcars %>% group_by_at(vars(cyl))

# Group a data frame by all variables:
mtcars %>% group_by_all()

# Group by variables selected with a predicate:
iris %>% group_by_if(is.factor)

iris %>%
  dplyr::group_split(Species)

# across函数
# colwise：group_by() %>% summarize/mutate + across()
# rowwise：nest_by()/rowwise() %>% summarize/mutate + across(row.names)
iris %>%
  dplyr::group_by(Species) %>%
  dplyr::summarise(
    across(starts_with("Sepal"), mean),
    Area = mean(Petal.Length * Petal.Width),
    across(starts_with("Petal"), min)
  )

# across函数替代scope函数
df %>% mutate_if(is.numeric, mean, na.rm = TRUE)

df %>% mutate(across(is.numeric, mean, na.rm = TRUE))

