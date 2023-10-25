install.packages("httr")
library(httr)
uri <- "https://api.github.com/search/repositories?q=dplyr&sort=forks"
response <- GET(uri)


base_uri <- "https://api.github.com"
endpoint <- "/search/repositories"
resource_uri <- paste0(base_uri, endpoint)

query_params <- list(q = "dplyr", sort = "forks")
response <- GET(resource_uri, query_params)

response

install.packages("jsonlite") 
library(jsonlite)

response <- GET(uri, query_params)

response_text <- content(response, "text")
response_text
response_data <- fromJSON(response_text)
response_data

is.data.frame(response_data)

str(response_data)
names(response_data)

items <- response_data$items

is.data.frame(items)


people <- data.frame(names = c("Ed", "Jessica", "keagan"))
favorites <- data.frame(
    food = c("pizza", "ice cream", "salad"),
    music = c("Bluegrass", "Indie", "Electronic")
)
people$favorites <- favorites
print(people)

people$favorites.food

people$favorites$food

people <- flatten(people)
people$favorites.food

