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
stringr::str_glue("����{k}�Σ��õ� e = {s}")


x <- matrix(1:6, ncol = 3)
x
apply(x, 1, mean)

apply(x, 2, mean)

height <- c(165, 170, 168, 172, 159)
sex <- factor(c("��", "Ů", "��", "��", "Ů"))
tapply(height, sex, mean)

df <- iris[, 1:4]
map_dbl(df, mean)


map_chr(df, mean)


# �Զ����һ������
Rescale <- function(x, type = "pos") {
    rng <- range(x, na.rm = TRUE) # ������Сֵ���ֵ
    if (type == "pos") {
        (x - rng[1]) / (rng[2] - rng[1])
    } else {
        (rng[2] - x) / (rng[2] - rng[1])
    }
}

# �Ը�������һ��������Ϊ����ָ��
map_dfc(df, Rescale)

# �Ը�������һ������ָ��Ϊ����,���򣬸�������
type <- c("pos", "neg", "neg", "pos")
map_dfc(df,  Rescale,type)

Sys.getlocale("LC_CTYPE")
# ���� 936�ͱ�����"�й�-��������(GB2312)"



