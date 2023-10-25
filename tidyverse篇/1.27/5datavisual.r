require(tidyverse)
library(cranlogs)
d <- cran_downloads(package = "ggplot2", from = "2019-01-01", to = "2019-12-31")

sum(d$count)


# 1880-2014���¶ȱ仯�Ͷ�����̼�ŷ���
d <- readr::read_csv(here::here("demo_data", "temp_carbon.csv"))
d %>% head(5)
ggplot(data = d) +
    geom_point(mapping = aes(x = year, y = carbon_emissions)) +
    xlab("Year") +
    ylab("Carbon Emissions(metric tons)") +
    ggtitle("Annual global carbon emissions,1880-2014")
# ӳ�� �ÿƿ���Ա�ռ������������������ʾ
penguins <- readr::read_csv(here::here("demo_data", "penguins.csv"))
penguins %>% head(5)

penguins <- readr::read_csv(here::here("demo_data", "penguins.csv")) %>%
    janitor::clean_names() %>%
    drop_na()
penguins %>%
    select(species, sex, bill_length_mm, bill_depth_mm) %>%
    head(4)
ggplot(data = penguins) +
    geom_point(mapping = aes(x = bill_length_mm, y = bill_depth_mm))

ggplot(penguins) +
    geom_point(
        mapping =
            aes(x = bill_length_mm, y = bill_depth_mm, color = species)
    )
ggplot(penguins) +
    geom_point(
        mapping =
            aes(x = bill_length_mm, y = bill_depth_mm, size = species)  
    )
ggplot(penguins) +
    geom_point(
        mapping =
            aes(x = bill_length_mm, y = bill_depth_mm, shape = species)
    )

ggplot(data = penguins) +
    geom_point(
        mapping =
            aes(
                x = bill_length_mm, y = bill_depth_mm,
                color = species, alpha = sex
            )
    )

ggplot(penguins) +
    geom_point(
        mapping =
            aes(x = bill_length_mm, y = bill_depth_mm), color = "cyan")
    
ggplot(penguins) +
    geom_smooth(
        mapping =
            aes(x = bill_length_mm, y = bill_depth_mm),
        method = "lm"
    )
# ͼ��ĵ���
ggplot(penguins) +
    geom_point(aes(x = bill_length_mm, y = bill_depth_mm)) +
    geom_smooth(
        mapping =
            aes(x = bill_length_mm, y = bill_depth_mm)
    )
# ��
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
    geom_point(color = "blue") +
    geom_smooth(color = "red")

# globel
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
    geom_point()

# local
ggplot(penguins) +
    geom_point(aes(x = bill_length_mm, y = bill_depth_mm, color = species))

# ͼ��֮��û�м̳й�ϵ
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
    geom_point() +
    geom_smooth(method = "lm")

ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
    geom_point(aes(color = species)) +
    geom_smooth(method = "lm")

ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
    geom_point() +
    geom_smooth(method = "lm")

ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
    geom_point() +
    geom_smooth(method = "lm", aes(color = sex))

pl <- penguins %>%
    ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
    geom_smooth(method = lm) +
    geom_point(aes(color = species)) +
    ggtitle("This is my first plot")

ggsave(
    plot = pl,
    filename = "my_plot.pdf",
    width = 8,
    height = 6,
    dpi = 300
)

ggplot(penguins, aes(x = bill_length_mm, 
    y = bill_depth_mm, aes(color = species))) +
    geom_point(aes(color = species)) +
    geom_smooth(method = "lm") +
    geom_smooth(method = "lm", aes(color = species))
