library(ggplot2)

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
    geom_point() +
    geom_smooth(se = FALSE)

ggplot(mpg, aes(x = class)) +
    geom_bar()
((class_count <- dplyr::count(mpg, class)))

ggplot(class_count, aes(x = class, y = n)) +
    geom_bar(stat = "identity")


ggplot(mpg, aes(displ, hwy)) +
    geom_point(color = "grey") +
    stat_summary(
        fun = "mean",
        geom = "line", size = 1, linetype = "dashed"
    )

ggplot(mpg, aes(x = class, fill = drv)) +
    geom_bar()

ggplot(mpg, aes(x = class, fill = drv)) +
    geom_bar(position = "dodge")


ggplot(mpg, aes(x = cty, y = hwy)) +
    geom_point()

ggplot(mpg, aes(x = cty, y = hwy)) +
    geom_point() +
    scale_x_reverse() +
    scale_y_reverse()

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
    geom_point() +
    scale_color_brewer()

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
    geom_point() +
    scale_color_brewer(palette = "Set3")


ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
    geom_point() +
    scale_color_brewer(palette = "Set6")


ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point() +
    coord_cartesian(xlim = c(0, 5))

ggplot(mpg, aes(x = class)) +
    geom_bar() +
    coord_flip()

ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    facet_wrap(~class)

ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    facet_grid(year ~ cyl)