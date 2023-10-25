require(tidyverse)
library(palmerpenguins)

# 去掉缺失值
penguins <- penguins %>% drop_na()
# 选择“bill_”开始的列
penguins %>% select(starts_with("bill_"))
# 选择“_mm”结尾的列
penguins %>% select(ends_with("_mm"))

# 选择含有“length”的列
penguins %>% select(contains("length"))

# 选择数值型的列
penguins %>% select(where(is.numeric))

# 选择字符串类型的列
penguins %>% select(where(is.character))

# 选择字符串类型以外的列
penguins %>% select(!where(is.character))

# 选多个列
penguins %>%
    select(species, starts_with("bill_"))
# 注意返回向量还是数据框
# 返回向量

my_tibble[["x"]]

my_tibble$x

my_tibble %>% pull(x)

# 返回数据框
my_tibble["x"]

my_tibble %>% select(x)

# 寻找男企鹅
penguins %>% filter(sex == "male")

penguins %>% filter(species %in% c("Adelie", "Gentoo"))

penguins %>% filter(species == "Adelie" & bill_length_mm > 40)
# 选一个
penguins %>% slice(1)

penguins %>%
    group_by(species) %>%
    slice(1)

penguins %>%
    arrange(-bill_length_mm) %>%
    slice(1)

penguins %>%
    slice_max(bill_length_mm)

# 有关NA的计算
sum(c(1, 2, NA, 4))
# 需要把它删了
sum(c(1, 2, NA, 4), na.rm = TRUE)

penguins %>%
    mutate(
        body = if_else(body_mass_g > 4200, "you are fat", "you are fine")
    ) %>%
    select(body)

df <- tibble::tribble(
    ~name, ~type, ~score,
    "Alice", "english", 80,
    "Alice", "math", NA,
    "Bob", "english", 70,
    "Bob", "math", 69,
    "Carol", "english", NA,
    "Carol", "math", 90
)
df
# 用考试成绩的君子替代缺失值
df %>%
    group_by(type) %>%
    mutate(mean_score = mean(score, na.rm = TRUE)) %>%
    mutate(newscore = ifelse(is.na(score), mean_score, score))

# 给企鹅身材分类
penguins
penguins %>%
    mutate(
        body = case_when(
            body_mass_g < 3500 ~ "best",
            body_mass_g >= 3500 & body_mass_g < 4500 ~ "good",
            body_mass_g > 4500 & body_mass_g < 5500 ~ "general",
            TRUE ~ "other"
        )
    )

# 分类case_when
penguins %>%
    mutate(
        degree = case_when(
            bill_length_mm < 35 ~ "A",
            bill_length_mm >= 35 & bill_length_mm < 45 ~ "B",
            bill_length_mm >= 45 & bill_length_mm < 55 ~ "C",
            TRUE ~ "D"
        )
    )

# n()函数,统计当前分组数据框的行数
penguins %>%
    summarise(
        n()
    )

penguins %>%
    group_by(species) %>%
    summarise(
        n(),
    )
# 统计某个变量中各组出现的次数,可以使用count()函数
penguins %>% count(species)
# 不同性别企鹅各有多少
penguins %>%
    count(sex, sort = TRUE)

# count()里构建新变量,并利用这个新变量完成统计。
penguins %>% count(longer_bill = bill_length_mm > 40)

# 强制转换 character > numeric >logic
# double > integer

penguins %>%
    mutate(
        is_bigger40 = bill_length_mm > 40
    ) %>%
    count(is_bigger40)
# across 之美 求均值
penguins %>%
    summarise(
        across(c(bill_depth_mm, bill_length_mm), mean)
    )

# 求均值
penguins %>%
    summarise(
        across(c(bill_depth_mm, bill_length_mm, flipper_length_mm), mean)
    )
# across 对多列执行相同的函数操作,返回数据框
penguins %>%
    summarise(
        across(ends_with("_mm"), mean)
    )

# across 数据中心化
penguins %>%
    mutate(
        bill_depth_mm = bill_length_mm - mean(bill_length_mm),
        bill_depth_mm = bill_depth_mm - mean(bill_depth_mm)
    )
# 或

centralized <- function(x) {
    x - mean(x)
}

penguins %>%
    mutate(
        across(c(bill_depth_mm, bill_length_mm), centralized)
    )

# across数据标准化
std <- function(x) {
    (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
}
penguins %>%
    mutate(
        across(c(bill_depth_mm, bill_length_mm), std)
    )

# using across() and purr style
penguins %>%
    summarise(
        across(starts_with("bill_"), ~ (.x - mean(.x)) / sd(.x))
    )

# 多列多个统计函数
penguins %>%
    group_by(species) %>%
    summarise(
        across(ends_with("_mm"),list(mean = mean, sd = sd),na.rm = TRUE)
    )