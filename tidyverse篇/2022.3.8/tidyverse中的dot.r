library(tidyverse)
mtcars %>%
  select(cyl, disp, hp) %>%
  head(2)

mtcars %>%
  select(., cyl, disp, hp) %>%
  head(., 2)

mtcars %>%
  select_at(vars(contains("ar")), ~ toupper(.)) %>%
  head(3)

mtcars %>%
  select_at(vars(contains("ar")), toupper) %>%
  head(3)

# is equivalent to
c(1, 2, 3, NA) %>% mean(., na.rm = T)

iris %>% subset(1 : nrow(.) %% 30 == 0)

1:10 %>% {
  c(min(.), max(.))
}
# 当dplyr::mutate遇到purrr::map，情况就复杂很多了。然而，这种情况，tidyverse比比皆是

iris %>%
  head(3) %>%
  mutate(., r_sum = pmap_dbl(select_if(., is.numeric), sum))

df <- tibble(
  mean = c(1, 2),
  sd = c(2, 4)
)
df

df %>%
  dplyr::mutate(., rand = map(mean, ~ rnorm(5, .))) %>%
  tidyr::unnest_wider(rand)

df %>%
  dplyr::mutate(rand = map2(mean, sd, ~ rnorm(5, .x, .y))) %>%
  tidyr::unnest_wider(rand)

df <- tribble(
  ~a, ~b,
  1, 10,
  2, 11
)


df %>%
  dplyr::mutate(., sum = purrr::pmap_dbl(., ~ sum(...)))

commas <- function(...) {
  stringr::str_c(..., collapse = ", ")
}


commas(letters[1:10])
