require(tidyverse)
mpg %>%
    ggplot(aes(x = displ, y = hwy)) +
    geom_point(aes(col = class))


# ��ʵ��,����ӳ���ϵ�ͱ�����,���ǽ����д����,Ӧ����������
ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(aes(col = class)) +

    scale_x_continuous() +
    scale_y_continuous() +
    scale_color_discrete()

#ÿ�ζ�Ҫ�ֶ�����һ�α�Ⱥ���,�ǽ��ǱȽϷ������¡����ggplot2ʹ����Ĭ�ϵ�����,���������ggplot2��Ĭ��ֵ,�����ֶ�������ı���,����
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

#��ɢ����ӳ�䵽ɫ�ʵ����Σ���scale_color_brewer()
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


