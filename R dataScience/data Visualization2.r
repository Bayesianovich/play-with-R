library(ggplot2)

ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_smooth()

ggplot(mpg, aes(x = class)) +
    geom_bar()

ggplot(mpg, aes(x = hwy)) +
    geom_histogram()


ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(color = "blue") +
    geom_smooth(color = "green")