require(nycflights13)
require(tidyverse)
flights

?flights
?dplyr

filter(flights, month == 1, day == 10)

jan1 <- filter(flights, month == 1, day == 1)

View(jan1)

(aug <- filter(flights, month == 8, day == 8))

sqrt(2)^2

sqrt(2)^2 == 2

near(sqrt(2)^2, 2)

filter(flights, month == 10|  month == 11)

filter(flights, month %in% c(10,11))

# Find flights were NOT delayed by more than 2  hours

flights
filter(flights,!(arr_delay>120|dep_delay>120))

# Missing Values, Na
NA > 5
NA == 5
NA + 100
df <-tibble(x = c(100, NA,300))
df
filter(df,x >100)

arrange(flights, year, month, day)

arrange(flights,desc(dep_delay))

## Missing Values
df <- tibble(x =c(10,3,NA))
df
arrange(df,x)

arrange(df,desc(x))
