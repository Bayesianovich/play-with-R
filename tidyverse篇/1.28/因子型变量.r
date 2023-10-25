require(tidyverse)
library(palmerpenguins)
income <- c("low", "medium", "high", "low", "medium", "high", "high")
factor(income)
# ���Ӳ㼶���Զ������ַ�������ĸ˳�����򣬱���high low medium��Ҳ����ָ��˳��
factor(income, levels = c("medium", "low", "high"))
# ���������Ӳ㼶�е�ֵ, �����������Ӳ�ֻ��c("low", "high")����ôincome�еġ�medium���ᱻ����ȱʡֵNA
factor(income, levels = c("low", "high"))

# Ӧ��
d <- tibble(
    x = c("a","a", "b", "b", "c", "c"),
    y = c(2, 2, 1, 5,  0, 3)
)
d
d %>%
ggplot(aes(x = x, y = y)) +
geom_point() 

#fct_reorder()������x��˳����x��ÿ�����������Ӧyֵ����λ����������,����Ϊ:
d %>%
    ggplot(aes(x = fct_reorder(x, y, .fun = median), y = y)) +
    geom_point()

# Ҳ���Լ�һ������ .desc = TRUE�����Ӳ㼶��Ϊ��������
d %>%
    ggplot(aes(x = fct_reorder(x, y, .fun = median, .desc = TRUE), y = y)) +
    geom_point()
# ���������x�����ǩһ�󴮣���˽������дmutate()������
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