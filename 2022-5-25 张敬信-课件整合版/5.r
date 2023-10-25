x <- c("优", "中", "良", "优", "良", "良")
x

sort(x)

x1 <- factor(x, levels = c("优", "中", "良"))
x1

as.numeric(x1)
sort(x1)
table(x1)
library(tidyverse)
ggplot(tibble(x1), aes(x1)) +
    geom_bar()

levels(x1) <- c("Fair", "Good", "Excellent")
x1


x2 <- factor(x, levels = c("中", "良", "优"), ordered = TRUE)

x2

table(x2)
count(mpg, class)

mpg1 <- mpg %>%
    mutate(class = fct_lump(class, n=5))

count(mpg1, class)

mpg1 <- mpg %>%
    mutate(class = fct_lump(class, n=5)) 
count(mpg1, class)

p1 <- ggplot(mpg, aes(class)) +
    geom_bar()
p2 <- ggplot(mpg,aes(fct_infreq(class))) +
    geom_bar()

library(patchwork)
p1 | p2


##日期时间
library(lubridate) 
today()

now()
