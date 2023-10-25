library(tidyverse)
penguins <- read_csv("penguins.csv")
penguins

# save
penguins %>% write_csv("newdata.csv")

as.tibble(penguins)

as.data.frame(penguins) %>% head(10)

glimpse(penguins)

penguins %>% ggplot(aes(x = sex, y = body_mass_g)) +
    geom_point()

penguins %>% ggplot(aes(x = sex, y = body_mass_g)) +
    geom_boxplot()

penguins %>% ggplot(aes(x = sex, y = body_mass_g)) +
    geom_boxplot(aes(fill = species))


#每种类型的企鹅，数据中有多少是NA呢？ 上dplyr吧！

select(penguins, species, sex, body_mass_g)

# or 
penguins %>% 
    select(species, sex, body_mass_g)

# 按行方向排序
penguins %>% 
    select(species, sex, body_mass_g) %>% 
    arrange(desc(body_mass_g))

# 分组统计
penguins %>% 
    group_by(species, sex) %>%
    summarise(count = n())

penguins %>%
    group_by(species) %>%
    mutate(count_species = n()) %>%
    ungroup() %>%
    group_by(species, sex, count_species) %>%
    summarise(count = n()) %>%
    mutate(prop = count / count_species * 100)

# 筛选
penguins %>%
    group_by(species) %>%
    mutate(count_species = n()) %>%
    ungroup() %>%
    group_by(species, sex, count_species) %>%
    summarise(count = n()) %>%
    mutate(percentage = count / count_species * 100) %>%
    filter(species == "Chinstrap")
# 转换成因子型变量
penguins %>% 
    mutate(year_factor = factor(year, levels = unique(year)))

penguins_new <- penguins %>% 
    mutate(year_factor = factor(year))

class(penguins_new$year_factor)


penguins %>% 
    select(species, island) %>%
    mutate(ISLAND = str_to_upper(island))

penguins %>% 
    select(species,island) %>%
    mutate(ISLAND = str_to_upper(island)) %>%
    mutate(species_island = str_c(species, ISLAND, sep = "_"))

#长表格变宽表格
untidy_penguins <- penguins %>% 
    pivot_wider(names_from = sex,
                values_from = body_mass_g)
untidy_penguins

#宽表格变长表格
untidy_penguins %>%
    pivot_longer(cols = male: 'NA',
    names_to = "sex",
    values_to = "body_mass_g")


#map()
penguins %>% map(~sum(is.na(.)))
