library(tidyverse)
df <- read_csv("datasaurus.csv")
df

df %>%
    group_by(dataset) %>%
    summarise(
        across(everything(),list(mean =mean,sd =sd),.names ="{fn}_{col}")) %>%
    mutate(
        across(is.numeric, round, 3)
    )

# 导入数据
gapdata <- read.csv("gapminder.csv", header=TRUE)
gapdata


#是否有缺失值
gapdata %>% 
    summarise(
        across(everything(),~sum(is.na(.)))
    )


# 基本绘图
gapdata %>%
    ggplot(aes(x = continent)) +
    geom_bar()

gapdata %>%
    ggplot(aes(x = reorder(continent, continent, length))) +
    geom_bar()

gapdata %>%
    ggplot(aes(x = reorder(continent, continent, length))) +
    geom_bar() +
    coord_flip()

# geom_bar vs stat_count
gapdata %>%
  ggplot(aes(x = continent)) +
  stat_count()

gapdata %>% count(continent)

gapdata %>%
    ggplot(aes(x = lifeExp)) +
    geom_histogram()

gapdata %>%
    ggplot(aes(x = lifeExp)) +
    geom_histogram(binwidth = 1)

# geom_histogram(),默认使用position ="stack"
gapdata %>%
    ggplot(aes(x = lifeExp, fill = continent)) +
    geom_histogram() 
# 也可以指定 position = "identity"
gapdata %>%
  ggplot(aes(x = lifeExp, fill = continent)) +
  geom_histogram(position = "identity")

# 频次图
gapdata %>%
    ggplot(aes(x = lifeExp, color = continent)) +
    geom_freqpoly()

# 密度图
gapdata %>%
    ggplot(aes(x = lifeExp)) +
    geom_density()


gapdata %>%
    ggplot(aes(x = lifeExp)) +
    geom_line(stat = "density")

#geom_density() 中adjust 用于调节bandwidth, 
#adjust = 1/2 means use half of the default bandwidth.
gapdata %>%
  ggplot(aes(x = lifeExp)) +
  geom_density(adjust = 10)

gapdata %>%
  ggplot(aes(x = lifeExp)) +
  geom_density(adjust = 0.1)

gapdata %>%
  ggplot(aes(x = lifeExp, color = continent)) +
  geom_density()

gapdata %>%
    ggplot(aes(x = lifeExp, fill = continent)) +
    geom_density(alpha = 0.2)

gapdata %>%
    filter(continent != "Oceania") %>%
    ggplot(aes(x = lifeExp, fill = continent)) +
    geom_density(alpha = 0.2)

gapdata %>%
    filter(continent != "Oceania") %>%
    ggplot(aes(x = lifeExp, y = stat(density))) +
    geom_histogram(aes(fill = continent)) +
    geom_density()

# 箱线图
gapdata %>%
    ggplot(aes(x = lifeExp, fill = continent)) +
    geom_boxplot() +
    coord_flip()

#一个离散变量 + 一个连续变量，思考下结果为什么是这样？
gapdata %>%
    ggplot(aes(x = year, y = lifeExp)) +
    geom_boxplot()
# 数据框中的year变量是数值型，需要先转换成因子型，弄成离散型变量
gapdata %>%
    ggplot(aes(x = as.factor(year), y = lifeExp)) +
    geom_boxplot()

gapdata %>%
  ggplot(aes(x = year, y = lifeExp)) +
  geom_violin(aes(group = year)) +
  geom_jitter(alpha = 1 / 4) +
  geom_smooth(se = FALSE)

#抖散图 点重叠的处理方案
gapdata %>%
    ggplot(aes(x = continent, y = lifeExp)) +
    geom_point()

gapdata %>%
    ggplot(aes(x = continent, y = lifeExp)) +
    geom_jitter()

gapdata %>%
    ggplot(aes(x = continent, y = lifeExp)) +
    geom_boxplot()

gapdata %>%
    ggplot(aes(x = continent, y = lifeExp)) +
    geom_boxplot() +
    geom_jitter()

gapdata %>%
    ggplot(aes(x = continent, y = lifeExp)) +
    geom_jitter() +
    stat_summary(fun.y = median, colour = "red", geom = "point", size = 5)

# 山峦图 常用于一个离散变量 + 一个连续变量
gapdata %>%
    ggplot(aes(x = lifeExp, y = continent, fill = continent)) +
    ggridges::geom_density_ridges()

gapdata %>%
    ggplot(aes(x = lifeExp, y = continent, fill = continent)) +
    ggridges::geom_density_ridges() +
    scale_fill_manual(
        values = c("red", "blue", "green",
      "yellow", "orange", "brown", "pink", "purple", "gray", "black")
    )

gapdata %>%
    ggplot(aes(x = lifeExp, y = continent, fill = continent)) +
    ggridges::geom_density_ridges() +
    scale_fill_manual()

gapdata %>%
    ggplot(aes(x = lifeExp, y = continent, fill = continent)) +
    ggridges::geom_density_ridges() +
    scale_fill_manual(
        values = colorspace::sequential_hcl(5, palette = "Peach")

    )

# 散点图 常用于两个连续变量
gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point()

gapdata %>%
    ggplot(aes(x = log(gdpPercap), y = lifeExp)) +
    geom_point()

#等价于
gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point() +
    scale_x_log10() #A better way to do log transform

gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point(aes(color = continent))

gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point(alpha = (1 / 3), size = 5)

gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point() +
    geom_smooth()

gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point() +
    geom_smooth(lwd = 3, se = FALSE)

gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point() +
    geom_smooth(lwd = 3, se = FALSE, method = "lm") 

gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
    geom_point() +
    geom_smooth(lwd = 3, se = FALSE, method = "lm")


jCountries <- c("Canada", "Rwanda", "Cambodia", "Mexico")
gapdata %>%
    filter(country %in% jCountries) %>%
    ggplot(aes(x = year, y = lifeExp, color = country)) +
    geom_line() +
    geom_point()

gapdata %>%
    filter(country %in% jCountries) %>%
    ggplot(aes(
        x = year, y = lifeExp, color = reorder(country, -1 * lifeExp, max)
    )) +
    geom_line() +
    geom_point()

# 更推荐以下方法
d1 <- gapdata %>%
    filter(country %in% jCountries) %>%
    group_by(country) %>%
    mutate(end_label = if_else(year == max(year), country, NA_character_))
d1
d1 %>% ggplot(aes(x = year, y = lifeExp, color = country)) +
    geom_line() +
    geom_point() +
    geom_label(aes(label = end_label)) +
    theme(legend.position = "none")

## 觉得方法麻烦，就用gghighlight宏包
gapdata %>%
    filter(country %in% jCountries) %>%
    ggplot(aes(
        x = year, y = lifeExp, color = country
    )) +
    geom_line() +
    geom_point() +
    gghighlight::gghighlight()

# 点线图
gapdata %>%
    filter(continent == "Asia" & year == 2007) %>%
    ggplot(aes(x = lifeExp, y = country)) +
    geom_point()

# 分面
gapdata %>%
    filter(continent == "Asia") %>%
    ggplot(aes(x = lifeExp))+
    geom_density()

gapdata %>%
    filter(continent == "Americas") %>%
    ggplot(aes(x = lifeExp)) +
    geom_density()

gapdata %>%
    filter(continent == "Europe") %>%
    ggplot(aes(x = lifeExp)) +
    geom_density()

gapdata %>%
    filter(continent == "Africa") %>%
    ggplot(aes(x = lifeExp)) +
    geom_density()

# ggplot2的分面，可以很快捷的完成，
# 分面有两个 - facet_grid()和-facet_wrap()

gapdata %>%
    filter(continent != "Oceania") %>%
    ggplot(aes(x = lifeExp, fill = continent)) +
    geom_histogram() +
    facet_wrap(continent~.)

gapdata %>%
    filter(continent != "Oceania") %>%
    ggplot(aes(x = lifeExp, y = stat(density),fill = continent)) +
    geom_histogram() +
    geom_density() +
    facet_grid(continent~.)

gapdata %>%
    filter(continent != "Oceania") %>%
    ggplot(aes(x = lifeExp, y = stat(density))) +
    geom_histogram(aes(fill = continent)) +
    geom_density() +
    facet_grid(vars(continent))


gapdata %>%
    filter(continent != "Oceania") %>%
    ggplot(aes(x = lifeExp, y = stat(density))) +
    geom_histogram(aes(fill = continent)) +
    geom_density() +
    facet_grid(.~continent)

# facet_wrap()

gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
    geom_point() +
    facet_wrap(vars(continent))

gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
    geom_point(show.legend = FALSE) +
    facet_wrap(vars(continent))

# 文本标准
gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point() +
    ggforce::geom_mark_ellipse(aes(
        filter = gdpPercap > 70000,
        label = "Rich country",
        description = "What country are they?"
    ))

ten_countries <- gapdata %>%
  distinct(country) %>% #distinct()用于对输入的tbl进行去重 ,返回无重复的行
  pull() %>%
  sample(10)

library(ggrepel)
gapdata %>%
  filter(year == 2007) %>%
  mutate(
    label = ifelse(country %in% ten_countries, as.character(country), "")
  ) %>%
  ggplot(aes(log(gdpPercap), lifeExp)) +
  geom_point(
    size = 3.5,
    alpha = .9,
    shape = 21,
    col = "red",
    fill = "green"
  ) +
  geom_text_repel(
    aes(label = label),
    size = 4.5,
    point.padding = .2,
    box.padding = .3,
    force = 1,
    min.segment.length = 0
  ) +
  theme_minimal(14) +
  theme(
    legend.position = "none",
    panel.grid.minor = element_blank()
  ) +
  labs(
    x = "log(GDP per capita)",
    y = "life expectancy"
  )

tbl <-
  tibble(
    x = rep(c(1, 2, 3), times = 2),
    y = 1:6,
    group = rep(c("group1", "group2"), each = 3)
  )
tbl

tbl %>%
    ggplot(aes(x, y, color = group)) +
    geom_line() 

tbl %>%
    ggplot(aes(x, y, group = group)) +
    geom_line()
tbl %>%
    ggplot(aes(x, y)) +
    geom_line()

