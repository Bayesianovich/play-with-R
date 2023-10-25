library(colorspace)
colorspace::swatchplot(c("red", "green", "blue", "cyan", "magenta", "yellow"))
colorspace::swatchplot(c("firebrick", "springgreen4", "blue3", "turquoise3", 
"darkorchid2", "gold2"))
hcl_palettes(plot = TRUE)

penguins %>%
    ggplot(aes(bill_length_mm, fill = species)) +
    geom_density(alpha = 0.5) 

# 手动修改
penguins %>%
    ggplot(aes(bill_length_mm, fill = species)) +
    geom_density(alpha = 0.5) +
    scale_fill_manual(
        breaks = c("Adelie", "Chinstrap", "Gentoo"),
        values = c("darkorange", "purple", "forestgreen")
    )
# 使用colorspace模块配色
penguins %>%
    ggplot(aes(bill_length_mm, fill = species)) +
    geom_density(alpha = 0.4) +
    scale_fill_discrete_qualitative(palette = "cold")

penguins %>%
    ggplot(aes(bill_length_mm, fill = species)) +
    geom_density(alpha = 0.4) +
    scale_fill_discrete_qualitative(palette = "cold",nmax = 4, order = 2:4)
sequential_hcl(palette = "blues 2", n = 6 ) %>% swatchplot()

penguins %>%
    ggplot(aes(bill_length_mm,fill = species)) +
    geom_density(alpha = 0.6) +
    scale_fill_discrete_sequential(
        palette = "blues 2",
        nmax = 6,
        rev = FALSE,
        order = 1:3
    )
    