x <- "b"

v <- switch(x,
    "a" = "apple",
    "b" = "banana",
    "c" = "cherry"
)

v

## for
library(tidyverse)
df <- as_tibble(iris[, 1:4])

output <- vector("double", 4)
for (i in 1:4) {
    output[i] <- mean(df[[i]])
}
output


output <- list()
for (i in 1:4) {
    output[[i]] <- c(i, i^2)
}
output
class(output)

set.seed(123)
while (TRUE) {
    x <- rnorm(1)
    print(x)
    if (x > 1) break
}

s <- 1.0
x <- 1
k <- 0
repeat{
    k <- k + 1
    x <- x / k
    s <- s + x
    if (x < 1e-10) break
}
stringr::str_glue("迭代{k}次，得到 e = {s}")


x <- matrix(1:6, ncol = 3)
x
apply(x, 1, mean)

apply(x, 2, mean)

height <- c(165, 170, 168, 172, 159)
sex <- factor(c("男", "女", "男", "男", "女"))
tapply(height, sex, mean)

df <- iris[, 1:4]
map_dbl(df, mean)


map_chr(df, mean)


# 自定义归一化函数
Rescale <- function(x, type = "pos") {
    rng <- range(x, na.rm = TRUE) # 计算最小值最大值
    if (type == "pos") {
        (x - rng[1]) / (rng[2] - rng[1])
    } else {
        (rng[2] - x) / (rng[2] - rng[1])
    }
}

# 对各列做归一化，若均为正向指标
map_dfc(df, Rescale)

# 对各列做归一化，各指标为正向,负向，负向，正向
type <- c("pos", "neg", "neg", "pos")
map_dfc(df,  Rescale,type)

Sys.getlocale("LC_CTYPE")
# 代码 936就表明是"中国-简体中文(GB2312)"



