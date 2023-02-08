## import library
library(tidyverse)

## msleep => the msleep (mammals sleep) data set contains the sleep times and weights for a set of mammals
## more information: https://ggplot2.tidyverse.org/reference/msleep.html
glimpse(msleep)

## how many rows have NA?
x <- complete.cases(msleep)
sum(x); sum(!x)

## filter only NA in rows all data
msleep %>%
  filter( !complete.cases(.) )

## filter only NA in selected columns
msleep %>%
  filter( is.na(conservation) )
  
msleep %>%
  filter( is.na(sleep_rem) )
  
## Mean Imputation (Replace NA)
## 1. find mean value
## 2. replace NA with mean

avg_sleeprem <- msleep %>%
  summarise( mean(sleep_rem, na.rm=T) ) %>%
  pull() %>%
  round(2)

clean_msleep <- msleep %>%
  mutate(clean_sleep_rem = replace_na(sleep_rem, avg_sleeprem))

## count function
msleep %>%
  count(vore) %>%
  mutate(pct = n/sum(n) * 100) %>%
  arrange( desc(pct) )

## Mode Imputation
msleep2 <- msleep %>%
  mutate(clean_vore = replace_na(vore,
                                 "herbi")) %>%
  select(name, genus, vore, clean_vore)

View(msleep)

## Replace NA with conditional means
avg_sleep_by_vore <- msleep %>%
  group_by(vore) %>%
  summarise(avg_sleeprem = mean(sleep_rem, na.rm=TRUE))

## case_when() conditional means
## use avg_sleeprem from avg_sleep_by_vore
clean_msleep <- msleep %>% 
  select(vore, sleep_rem) %>%
  mutate(clean_sleep_rem = case_when(
    is.na(sleep_rem) & vore == "carni"   ~ 2.29,
    is.na(sleep_rem) & vore == "herbi"   ~ 1.37,
    is.na(sleep_rem) & vore == "insecti" ~ 3.52,
    is.na(sleep_rem) & vore == "omni"    ~ 1.96,
    is.na(vore) ~ 1.88,
    TRUE ~ sleep_rem
  ))

## another way
msleep %>% 
  left_join(avg_sleep_by_vore, by = "vore") %>%
  mutate(clean_sleep_rem = if_else(
    is.na(sleep_rem), avg_sleeprem, sleep_rem
  ))
