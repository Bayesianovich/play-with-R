require(tidyverse)
library(palmerpenguins)
income <- c("low", "medium", "high", "low", "medium", "high", "high")
factor(income)
# 因子层级会自动按照字符串的字母顺序排序，比如high low medium。也可以指定顺序，
factor(income, levels = c("medium", "low", "high"))
# 不属于因子层级中的值, 比如这里因子层只有c("low", "high")，那么income中的”medium”会被当作缺省值NA
factor(income, levels = c("low", "high"))

# 应用
d <- tibble(
    x = c("a","a", "b", "b", "c", "c"),
    y = c(2, 2, 1, 5,  0, 3)
)
d
d %>%
ggplot(aes(x = x, y = y)) +
geom_point() 

#fct_reorder()可以让x的顺序按照x中每个分类变量对应y值的中位数升序排序,具体为:
d %>%
    ggplot(aes(x = fct_reorder(x, y, .fun = median), y = y)) +
    geom_point()

# 也可以加一个参数 .desc = TRUE让因子层级变为降序排列
d %>%
    ggplot(aes(x = fct_reorder(x, y, .fun = median, .desc = TRUE), y = y)) +
    geom_point()
# 这样会造成x坐标标签一大串，因此建议可以写mutate()函数里
d %>%
    mutate(x = fct_reorder(x, y, .fun = median, .desc = TRUE)) %>%
    ggplot(aes(x = x, y = y)) +
    geom_point() 

ggplot(penguins, aes(y = species)) +
  geom_bar()


ggplot(penguins, aes(y = fct_rev(species))) +
  geom_bar()


penguins %>% 
  count(species) %>% 
  pull(species)

penguins %>% 
  count(species) %>% 
  mutate(species = fct_relevel(species, "Chinstrap", "Gentoo", "Adelie")) %>% 
  pull(species)

# Move "Chinstrap" in front, rest alphabetic
ggplot(penguins, aes(y = fct_relevel(species, "Chinstrap"))) +
  geom_bar()

# Use order "Chinstrap", "Gentoo", "Adelie"
ggplot(penguins, aes(y = fct_relevel(species,
 "Chinstrap", "Gentoo", "Adelie"))) +
  geom_bar()

penguins %>%
  mutate(species = fct_relevel(species, "Chinstrap", "Gentoo", "Adelie")) %>%
  ggplot(aes(y = species)) +
  geom_bar()

ggplot(penguins, aes(y = fct_relevel(species, "Adelie", after = Inf))) +
  geom_bar()

penguins %>%
  mutate(species = fct_infreq(species)) %>%
  ggplot(aes(y = species)) +
  geom_bar()

penguins %>%
  mutate(species = fct_rev(fct_infreq(species))) %>%
  ggplot(aes(y = species)) + 
  geom_bar()

# Reorder based on numeric values
penguins %>%
  count(species) %>%
  mutate(species = fct_reorder(species, n)) %>%
  ggplot(aes(n, species)) + 
  geom_col()

# homework
library(gapminder)
gapminder %>%
   filter(
     year == 2007,
     continent == "Americas"
)
gapminder %>%
  filter(country %in% c("Norway", "Portugal", "Spain", "Austria")) %>%
  ggplot(aes(year, lifeExp)) + geom_line() +
  facet_wrap(vars(country), nrow = 1)