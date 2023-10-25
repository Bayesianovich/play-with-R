# R语言是支持向量化(将运算符或者函数作用在向量的每一个元素上),可以用向量化代替循环。
require(tidyverse)


a_list <- list(
    num = c(8, 9),
    log = TRUE,
    cha = c("a", "b", "c")
)
a_list

a_list$num

a_list[["num"]]

# tidyverse
a_list %>% pluck("num")

exams <- list(
    student1 = round(runif(10, 50, 100)),
    student2 = round(runif(10, 50, 100)),
    student3 = round(runif(10, 50, 100)),
    student4 = round(runif(10, 50, 100)),
    student5 = round(runif(10, 50, 100))
)
exams
# 笨办法
list(
    student1 = mean(exams$student1),
    student2 = mean(exams$student2),
    student3 = mean(exams$student3),
    student4 = mean(exams$student4),
    student5 = mean(exams$student5)
)
# 改进(返回的是list)
exams %>% map(mean)
# 返回数值向量
exams %>% map_dbl(mean)

# 返回数据框
exams %>% map_df(var)

# 额外参数
## 将每位同学的成绩排序,默认的是升序
map(exams, sort)
sort(exams$student1, decreasing = TRUE)
# 等价于
map(exams, sort, decreasing = TRUE)


my_fun <- function(x) {
    x - mean(x)
}

exams %>% map_df(my_fun)

exams %>%
    map(function(x) x - mean(x))
# 用~代替function(),但代价是参数必须是规定写法,比如.x
exams %>% map(~ .x - mean(.x))

# 有时候，程序员觉得x还是有点多余，于是更够懒一点，只用.， 也是可以的
exams %>% map(~ . - mean(.))


exams %>%
    map_int(~ length(.[. > 80]))

tb <- tibble(
    col_1 = c(1, 2, 3),
    col_2 = c(100, 200, 300),
    col_3 = c(0.1, 0.2, 0.3)
)
tb
# map()中的函数f，可以作用到每一列
map_dbl(tb, median)
# 找出企鹅数据中每列缺失值NA的数量
palmerpenguins::penguins %>%
    map_int(~ sum(is.na(.)))

# 显示列表中每个元素的长度
tibble(
    x = list(1, 2:3, 4:6)
) %>%
    mutate(l = purrr::map_int(x, length))

# 用于各种函数,比如产生随机数
tibble(
    x = c(3, 5, 6)
) %>%
    mutate(r = purrr::map(x, ~ rnorm(.x, mean = 0, sd = 1)))

# 用于建模
mtcars %>%
    group_by(cyl) %>%
    nest() %>%
    mutate(model = purrr::map(data, ~ lm(mpg ~ wt, data = .))) %>%
    mutate(result = purrr::map(model, ~ broom::tidy(.))) %>%
    unnest(result)
## 要研究哈purrr

# exercise
library(purrr)

# define vectors  to operate on
x <- list(1, 2, 3)
y <- list(10, 20, 30)
z <- list(100, 200, 300)

# iterate over (multiple) arguments simultaneously
map(x, .f = ~ .x * 2)
map2(x, y, .f = ~ .x * .y)
pmap(list(x, y, z), .f = ~ ..1 + ..2 + ..3)

# map2
x <- c(1, 2, 3)
y <- c(10, 20, 30)

map2(x, y, ~ .x + .y)

# tibble的每一列都是向量，所以可以把map2()放在mutate()函数内部，对tibble的多列同时迭代
df <-
    tibble(
        a = c(1, 2, 3),
        b = c(10, 20, 30)
    )
df %>%
    mutate(min = map2_dbl(a, b, ~ min(.x, .y)))
# rowwise()方法
df %>%
    rowwise() %>%
    mutate(min = min(a, b)) %>%
    ungroup()

map2_dbl(x, y, min)

pmap_dbl(list(x, y), min)

tibble(
    a = c(50, 60, 70),
    b = c(10, 90, 40),
    c = c(1, 105, 200)
) %>%
    pmap_dbl(min)

pmap(
    list(1:5, 5:1, 2), ~ ..1 + ..2 - ..3
)
params <- tibble::tribble(
    ~n, ~min, ~max,
    1L, 0, 1,
    2L, 10, 100,
    3L, 100, 1000
)

pmap(params, ~ runif(n = ..1, min = ..2, max = ..3))

pmap(params, runif)

plot_rnorm <- function(sd) {
    tibble(x = rnorm(n = 5000, mean = 0, sd = sd)) %>%
        ggplot(aes(x)) +
        geom_histogram(bins = 40) +
        geom_vline(xintercept = 0, colour = "blue")
}
plots <-
    c(5, 1, 9) %>%
    map(plot_rnorm)

plots %>%
    walk(print)
