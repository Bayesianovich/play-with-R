grouped_mean <- function(data, group_var, summary_var) {
  data %>%
    group_by({{group_var}}) %>%
    summarise(mean = mean({{summary_var}}))
}

grouped_mean(mtcars, cyl, mpg)


library(tidyverse)
library(rlang)
grouped_mean <- function(data, summary_var, ...) {
  summary_var <- enquo(summary_var) # nolint
    group_var <- enquos(...) # nolint
  data %>%
    group_by(!!!group_var) %>%
    summarise(mean = mean(!!summary_var))
}

grouped_mean(mtcars, disp, cyl, am)

rouped_mean <- function(data, summary_var, ...) {
  summary_var <- enquo(summary_var) # nolint

  data %>%
    group_by(...) %>%
    summarise(mean = mean(!!summary_var))
}

grouped_mean(mtcars, disp, cyl, am, vs)