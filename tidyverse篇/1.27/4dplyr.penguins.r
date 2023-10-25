require(tidyverse)
library(palmerpenguins)

# ȥ��ȱʧֵ
penguins <- penguins %>% drop_na()
# ѡ��bill_����ʼ����
penguins %>% select(starts_with("bill_"))
# ѡ��_mm����β����
penguins %>% select(ends_with("_mm"))

# ѡ���С�length������
penguins %>% select(contains("length"))

# ѡ����ֵ�͵���
penguins %>% select(where(is.numeric))

# ѡ���ַ������͵���
penguins %>% select(where(is.character))

# ѡ���ַ��������������
penguins %>% select(!where(is.character))

# ѡ�����
penguins %>%
    select(species, starts_with("bill_"))
# ע�ⷵ�������������ݿ�
# ��������

my_tibble[["x"]]

my_tibble$x

my_tibble %>% pull(x)

# �������ݿ�
my_tibble["x"]

my_tibble %>% select(x)

# Ѱ�������
penguins %>% filter(sex == "male")

penguins %>% filter(species %in% c("Adelie", "Gentoo"))

penguins %>% filter(species == "Adelie" & bill_length_mm > 40)
# ѡһ��
penguins %>% slice(1)

penguins %>%
    group_by(species) %>%
    slice(1)

penguins %>%
    arrange(-bill_length_mm) %>%
    slice(1)

penguins %>%
    slice_max(bill_length_mm)

# �й�NA�ļ���
sum(c(1, 2, NA, 4))
# ��Ҫ����ɾ��
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
# �ÿ��Գɼ��ľ������ȱʧֵ
df %>%
    group_by(type) %>%
    mutate(mean_score = mean(score, na.rm = TRUE)) %>%
    mutate(newscore = ifelse(is.na(score), mean_score, score))

# �������ķ���
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

# ����case_when
penguins %>%
    mutate(
        degree = case_when(
            bill_length_mm < 35 ~ "A",
            bill_length_mm >= 35 & bill_length_mm < 45 ~ "B",
            bill_length_mm >= 45 & bill_length_mm < 55 ~ "C",
            TRUE ~ "D"
        )
    )

# n()����,ͳ�Ƶ�ǰ�������ݿ������
penguins %>%
    summarise(
        n()
    )

penguins %>%
    group_by(species) %>%
    summarise(
        n(),
    )
# ͳ��ĳ�������и�����ֵĴ���,����ʹ��count()����
penguins %>% count(species)
# ��ͬ�Ա������ж���
penguins %>%
    count(sex, sort = TRUE)

# count()�ﹹ���±���,����������±������ͳ�ơ�
penguins %>% count(longer_bill = bill_length_mm > 40)

# ǿ��ת�� character > numeric >logic
# double > integer

penguins %>%
    mutate(
        is_bigger40 = bill_length_mm > 40
    ) %>%
    count(is_bigger40)
# across ֮�� ���ֵ
penguins %>%
    summarise(
        across(c(bill_depth_mm, bill_length_mm), mean)
    )

# ���ֵ
penguins %>%
    summarise(
        across(c(bill_depth_mm, bill_length_mm, flipper_length_mm), mean)
    )
# across �Զ���ִ����ͬ�ĺ�������,�������ݿ�
penguins %>%
    summarise(
        across(ends_with("_mm"), mean)
    )

# across �������Ļ�
penguins %>%
    mutate(
        bill_depth_mm = bill_length_mm - mean(bill_length_mm),
        bill_depth_mm = bill_depth_mm - mean(bill_depth_mm)
    )
# ��

centralized <- function(x) {
    x - mean(x)
}

penguins %>%
    mutate(
        across(c(bill_depth_mm, bill_length_mm), centralized)
    )

# across���ݱ�׼��
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

# ���ж��ͳ�ƺ���
penguins %>%
    group_by(species) %>%
    summarise(
        across(ends_with("_mm"),list(mean = mean, sd = sd),na.rm = TRUE)
    )