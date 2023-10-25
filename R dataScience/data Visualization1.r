library(ggplot2)

mpg
ggplot(mpg, aes(x = displ, y = hwy, color = "#ffffff")) +
    geom_point()


ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(color = "red")