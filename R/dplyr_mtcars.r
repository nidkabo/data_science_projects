## import library
library(tidyverse)

## dplyr => grammar of data manipulation

View(mtcars)
rownames(mtcars)
colnames(mtcars)

## 5 functions
## 1. select() => SELECT
## 2. filter() => WHERE
## 3. arrange() => ORDER BY
## 4. mutate() => SELECT .. AS new Column
## 5. summarise() + group_by() => SELECT country, COUNT(*) FROM customers GROUP BY country;

## select specific columns
select(mtcars, 1:5)

select(mtcars, 
       "mpg", wt, hp, 
       10:11)

select(mtcars, starts_with("h"))
select(mtcars, ends_with("p"))
select(mtcars, contains("a"))
select(mtcars, carb, everything())

## create new column / change row names to column 'model'
mtcars$model <- rownames(mtcars)
rownames(mtcars) <- NULL
mtcars <- select(mtcars, model, everything())

## Data Pipeline %>% (Pipe operator)
mtcars <- mtcars %>%
  rownames_to_column() %>%
  rename(model = rowname) %>%
  as_tibble()

## filter 'row' order by 'column' and keep result in object 'm1'
m1 <- mtcars %>%
    select(mpg, hp, wt) %>%
    filter(hp < 100 | wt < 2) %>%
    arrange(desc(hp))

#""" compare to SQL
#  CREATE TABLE IF NOT EXISTS m1
#    SELECT mpg, hp, wt FROM mtcars
#    WHERE hp < 100 OR wt < 2
#    ORDER BY hp DESC;
#"""

## filter data == WHERE SQL
mtcars %>%
    select(model, mpg, hp, wt, am) %>%
    filter( between(mpg, 25, 30) )

mtcars %>%
    select(model, cyl) %>%
    filter( cyl %in% c(6,8) )

## filter with regular expression 'grepl'
mazda_data <- mtcars %>%
    select(model, mpg, hp, wt, am) %>%
    filter(grepl("^Mazda", model))

## mutate() create new column
m2 <- mtcars %>%
    select(model, mpg, hp, wt, am) %>%
    mutate(hp_segment = if_else(hp<100, "low", "high"),
           hp_segment2 = case_when(
               hp < 100 ~ 'low',
               hp < 200 ~ 'medium',
               TRUE ~ 'high'
           ))

## glimpse data structure
glimpse(mtcars) # display better than str()

## am => 0=Auto, 1=Manual / replace data in column 'am'
mtcars <- mtcars %>%
    mutate(am = if_else(am == 0, "Auto", "Manual"),
           vs = if_else(vs == 0, "V-Shaped", "Straight"))

count(mtcars, am)

View(mtcars)

## count
mtcars %>%
    count(am)

mtcars %>%
    count(vs)

m3 <- mtcars %>%
    count(am, vs) %>%
    mutate(percent = n/ nrow(mtcars))

## Read and Write CSV Files

write_csv(m3, "summary_mtcars.csv") # Base R use write.csv()
m3 <- read_csv("summary_mtcars.csv")

## Change Data Types / from 'chr' to 'factor'
mtcars <- mtcars %>%
    mutate(vs = as.factor(vs),
           am = as.factor(am))

## summarise() + group_by()
mtcars %>%
    group_by(am, vs) %>%
    summarise(
        avg_mpg = mean(mpg),
        sum_mpg = sum(mpg),
        min_mpg = min(mpg),
        max_mpg = max(mpg),
        var_mpg = var(mpg),
        sd_mpg  = sd(mpg),
        median_mpg = median(mpg),
        n = n()
    ) -> result

write_csv(result, "result.csv")
