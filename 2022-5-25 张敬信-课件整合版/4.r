l0 <- list(1, c(TRUE, FALSE), c("a", "b", "c"))
l0

l1 <- list(A = 1, B = c(TRUE, FALSE), C = c("a", "b", "c"))
l1

l1$A

l1[c("A","B")]


# as.list()将向量转换成列表:
l2 <- as.list(c(a = 1, b = 3))
l2

## unlist()将一个列表打破成分界线，强制转换成一个向量:
unlist(l2)


# 创建数据框
library(tidyverse)
persons = tibble(
    Name = c("Alice", "Bob", "Charlie"),
    Gender = c("Female", "Male", "Female"),
    Age = c(24, 25, 23),
    Major = c("Finance", "Statistics", "Computer Science"))
persons

# 用tribble()按行录入数据式创建tibble。
tribble(
    ~Name, ~Gender, ~Age, ~Major,
    "Ken", "Male", 24, "Finance",
    "Ashley","Female",25, "Statistics"
)
