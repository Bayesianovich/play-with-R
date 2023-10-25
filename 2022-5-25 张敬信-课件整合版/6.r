ts(data = 1: 10, start = 2010, end = 2019) #�������

 ts(data = 1: 10, start = 2010, frequency = 4) #��������


library(fpp3)
load("stocks.rda")
stocks
stocks = as_tsibble(stocks, key= Stock, index = Date)
stocks

stocks %>%
    group_by_key() %>%
    index_by(weeks = ~ yearweek(.)) %>% #�ܶȻ���
    summarise(
        mean = mean(Close),
        std = sd(Close),
        min = min(Close),
        max = max(Close),
        count = n()
    ) 

autoplot(stocks)
