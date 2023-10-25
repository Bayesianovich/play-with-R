library(tidyverse)
library(gghighlight)
library(cowplot)
library(patchwork)
library(ggforce)
library(ggridges)


p1 <- mpg %>%
    ggplot(aes(x = cty, y = hwy)) +
    geom_point() +
    geom_smooth() +
    labs(title = "1：geom_point() + geom_smooth()") +
    theme(plot.title = element_text(face = "bold"))

p2 <- ggplot(mpg, aes(x = cty, y = hwy)) +
    geom_hex() +
    labs(title = "2：geom_hex()") +
    guides(fill = FALSE) +
    theme(plot.title = element_text(face = "bold"))

p3 <- ggplot(mpg, aes(x = drv, fill = drv)) +
    geom_bar() +
    labs(title = "3：geom_bar()") +
    guides(fill = FALSE) +
    theme(plot.title = element_text(face = "bold"))

p4 <- ggplot(mpg, aes(x = cty)) +
    geom_histogram(binwidth = 2, col = "white") +
    labs(title = "4：geom_histogram()") +
    theme(plot.title = element_text(face = "bold"))
p5 <- ggplot(mpg, aes(x = cty, y = drv, fill = drv)) +
    geom_violin() +
    guides(fill = FALSE) +
    labs(title = "5: geom_violin()") +
    theme(plot.title = element_text(face = "bold"))
p5
p6 <- ggplot(mpg, aes(x = cty, y = drv, fill = drv)) +
    geom_boxplot() +
    guides(fill = FALSE) +
    labs(title = "6: geom_boxplot()") +
    theme(plot.title = element_text(face = "bold"))

p7 <- ggplot(mpg, aes(x = cty, fill = drv)) +
    geom_density(alpha = 0.7) +
    guides(fill = FALSE) +
    labs(title = "7: geom_density()") +
    theme(plot.title = element_text(face = "bold"))

p8 <- ggplot(mpg, aes(x = cty, y = drv, fill = drv)) +
    geom_density_ridges() +
    guides(fill = FALSE) +
    labs(title = "8: ggridges::geom_density_ridges()") +
    theme(plot.title = element_text(face = "bold"))

p9 <- ggplot(mpg, aes(x = cty, y = hwy)) +
    geom_density_2d() +
    labs(title = "9: geom_density_2d()") +
    theme(plot.title = element_text(face = "bold"))

p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9 +
    plot_layout(nrow = 3) # 将图形放在一个3行3列的布局中


# 定制标签

gapdata <- read_csv("gapminder.csv")
gapdata

gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
    geom_point() +
    scale_x_log10() +
    ggtitle("My Plot Title") +
    xlab("The X Variable") +
    ylab("The Y Variable")
# or
ggplot(gapdata, aes(x = gdpPercap, y = lifeExp, color = continent)) +
    geom_point() +
    scale_x_log10() +
    labs(
        title = "My Plot Title",
        subtitle = "My Plot Subtitle",
        x = "The X Variable",
        y = "The Y Variable"
    )

# 定制颜色作者喜欢使用 scale_color_manual() 和 scale_fill_manual()。
gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
    geom_point() +
    scale_x_log10() +
    scale_color_manual(
        values = c("#195744", "#008148", "#C6C013", "#EF8A17", "#EF2917")
    )

# 组合图片
# 使用cowplot宏包的plot_grid()函数完成多张图片的组合, 可以使用plot_layout()函数完成布局。
p1 <- gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point(aes(color = lifeExp > mean(lifeExp))) +
    scale_x_log10() +
    scale_color_manual(values = c("cyan", "#C6C013")) +
    theme(legend.position = "none") +
    labs(
        title = "My Plot Title",
        x = "The X Variable",
        y = "The Y Variable"
    )

p2 <- gapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
    geom_point() +
    scale_x_log10() +
    scale_color_manual(
        values = c("#195744", "#008148", "#C6C013", "#EF8A17", "#EF2917")
    ) +
    theme(legend.position = "none") +
    labs(
        title = "My Plot Title",
        x = "The X Variable",
        y = "The Y Variable"
    )
cowplot::plot_grid(p1, p2, labels = c("A", "B"))

p1 / p2

p1 + p2 +
    plot_annotation(
        tag_levels = "A",
        title = "Thesurprising truth about mtcars",
        subtitle = "These 3 plots will reveal
        yet-untold secrets about our beloved data-set",
        caption = "Disclaimer: None of these plots are insightful"
    )


library(palmerpenguins)

g1 <- penguins %>%
    ggplot(aes(bill_length_mm, body_mass_g, color = species)) +
    geom_point() +
    theme_grey(base_size = 14) +
    labs(tag = "(A)", x = "Bill length (mm)", 
    y = "Body mass (g)", color = "Species")

g2 <- penguins %>%
    ggplot(aes(bill_length_mm, bill_depth_mm, color = species)) +
    geom_point() +
    theme_bw(base_size = 14) +
    labs(tag = "(B)", x = "Bill length (mm)", 
    y = "Bill depth (mm)", color = "Species")

g1 + g2 + patchwork::plot_layout(nrow = 1)

g1 + g2 + patchwork::plot_layout(guides = "collect")# 只有一个图例 



#高亮某一组
# ggplot2 将背景部分和高亮部分分两步来画
drop_facet <- function(x) select(x, -continent)

gapdata %>% 
    ggplot() +
    geom_line(
        data = drop_facet,
        aes(x = year, y = lifeExp, group = country), color = "grey",) +
        facet_wrap(vars(continent)) +
        guides(fill = FALSE)

#or
gapdata %>% 
    ggplot() +
    geom_line(
        data = drop_facet,
        aes(x = year, y = lifeExp, group = country), color = "grey") +
        facet_wrap(vars(continent)) +
        theme(legend.position = "none")
# 将高亮部分加入
gapdata %>% 
    ggplot() +
    geom_line(
        data = drop_facet,
        aes(x = year, y = lifeExp, group = country), color = "grey") +
    geom_line(aes(x = year, y = lifeExp, color = country, group = country)) +
        facet_wrap(vars(continent)) +
        theme(legend.position = "none")

gapdata %>%
  mutate(group = country) %>%
  filter(continent == "Asia") %>%
  ggplot() +
  geom_line(aes(x = year, y = lifeExp, group = country), color = "red") +
  facet_wrap(vars(country)) +
  theme(legend.position = "none")

# 加入背景
gapdata %>%
  mutate(group = country) %>%
  filter(continent == "Asia") %>%
  ggplot() +
  geom_line(
    data = function(d) select(d, -country),
    aes(x = year, y = lifeExp, group = group), color = "grey",
  ) +
  geom_line(aes(x = year, y = lifeExp, group = country), color = "red") +
  facet_wrap(vars(country)) +
  theme(legend.position = "none")

  # gghighlight方法
  # dplyr has filter() 
  #ggplot has highlighting

gapdata %>% filter(country == "China")

gapdata %>%
    ggplot(
    aes(x = year, y = lifeExp, color = continent, group = country))  +
    geom_line() +
    gghighlight(
        country == "China",
        label_key = country
    )

gapdata %>% filter(continent == "Asia")

gapdata %>%
  filter(continent == "Asia") %>%
  ggplot(aes(year, lifeExp, color = country, group = country)) +
  geom_line(size = 1.2, alpha = .9, color = "#E58C23") +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank()
  ) +
  gghighlight(
    country %in% c("China", "India", "Japan", "Korea, Rep."),
    use_group_by = FALSE,
    use_direct_label = FALSE,
    unhighlighted_params = list(color = "grey90")
  ) +
  facet_wrap(vars(country))

library(geomtextpath) # remotes::install_github("AllanCameron/geomtextpath")

iris %>% 
    ggplot(aes(x = Sepal.Length, colour = Species, label = Species)) +
    geom_textdensity(size = 3, fontface = 2, hjust = 0.2, vjust = 0.3) +
    theme(legend.position = "none")

library(palmerpenguins)
penguins %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(alpha = 0.3) +
  geom_labelsmooth(aes(label = species), 
  method = "loess", size = 5, linewidth = 1) +
  scale_colour_manual(values = c("forestgreen", "deepskyblue4", "tomato4")) +
  theme(legend.position = "none")

# 函数图
tibble(x = seq(from = -3, to = 3, by = .01)) %>%
    mutate(y =dnorm(x, mean = 0, sd = 1)) %>%
    ggplot(aes(x, y)) +
    geom_line(color = "forestgreen") 

data <- data.frame(x = c(-3, 3))
data %>%
    ggplot(aes(x = x, col = "tomato4")) +
    stat_function(fun = dnorm) +
    theme(legend.position = "none")
 
# 自定义函数
myfun <- function(x) (x -1)^2
ggplot(data =data.frame(x = c(-1, 3)), aes(x = x)) +
stat_function(fun = myfun,geom = "line", color = "red") 

d <- tibble(x = rnorm(2000, mean = 2, sd = 4))
ggplot(d, aes(x = x)) +
    geom_histogram(aes(y = after_stat(density))) +
    geom_density() +
    stat_function(fun = dnorm, args = list(mean = 2, sd = 4), color = "red")
