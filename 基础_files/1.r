x <- c("a" = 5, "b" = 6, "c" = 7, "d" = 8)
x

x <- c(5, 6, 7, 8)
names(x) <- c("a", "b", "c", "d")
x

four_seasons <- c("spring", "summer", "autumn", "winter")
four_seasons

four_seasons_factor <- factor(four_seasons)
four_seasons_factor

four_seasons <- c("spring", "summer", "autumn", "winter")
four_seasons_factor <- factor(four_seasons, 
                              levels = c("summer", "winter", "spring", "autumn")
                              )
four_seasons_factor

l <- list(
    "one" = c("a","b","c"),
    "two" = c(1:5),
    "three" = c(TRUE,FALSE)
)
l
l[1]
l['one']
l[["one"]]
l$one

tb <- tibble::tibble(
    x =1:4,
    y =4:1,
    z =c("a","b","c","d")
)
tb
tb["x"]
tb[,"x"]


df <- data.frame(
  x = 1:4,
  y = 4:1,
  z = c("a", "b", "c", "d")
)
df
df[, "x"]
df[, "x", drop = FALSE]
