library(tidyverse)
library(palmerpenguins)

penguins <- penguins %>% drop_na()

penguins %>% 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()

data.frame(
    x = rnorm(100),
    y = rnorm(100)
) %>% 
    ggplot(aes(x, y)) +
    geom_point() +
    geom_label(
        data = function(d) d %>% summarize(cor = cor(x, y)),
        aes(x = 1, y = 1.5, label = paste0("cor:", signif(cor, 3)))

    )

penguins %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(fill = body_mass_g), shape = 21) +
  scale_fill_gradient(
    low = "red", high = "green", na.value = "grey",
    limits = c(4000, NA),
    oob = scales::censor # 把超出界限的值替换成NA
  )

penguins %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(fill = body_mass_g), shape = 21) +
  scale_fill_gradient(
    low = "red", high = "green", na.value = "grey",
    limits = c(4000, NA),
    oob = scales::squish # 用于将越界值挤压到范围内
  )

df <- data.frame(x = 1:10, y = (1:10)^2)
df %>%
    ggplot(aes(x = x, y = y)) +
    geom_point() +
    stat_function(fun = ~.x^2)

logistic <- function(x) exp(1)^x / (1 + exp(1)^x)
ggplot() +
    xlim(-5, 5) +
    geom_function(fun = logistic, color = "orange") +
    theme_minimal()
