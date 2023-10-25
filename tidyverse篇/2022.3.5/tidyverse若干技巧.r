# most of data science is counting, and sometimes diviting -Hadley Wickham

library(tidyverse)
library(patchwork)

df <- tibble(
    name = c("Alice", "Alice", "Bob","Bob", "Carol", "Carol"),
    type = c("english", "math", "english", "math", "english", "math"),
    score = c(60.2, 90.5, 92.2, 98.8, 82.5, 74.6)
)
df

df %>% count(name)

df %>% 
  group_by(name) %>% 
  summarise( n = n())

# 把score放在第一列，对列变量较多的情形非常适用
df %>%
  select(score, everything())
# 选元素
v <- c("a", "c", "d", "k")
v[1]
v[length(v)]
v %>% nth(3)

v %>% first()

 # if_else
 df %>%
    mutate(
        assess = if_else(score > 85, "very_good", "good")
    )

# drop_na
dt <- tribble(
    ~x, ~y,
    1, NA,
    2, NA,
    NA, -3,
    NA, -4,
    5, -5
)
dt %>% drop_na()
