```r
library(tidyverse)
library(rlang)
```
写代码的过程中，我们会遇到对不同的数据框，执行相同的操作。

```r
df1 %>% group_by(x1) %>% summarise(mean = mean(y1))
df2 %>% group_by(x2) %>% summarise(mean = mean(y2))
df3 %>% group_by(x3) %>% summarise(mean = mean(y3))
df4 %>% group_by(x4) %>% summarise(mean = mean(y4))
```
为了减少代码的重复，我们考虑将共同的部分保留，变化的部分用参数名提取出来

```r
data %>% group_by(group_var) %>% summarise(mean = mean(summary_var))
```
我们想到写一个子函数的形式

```r
grouped_mean <- function(data, group_var, summary_var) {
  group_var <- enquo(group_var)
  summary_var <- enquo(summary_var)

  data %>%
    group_by(!!group_var) %>%
    summarise(mean = mean(!!summary_var))
}
```
第一步，用 enquo()把用户传递过来的参数引用起来（引用可以理解为冷冻起来）

第二步，用 !! 解开这个引用（解引用可以理解为解冷），然后使用参数的内容
```r
grouped_mean <- function(data, group_var, summary_var) {
  data %>%
    group_by({{group_var}}) %>%
    summarise(mean = mean({{summary_var}}))
}

grouped_mean(mtcars, cyl, mpg)

```
```r
grouped_mean(mtcars, cyl, mpg)
```

环境变量(env-variables)

数据变量(data-variables)

`grouped_mean(mtcars, cyl, mpg)`

cyl、mpg是打算传递的参数,是环境变量

如果传递更多的参数，可以用...代替group_var ，然后传递到group_by()，比如

```r
grouped_mean <- function(data, summary_var, ...) {
  summary_var <- enquo(summary_var)
    group_var <- enquos(...)
 
  data %>%
    group_by(!!!group_var) %>%
    summarise(mean = mean(!!summary_var))
}

grouped_mean(mtcars, disp, cyl, am)
```
