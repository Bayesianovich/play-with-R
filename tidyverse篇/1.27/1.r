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
# ������"score"����
df %>%
    select(contains("score"))
# ѡȡ������ֵ������"s"��ͷ����
df %>%
    select(where(is.numeric) & starts_with("s"))
# ѡȡ��"s"��ͷ������"e"��β����
df %>%
    select(starts_with("s") | ends_with("e"))
# �޸�����,�Ⱥ�������µı�����,�ұ����Ѿ����ڵı�����
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

