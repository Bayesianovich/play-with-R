l0 <- list(1, c(TRUE, FALSE), c("a", "b", "c"))
l0

l1 <- list(A = 1, B = c(TRUE, FALSE), C = c("a", "b", "c"))
l1

l1$A

l1[c("A","B")]


# as.list()������ת�����б�:
l2 <- as.list(c(a = 1, b = 3))
l2

## unlist()��һ���б���Ƴɷֽ��ߣ�ǿ��ת����һ������:
unlist(l2)


# �������ݿ�
library(tidyverse)
persons = tibble(
    Name = c("Alice", "Bob", "Charlie"),
    Gender = c("Female", "Male", "Female"),
    Age = c(24, 25, 23),
    Major = c("Finance", "Statistics", "Computer Science"))
persons

# ��tribble()����¼������ʽ����tibble��
tribble(
    ~Name, ~Gender, ~Age, ~Major,
    "Ken", "Male", 24, "Finance",
    "Ashley","Female",25, "Statistics"
)
