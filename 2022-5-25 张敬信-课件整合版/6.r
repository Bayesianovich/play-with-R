ts(data = 1: 10, start = 2010, end = 2019) #年度数据

 ts(data = 1: 10, start = 2010, frequency = 4) #季度数据


library(fpp3)
load("stocks.rda")
stocks
stocks = as_tsibble(stocks, key= Stock, index = Date)
stocks

stocks %>%
    group_by_key() %>%
    index_by(weeks = ~ yearweek(.)) %>% #周度汇总
    summarise(
        mean = mean(Close),
        std = sd(Close),
        min = min(Close),
        max = max(Close),
        count = n()
    ) 

autoplot(stocks)
