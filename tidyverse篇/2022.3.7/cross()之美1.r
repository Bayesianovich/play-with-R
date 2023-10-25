library(tidyverse)
library(palmerpenguins)
penguins

# 常规写法
penguins %>%
    summarise(
        na_in_species =  sum(is.na(species)),
        na_in_island = sum(is.na(island)),
        na_in_length  = sum(is.na(bill_length_mm)),
        na_in_depth   = sum(is.na(bill_depth_mm)),
        na_in_flipper = sum(is.na(flipper_length_mm)),
        na_in_body    = sum(is.na(body_mass_g)),
        na_in_sex     = sum(is.na(sex)),
        na_in_year    = sum(is.na(year))
    )

#优化
penguins %>%
    summarise_all(
        ~ sum(is.na(.))
    )

penguins %>%
    group_by(species) %>%
    summarise(
        mean_length = mean(bill_length_mm, na.rm = TRUE),
        mean_depth    = mean(bill_depth_mm, na.rm = TRUE),
        mean_flipper  = mean(flipper_length_mm, na.rm = TRUE),
        mean_body     = mean(body_mass_g, na.rm = TRUE)
    )

# or 用summarise_if()偷懒
d1 <- penguins %>%
  group_by(species) %>%
  summarise_if(is.numeric, mean, na.rm = TRUE)
d1

d2 <- penguins %>%
  group_by(species) %>%
  summarise(
    n = n()
  )
d2

# 合并
d1 %>% left_join(d2, by = "species")

# across()横空出世
penguins %>%
  group_by(species) %>%
    summarise(
        across(where(is.numeric) & !year, mean, na.rm = TRUE),
        n = n()
    )


# using across()
penguins %>%
  summarise(
    across(everything(), function(x) sum(is.na(x)))
  )


# or 
penguins %>%
    summarise(
        across(everything(), ~ sum(is.na(.)))
    ) %>%
    pivot_longer( cols = everything())


# 
penguins %>%
  summarise(
    distinct_species = n_distinct(species),
    distinct_island  = n_distinct(island),
    distinct_sex     = n_distinct(sex)
  )

# using across()
penguins %>%
  summarise(
    across(c(species, island, sex), n_distinct)
  )

penguins %>%
  group_by(species) %>%
  summarise(
    length_mean  = mean(bill_length_mm, na.rm = TRUE),
    length_sd    = sd(bill_length_mm, na.rm = TRUE),
    depth_mean   = mean(bill_depth_mm, na.rm = TRUE),
    depth_sd     = sd(bill_depth_mm, na.rm = TRUE),
    flipper_mean = mean(flipper_length_mm, na.rm = TRUE),
    flipper_sd   = sd(flipper_length_mm, na.rm = TRUE),
    n            = n()
  )

#using across()
penguins %>%
    group_by(species) %>%
    summarise(
        across(ends_with("_mm"),list(mean = mean, sd =sd), na.rm = TRUE),
        n = n()
    )

# 不同分组下数据变量的多个分位数
# across() 与summarise()的强大结合
penguins %>%
  group_by(species) %>%
  summarise(
    prob = c(.25,.75),
    length = quantile(bill_length_mm, prob, na.rm = TRUE),
    depth  = quantile(bill_depth_mm, prob, na.rm = TRUE),
    flipper = quantile(flipper_length_mm, prob, na.rm = TRUE)   
  )
# using across()
penguins %>%
  group_by(species, island) %>%
  summarise(
    prob = c(.25, .75),
    across(
     c(bill_length_mm, bill_depth_mm, flipper_length_mm),
     ~ quantile(., prob, na.rm = TRUE)
    )
  )

# or 
penguins %>%
  group_by(species, island) %>%
  summarise(
    prob = c(.25,.75),
    across(where(is.numeric) & !year, ~ quantile(.,prob, na.rm = TRUE))
    )

# 不同分组下更复杂的统计
penguins %>%
  group_by(species) %>%
 summarise(
  n = n(),
  across(starts_with("bill_"), mean, na.rm = TRUE),
  Area = mean(bill_length_mm * bill_depth_mm, na.rm = TRUE),
  across(ends_with("_g"), mean, na.rm = TRUE)
 )

# 数据标准化处理
std <- function(x) {
  (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)

}

# using across()
penguins %>%
  summarise(
    across(where(is.numeric), std),
    across(where(is.character), as.factor)
  )

# using across() and purrr style
penguins %>%
  drop_na() %>%
  summarise(
    across(starts_with("bill_"), ~ (.x-mean(.x, na.rm = TRUE))/
     sd(.x, na.rm = TRUE))
  )

penguins %>%
  drop_na() %>%
  mutate(
    across(where(is.numeric), log),
    across(where(is.character), as.factor)
  )
