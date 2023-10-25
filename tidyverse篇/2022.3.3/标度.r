require(tidyverse)
mpg %>%
    ggplot(aes(x = displ, y = hwy)) +
    geom_point(aes(col = class))


# 事实上,根据映射关系和变量名,我们将标度写完整,应该是这样的
ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(aes(col = class)) +

    scale_x_continuous() +
    scale_y_continuous() +
    scale_color_discrete()

#每次都要手动设置一次标度函数,那将是比较繁琐的事。因此ggplot2使用了默认的设置,如果不满足ggplot2的默认值,可以手动调整或改变标度,比如
mpg %>% ggplot(aes(x = displ, y = hwy)) +
    geom_point(aes(col = class)) +
    scale_x_continuous(name = "This is my x  axis") +
    scale_y_continuous(name = "this is my y axis") +
    scale_color_brewer()

gapdata <- read_csv("gapminder.csv")
newgapdata <- gapdata %>% 
    group_by(continent, country) %>%
    summarise(
        across(c(lifeExp, gdpPercap, pop), mean)
    )
newgapdata


newgapdata %>%  
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point(aes(col = continent,, size = pop)) +
    scale_x_continuous() 

newgapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point(aes(col = continent, size = pop)) +
    scale_x_log10()

newgapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point(aes(col = continent, size = pop)) +
    scale_x_log10(breaks = c(500, 1000, 3000, 10000, 30000),
    labels = scales::dollar)

newgapdata %>% ggplot(aes(x = gdpPercap, y = lifeExp)) +
geom_point(aes(color = continent, size = pop)) +
scale_x_log10(
    name = "GDP per capita",
    breaks = c(500, 1000, 3000, 10000, 30000),
    labels = scales::unit_format(unit = "dollar")
)

newgapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point(aes(color = continent, size = pop)) +
    scale_x_log10() +
    scale_color_viridis_d()

#离散变量映射到色彩的情形，用scale_color_brewer()
newgapdata %>%
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point(aes(col = continent, size = pop)) +
    scale_x_log10() +
    scale_color_brewer(type = "qual", palette = "Set1")


newgapdata %>% 
    ggplot(aes(x = gdpPercap, y = lifeExp)) +
    geom_point(aes(col = continent, size = pop)) +
    scale_x_log10() +
    scale_color_manual(
        name = "continents",
        values = c("Africa" = "red", "Americas" = "blue",
        "Asia" = "orange", "Europe" = "black", "Oceania" = "green"),
        breaks = c( "Africa", "Americas", "Asia", "Europe", "Oceania"),
        labels = c("Africa", "Americas", "Asia", "Europe", "Oceania")
    ) +
    scale_size(
        name = "population size",
        breaks = c(2e8, 5e8, 7e8),
        labels = c("200 million", "500 million", "700 million")
    )


