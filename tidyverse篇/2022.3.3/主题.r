library(tidyverse)
glimpse(mpg)

mpg$class
# 做点数据整理
df <- mpg %>%
    as_tibble() %>%
    filter(class != "2seater", manufacturer %in% c("toyota", "volkswagen"))
df

# 画图
df %>%
    ggplot(aes(x = displ, y = hwy, color = factor(cyl))) +
    geom_point() +
    facet_grid(vars(manufacturer), vars(class)) +
    ggtitle("This is my title") +
    labs(x = "x_displ", y = "y_hwy")

df %>%
    ggplot(aes(x = displ, y = hwy, color = factor(cyl))) +
    geom_point() +
    facet_grid(vars(manufacturer), vars(class)) +
    ggtitle("This is my title") +
    labs(x = "x_displ", y = "y_hwy") +
theme(legend.position = "bottom") +
theme( 
        plot.background = element_rect(fill = "cyan",size = 10),
        plot.title = element_text(hjust = 1, color = "red", face = "italic"),
        plot.margin = margin(t = 20, r = 20, b = 20, l = 20, unit = "pt")
        )
        
df %>%
    ggplot(aes(x = displ, y = hwy, color = factor(cyl))) +
    geom_point() +
    facet_grid(vars(manufacturer), vars(class)) +
    ggtitle("This is my title") +
    labs(x = "x_displ", y = "y_hwy") +
    theme(
        axis.line = element_line(color = "red", size = 2),
        axis.title = element_text(color = "cyan", face = "italic"),
        axis.ticks = element_line(color = "pink", size = 3),
        axis.text = element_text(color = "#43177c"),
        axis.text.x = element_text(angle = 45, hjust = 1)
     )

df %>%
    ggplot(aes(x = displ, y = hwy, color = factor(cyl))) +
    geom_point() +
    facet_grid(vars(manufacturer), vars(class)) +
    ggtitle("This is my title") +
    labs(x = "x_displ", y = "y_hwy") +
    theme(
      panel.background = element_rect(fill = "cyan", color = "yellow"),
      panel.grid = element_line(color = "red", size = 0.6)
     ) 

df %>% 
    ggplot(aes(x = displ, y = hwy, color = factor(cyl))) +
    geom_point() +
    facet_grid(vars(manufacturer), vars(class)) +
    ggtitle("This is my title") +
    labs(x = "x_displ", y = "y_hwy") +
    theme(
        legend.background = element_rect(fill = "cyan"),
        legend.key = element_rect(fill = "yellow"),
        legend.text = element_text(color = "red"),
        legend.title = element_text(color = "red", size = 2),
        legend.margin = margin( t = 20, r = 20, b = 20, l = 20, unit = "pt"),
        legend.position = "bottom"
    )

df %>% 
    ggplot(aes(x = displ, y = hwy, color = factor(cyl))) +
    geom_point() +
    facet_grid(vars(manufacturer), vars(class)) +
    ggtitle("This is my title") +
    labs(x = "x_displ", y = "y_hwy") +
    theme(
      strip.background = element_rect(fill = "cyan"),
      strip.text = element_text(color = "red"),
      panel.spacing = unit(0.5, "inch")
      # strip.switch.pad.grip =
    ) 

library(palmerpenguins)
penguins %>%
  ggplot(aes(bill_length_mm, bill_depth_mm)) +
  geom_point() +
  theme(
    axis.line.y = element_line(
      color = "black",
      size = 1.2,
      arrow = grid::arrow()
    ),
    axis.line.x = element_line(
      linetype = "dashed",
      color = "brown",
      size = 1.2
    ),
    axis.ticks = element_line(color = "red", size = 1.1),
    axis.ticks.length = unit(3, "mm"),
    panel.grid.major = element_line(
      color = "blue",
      size = 1.2
    ),
    panel.grid.minor = element_line(
      color = "#58508d",
      size = 1.2,
      linetype = "dotted"
    )
  )

  penguins %>%
  ggplot(aes(bill_length_mm, bill_depth_mm)) +
  geom_point(aes(color = species)) +
  theme(
    legend.background = element_rect(
      fill = "#fff6c2",
      color = "black",
      linetype = "dashed"
    ),
    legend.key = element_rect(fill = "grey", color = "brown"),
    panel.background = element_rect(
      fill = "#005F59",
      color = "red", size = 3
    ),
    panel.border = element_rect(
      color = "black",
      fill = "transparent",
      linetype = "dashed", size = 3
    ),
    plot.background = element_rect(
      fill = "#a1dce9",
      color = "black",
      size = 1.3
    ),
    legend.position = "bottom"
  )

library(ggthemes)
penguins %>% 
    ggplot(aes(x = bill_depth_mm, y = bill_length_mm)) +
    geom_point() +
    ggthemes::theme_economist()

gapdata <- read_csv("gapminder.csv")

gapdata %>%
    ggplot(aes(y = lifeExp, x = gdpPercap, col = continent)) +
    geom_point() +
    geom_smooth(lwd = 2, se = FALSE, method = "lm") +
    scale_x_log10() +
    theme_bw()

gapdata %>%
    ggplot(aes(y = lifeExp, x = gdpPercap, col = continent)) +
    geom_point() +
    geom_smooth(lwd = 2, se = FALSE, method = "lm") +
    theme_grey()#  the default


gapdata %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  geom_smooth(lwd = 3, se = FALSE, method = "lm") +
  ggthemes::theme_economist() +
  ggtitle("ggthemes::theme_economist()")

gapdata %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  geom_smooth(lwd = 3, se = FALSE, method = "lm") +
  ggthemes::theme_few() +
  ggtitle("ggthemes::theme_few()")


gapdata %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  geom_smooth(lwd = 3, se = FALSE, method = "lm") +
  ggthemes::theme_gdocs() +
  ggtitle("ggthemes::theme_gdocs()")

gapdata %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  geom_smooth(lwd = 3, se = FALSE, method = "lm") +
  ggthemes::theme_wsj() +
  ggtitle("ggthemes::theme_wsj()")
