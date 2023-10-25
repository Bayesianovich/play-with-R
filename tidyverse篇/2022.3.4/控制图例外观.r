library(tidyverse)
library(palmerpenguins)

# ���õ�Ĵ�С��͸����

penguins %>% drop_na() %>% 
    ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
    geom_point(size = 1, alpha = 0.5)

penguins %>% drop_na() %>%
    ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
    geom_point(alpha = 0.5, size = 1) +
    guides(color = guide_legend(override.aes = list(size = 5)))
   
penguins %>% drop_na() %>%
    ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
    geom_point(alpha = 0.5, size = 1) +
    scale_color_manual(
        breaks = c("Adelie", "Chinstrap", "Gentoo"),
        values = c("darkorange", "forestgreen", "darkblue"),
        guide = guide_legend(override.aes = list(size = 5))
    )

#���������ѧ����
penguins %>% drop_na() %>% 
    ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
    geom_point(alpha = 0.5, size = 1) +
    scale_color_manual(
        breaks = c("Adelie", "Chinstrap", "Gentoo"),
        values = c("darkorange", "forestgreen", "darkblue"),
        guide = guide_legend(override.aes = list(size = 5, alpha = 1))
    ) 

# ѹ��ͼ����һ������ѧӳ��
#override.aes����һ����;��,ɾ��ͼ����һ������ѧӳ�䡣
points <- tribble(
    ~x, ~y, ~id, 
     5, 51, "a",
  10, 54, "a",
   7, 50, "a",
   9, 60, "a",
  86, 97, "b",
  46, 74, "b",
  22, 59, "b",
  94, 68, "b",
  21, 45, "c",
   6, 56, "c",
  24, 25, "c",
   3, 70, "c"
)
points

box <- data.frame(
    left = 1,
    right = 10,
    bottom = 50,
    top = 60,
    id = "a"
)
box

points %>%
    ggplot(aes(color = id)) +
    geom_point(aes(x = x, y = y), size = 4) +
    geom_rect(
        data = box,aes(
            xmin = left, xmax = right,
            ymin = 50, ymax = top
        ),
        fill = NA, size = 1
        )
# ��Ҫ�Ƴ�ͼ���ı߿������� ������override.aes�����ò���linetype = 0
# ������linetype = c(_, _, _)����Ҫ�����ĵ�һ��Ϊ1������Ҫ�Ƴ��ĵڶ��͵�����Ϊ0
points %>%
    ggplot(aes(color = id)) +
    geom_point(aes(x = x, y = y), size = 4) +
    geom_rect(
        data = box,aes(
            xmin = left, xmax = right,
            ymin = 50, ymax = top
        ),
        fill = NA, size = 1
        ) +
        guides(color = guide_legend(override.aes = list(linetype = c(1, 0, 0))))

penguins %>% drop_na() %>%
    ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
    geom_point(alpha = 0.5, size = 5) +
    geom_smooth(method = "lm", se = TRUE) 

# �Ƚ�
penguins %>% drop_na() %>%
    ggplot(aes(x = bill_length_mm,
    y = bill_depth_mm, color = factor(species))) +
    geom_point(alpha = 0.5, size = 5) +
    geom_smooth(method = "lm", se = TRUE)


penguins %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = factor(species))) +
  geom_point(aes(alpha = "Observed"), size = 3) +
  geom_smooth(method = "lm", se = FALSE, aes(alpha = "Fitted")) +
  scale_alpha_manual(
    name = NULL,
    values = c(1, 1),
    breaks = c("Observed", "Fitted")
  ) +
  guides(alpha = guide_legend(override.aes = list(
    linetype = c(0, 1),  # 0�������� 1������
    shape = c(16, NA),   # 16�����״�� NAû�е�
    color = "black"
  )))

  #Ҳ����д��scale_alpha_*��
penguins %>%
    ggplot(aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
    geom_point(aes(alpha = "Observed"), size = 3) +
    geom_smooth(method = "lm", se = FALSE, aes(alpha = "Fitted")) +
    scale_alpha_manual(
        name = NULL,
        values = c(1, 1),
        breaks = c("Observed", "Fitted"),
        guide = guide_legend(override.aes = list(linetype = c(0,1),
                                                 shape = c(16, NA),
                                                 color = "black")))
