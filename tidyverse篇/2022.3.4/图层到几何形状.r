library(tidyverse)
library(palmerpenguins)
penguins  <- penguins %>% drop_na()

# stat_identity
penguins %>%
    ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
    layer(
        stat = "identity",
        geom = "point",
        params = list(na.rm = FALSE),
        position = "identity"
    )
#or
penguins %>% 
    ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
    stat_identity(
        geom = "point"
    )

#or
penguins %>%
    ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
    geom_point()

# stat_count
# Computed variables : count、prop
# 适用几何形状 geom_point() / geom_bar()
penguins %>% 
  ggplot(aes(x = species)) +
  layer(
    stat = "count",
    geom = "bar",
    mapping = aes(y = after_stat(count)),
    position = "identity"
  )


penguins %>% 
  ggplot(aes(x = species)) +
  layer(
    stat = "count",
    geom = "point",
    mapping = aes(y = after_stat(count)),
    position = "identity"
  )

penguins %>% 
  ggplot(aes(x = species, y = after_stat(count))) +
  stat_count(
    geom = "bar"
  )

penguins %>% 
  ggplot(aes(x = species, y = after_stat(count))) +
  geom_point(
    stat = "count"
  )

penguins %>% 
  ggplot(aes(x = species, y = bill_length_mm)) +
  geom_boxplot(
    aes(colour = species, 
        fill = after_scale(alpha(colour, 0.4)))
  )
