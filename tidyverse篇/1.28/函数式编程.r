# R������֧��������(����������ߺ���������������ÿһ��Ԫ����),����������������ѭ����
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
# ���취
list(
    student1 = mean(exams$student1),
    student2 = mean(exams$student2),
    student3 = mean(exams$student3),
    student4 = mean(exams$student4),
    student5 = mean(exams$student5)
)
# �Ľ�(���ص���list)
exams %>% map(mean)
# ������ֵ����
exams %>% map_dbl(mean)

# �������ݿ�
exams %>% map_df(var)

# �������
## ��ÿλͬѧ�ĳɼ�����,Ĭ�ϵ�������
map(exams, sort)
sort(exams$student1, decreasing = TRUE)
# �ȼ���
map(exams, sort, decreasing = TRUE)


my_fun <- function(x) {
    x - mean(x)
}

exams %>% map_df(my_fun)

exams %>%
    map(function(x) x - mean(x))
# ��~����function(),�������ǲ��������ǹ涨д��,����.x
exams %>% map(~ .x - mean(.x))

# ��ʱ�򣬳���Ա����x�����е���࣬���Ǹ�����һ�㣬ֻ��.�� Ҳ�ǿ��Ե�
exams %>% map(~ . - mean(.))


exams %>%
    map_int(~ length(.[. > 80]))

tb <- tibble(
    col_1 = c(1, 2, 3),
    col_2 = c(100, 200, 300),
    col_3 = c(0.1, 0.2, 0.3)
)
tb
# map()�еĺ���f���������õ�ÿһ��
map_dbl(tb, median)
# �ҳ����������ÿ��ȱʧֵNA������
palmerpenguins::penguins %>%
    map_int(~ sum(is.na(.)))

# ��ʾ�б���ÿ��Ԫ�صĳ���
tibble(
    x = list(1, 2:3, 4:6)
) %>%
    mutate(l = purrr::map_int(x, length))

# ���ڸ��ֺ���,������������
tibble(
    x = c(3, 5, 6)
) %>%
    mutate(r = purrr::map(x, ~ rnorm(.x, mean = 0, sd = 1)))

# ���ڽ�ģ
mtcars %>%
    group_by(cyl) %>%
    nest() %>%
    mutate(model = purrr::map(data, ~ lm(mpg ~ wt, data = .))) %>%
    mutate(result = purrr::map(model, ~ broom::tidy(.))) %>%
    unnest(result)
## Ҫ�о���purrr

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

# tibble��ÿһ�ж������������Կ��԰�map2()����mutate()�����ڲ�����tibble�Ķ���ͬʱ����
df <-
    tibble(
        a = c(1, 2, 3),
        b = c(10, 20, 30)
    )
df %>%
    mutate(min = map2_dbl(a, b, ~ min(.x, .y)))
# rowwise()����
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
