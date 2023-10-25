require(tidyverse)

plant_height <- data.frame(
    Day = 1:5,
    A = c(0.7, 1.0, 1.5, 1.8, 2.2),
    B = c(0.5, 0.7, 0.9, 1.3, 1.8),
    C = c(0.3, 0.6, 1.0, 1.2, 2.2),
    D = c(0.4, 0.7, 1.2, 1.5, 3.2)
)
plant_height

# 变成长数据
long <- plant_height %>%
    pivot_longer(
        cols = -Day, # A:D
        names_to = "plant",
        values_to = "height"
    )
ggplot(long, aes(x = Day, y = height, color = plant)) +
    geom_line()

wide <- long %>%
    pivot_wider(
        names_from = "plant",
        values_from = "height"
    )
wide

# 列名转换成多个变量
plant_record <- data.frame(
    day = c(1L, 2L, 3L, 4L, 5L),
    A_height = c(1.1, 1.2, 1.3, 1.4, 1.5),
    A_width = c(2.1, 2.2, 2.3, 2.4, 2.5),
    A_depth = c(3.1, 3.2, 3.3, 3.4, 3.5),
    B_height = c(4.1, 4.2, 4.3, 4.4, 4.5),
    B_width = c(5.1, 5.2, 5.3, 5.4, 5.5),
    B_depth = c(6.1, 6.2, 6.3, 6.4, 6.5),
    C_height = c(7.1, 7.2, 7.3, 7.4, 7.5),
    C_width = c(8.1, 8.2, 8.3, 8.4, 8.5),
    C_depth = c(9.1, 9.2, 9.3, 9.4, 9.5)
)
plant_record %>%
    knitr::kable()

plant_record %>%
    tidyr::pivot_longer(
        cols = !day,
        names_to = c("plant","parameter"),
        names_pattern = "(.*)_(.*)",
        values_to = "value"
    )