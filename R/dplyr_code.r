## JOIN TABLES / use default data sets in R
band_members
band_instruments

inner_join(band_members,
           band_instruments,
           by = "name")

left_join(band_members,
          band_instruments,
          by = "name")

right_join(band_members,
           band_instruments,
           by = "name") 

full_join(band_members,
          band_instruments,
          by = "name")

## refactor
band_members %>%
    full_join(band_instruments, 
              by="name") %>%
    filter(name %in% c("John", "Paul")) %>%
    mutate(hello = "OK")

## Working with date
## install.packages("lubridate")
library(lubridate)
library(tidyverse)

## ISO-8601 standard
mydate <- c(
  "2022-06-30", ## ymd()
  "2025-07-15",
  "2024-12-31"
)

ymd(mydate) %>% class()

mydate2 <- c(
  "12-31-2022",
  "11-30-2025",  
  "02-25-2022"
)

mdy(mydate2) %>% day() #month(), year()
mdy(mydate2) %>% month(label = TRUE)
mdy(mydate2) %>% month(label = TRUE, abbr = FALSE)

dmy(c("25-05-2022", 
      "25 May 2022",
      "25-May-2022",
      "25/ May/ 2022"))

ymd_hms(c(
  "2022-05-25 10:11:25",
  "2022 May 25th, 10hour 11min 25second"
))

## data frame
df <- data.frame(
  id = 1:5,
  date = c("25-05-2022", 
           "25 May 2022",
           "25-May-2022",
           "25/ May/ 2022",
           "25 || May || 2022")
)

df %>%
  mutate(date = dmy(date),
         day = day(date),
         month = month(date, label=TRUE),
         year = year(date))
