# Load your survey data frame with the read.csv() function.

surveys <- read.csv("data/portal_data_joined.csv")

# Create a new data frame called surveys_base with only the species_id, the weight, and the plot_type columns.

surveys_base <- surveys[, c(6, 9, 13)]
surveys_base <- surveys[, c("species_id", "weight", "plot_type")]
surveys_base <- select(surveys, species, weight, plot_type)
  # all of these have the same result

# Have this data frame only be the first 5,000 rows. 

surveys_base <- surveys[1:5000, c("species_id", "weight", "plot_type")]

# Convert both species_id and plot_type to factors. 

surveys_base$species_id <- factor(surveys_base$species_id)
class(surveys_base$species_id)
str(surveys_base)
  # $ replaces species_id column inside the surveys_base
  # $ is a special character function (like NA); it says look within this option before the $ for things that are in the thing following the $

surveys_base$species_id
surveys_base

# Explore these variables and try to explain why a factor is different from a character. Why might we want to use factors? Can you think of any examples?

# CHALLENGE: Create a second data frame called challenge_base that only consists of individuals from your surveys_base data frame with weights greater than 150g.

# ----

# Base R and tidyverse are different

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)

# add a new column
# mutate: adds a new column

surveys <- surveys %>% mutate(., weight_kg = weight/1000)
head(surveys)
str(surveys)

# add other columns (do multiple things to multiple columns)

surveys <- surveys %>% mutate(., weight_kg = weight/1000, weight_kg2 = weight_kg*2)
str(surveys)

surveys$weight_kg2 = as.character(surveys$weight_kg2)
surveys$weight_kg2

# filter out the NAs

ave_weight <- surveys %>% filter(!is.na(weight)) %>% mutate(mean_weight = mean(weight))
# !is.na means value is not NA
# using the mean(weight) is one value - the avg of all numbers in the data set including everything
str(ave_weight)
nrow(ave_weight)
ave_weight$mean_weight

ave_weight <- surveys %>%  filter(complete.cases(.))
nrow(ave_weight)

# ---- group_by and summarize

# group_by tells are I want you to group by a specific column of data, typically categorical
# can calc mean by certain groups

surveys %>% group_by(sex) %>% mutate(mean_weight = mean(weight, na.rm = TRUE))

surveys %>% group_by(sex) %>% summarize(mean_weight = mean(weight, na.rm = TRUE))

# group by multiple columns (multiple groups)

surveys %>% group_by(sex, species_id) %>% summarize(mean_weight = mean(weight, na.rm = TRUE))

summarize(df)

# arrange order in a certtain way

surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  arrange(mean_weight)

# if you are arrange and leave the column name is it it goes from lowest to highest value

surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  arrange(-mean_weight)
# changest order

# Challenge

# What was the weight of the heaviest animal measured in each year? Return a table with three columns: year, weight of the heaviest animal in grams, and weight in kilograms, arranged (arrange()) in descending order, from heaviest to lightest. (This table should have 26 rows, one for each year)

surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)

max_weight <-surveys %>% 
  filter(!is.na(weight))


max_weight <- surveys %>% 
  select(year, record_id, weight) %>%  # selecting the 3 variables we care about within survey data
  group_by(year) %>% # why group by year?
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% # change weight column to be in grams not in kg
  
d <- surveys %>% 
  select(year, record_id, weight) %>%
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  group_by(year) %>% 
  summarize(max_weight_g = max(weight), max_weight_kg = max(weight)) %>% arrange()


