library(tidyverse)
library(palmerpenguins)

penguins %>% 
    drop_na() %>%
    ggplot(aes(x = bill_length_mm)) +
    geom_histogram(aes(y = after_stat(count)))

# SCale tallest bin to 1
penguins %>% 
    ggplot(aes(x = bill_length_mm)) +
    geom_histogram(aes(y = after_stat(count) / max(count)))

penguins %>% 
  ggplot(aes(x = species, color = species)) +
  geom_bar(
    aes(fill = after_scale(alpha(color, 0.6)))
  )

penguins %>% 
  ggplot(aes(x = species)) +
  geom_bar(
    aes(fill = stage(start = species, after_scale = alpha(fill, 0.6)))
  )
