here::here()
here::here("ABrainfall.txt")
require(tidyverse)
df <- readr::read_csv(here::here("demo_data", "score.csv"))
df
# mutate
reward <- c(2, 5, 9, 8, 5, 6)
mutate(df, extra = reward)
mutate(df,
    extra1 = c(2, 5, 9, 8, 5, 6),
    extra2 = c(1, 2, 3, 3, 2, 1),
    extra3 = c(8)
)

# %>%
c(1:10) %>% sum()
df %>% mutate(extra = reward)
c(-10:10) %>%
    abs() %>%
    sum() %>%
    sqrt()

calc_square <- function(x) {
    x^2
}
df %>%
    mutate(new_col = calc_square(score))

# add more columns
df <- df %>%
    mutate(extra = reward) %>%
    mutate(total = score + extra)
df

# select columns
df %>%
    select(extra)

df %>%
    select(extra, total, name)
df %>%
    select(-extra)

df %>%
    select(!name)
df %>%
    select(1, 2, 3)

df %>%
    select(starts_with("s"))

df %>%
    select(ends_with("e"))
# 含有以"score"的列
df %>%
    select(contains("score"))
# 选取所有数值列且以"s"开头的列
df %>%
    select(where(is.numeric) & starts_with("s"))
# 选取以"s"开头或者以"e"结尾的列
df %>%
    select(starts_with("s") | ends_with("e"))
# 修改列名,等号左边是新的变量名,右边是已经存在的变量名
df %>%
    select(name, type, total) %>%
    rename(total_score = total)

# filter
df %>%
    filter(score == 90)
df %>%
    filter(score >= 80)

df %>%
    filter(type == "english", score >= 75)

df %>% filter(score %in% c(70, 90))

df %>% filter(score == max(score))

df %>% filter(score > mean(score))

df %>% summarise(mean_score = mean(score))

df %>%
    group_by(name) %>%
    summarise(
        mean_score = mean(total),
        sd_score = sd(total)
    )

# arrange
df %>%
    arrange(total, -extra)

df %>%
    arrange(desc(total))

df %>%
    arrange(desc(total), extra)

df %>%
    arrange(type, desc(total))

