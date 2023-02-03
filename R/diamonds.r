# diamonds - a data set in tidyverse

## import library
library("tidyverse")

## view data structure
glimpse(diamonds)

## mutate() - create new column
diamonds %>% count(cut) %>%
    mutate( percent = n/sum(n))

## top ten diamonds by cut and color
### combination - top 10 largest amounts of diamonds by percent in descending order
result <- diamonds %>%
  count(cut, color) %>%
  mutate( percent = n / sum(n)) %>%
  as.data.frame %>%
  arrange( desc(percent)) %>%
  head(10)

## export data to csv file
write_csv(result, "top_ten_diamonds.csv")
