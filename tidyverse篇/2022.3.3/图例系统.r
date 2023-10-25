library(tidyverse)

mpg %>%
    ggplot(aes(x = displ, y = hwy, color = factor(cyl))) +
    geom_point() 

# ����ͼ����ʽ,ʹ��guides()����

mpg %>%
    ggplot(aes(x = displ, y = hwy, color = factor(cyl))) +
    geom_point() +
    ggtitle("This is my title") +
    labs(x = "x_displ", y = "y_hwy") +
    guides(color = "legend")

mpg %>%
    ggplot(aes(x = displ, y = hwy, color = factor(cyl))) +
    geom_point() +
    ggtitle("This is my title") +
    labs(x = "x_displ", y = "y_hwy") +
    guides(color = guide_bins(
        title = "my title",
        label.vjust = 1
    ))

mpg %>%
  ggplot(aes(x = displ, y = hwy, color = factor(cyl))) +
  geom_point() +
  ggtitle("This is my title")  +
  labs(x = "x_displ", y = "y_hwy") +
guides(color = guide_legend("hello",ncol = 4)
    )

mpg %>%
  ggplot(aes(x = displ, y = hwy, color = class, size = cyl)) +
  geom_point()

# ɾ��size���ͼ��
mpg %>%
  ggplot(aes(x = displ, y = hwy, color = class, size = cyl)) +
  geom_point() +
  guides(color = guide_legend("type"),
  size = FALSE
  )
