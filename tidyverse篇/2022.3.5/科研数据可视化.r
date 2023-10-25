lincoln_df <- ggridges::lincoln_weather %>%
  mutate(
    month_short = fct_recode(
      Month,
      Jan = "January",
      Feb = "February",
      Mar = "March",
      Apr = "April",
      May = "May",
      Jun = "June",
      Jul = "July",
      Aug = "August",
      Sep = "September",
      Oct = "October",
      Nov = "November",
      Dec = "December"
    )
  ) %>%
  mutate(month_short = fct_rev(month_short)) %>%
  select(Month, month_short, `Mean Temperature [F]`)

lincoln_df %>%
  head(5)
#ŒÛ≤Ó∞Ù(error bars)
lincoln_errbar <- lincoln_df %>%
    ggplot(aes(x = month_short, y = `Mean Temperature [F]`)) +
    stat_summary(
        fun.y = mean, fun.ymax = function(x) {
            mean(x) + 2 * sd(x)
        },
        fun.ymin = function(x) {
            mean(x) - 2 * sd(x)
        }, geom = "pointrange",
        fatten = 5
    ) +
    labs(
        x = "Month",
        y = "Mean Temperature [F]"
    ) +
    theme_classic(base_size = 14) +
    theme(
        axis.text = element_text(size = 12, color = "cyan4"),
        plot.margin = margin(3, 7, 3, 1.5)
    )
lincoln_errbar


lincoln_box <- lincoln_df %>%
    ggplot(aes(x = month_short, y = `Mean Temperature [F]`)) +
    geom_boxplot(fill = "grey90") +
    labs(
        x = "Month",
        y = "Mean Temperature [F]"
    ) +
    theme_classic(base_size = 14) +
    theme(
        axis.text = element_text(color = "cyan4", size = 12),
        plot.margin = margin(3, 7, 3, 7)
    )
lincoln_box

lincoln_violin <- lincoln_df %>%
    ggplot(aes(x = month_short, y = `Mean Temperature [F]`)) +
    geom_violin(fill = "grey90") +
    labs(
        x = "Month",
        y = "Mean Temperature [F]"
    ) +
    theme_classic(base_size = 14) +
    theme(
        axis.text = element_text(color = "cyan4", size = 12),
        plot.margin = margin(3, 7, 3, 7)
    )
lincoln_violin


lincoln_sina <- lincoln_df %>%
  ggplot(aes(x = month_short, y = `Mean Temperature [F]`)) +
  geom_violin(color = "transparent", fill = "gray90") +
  # dviz.supp::stat_sina(size = 0.85) +
  geom_jitter(width = 0.25, size = 0.85) +
  xlab("month") +
  ylab("mean temperature (°„F)") +
  theme_classic(base_size = 14) +
  theme(
    axis.text = element_text(
      color = "black",
      size = 12
    ),
    plot.margin = margin(3, 7, 3, 1.5)
  )

lincoln_sina
