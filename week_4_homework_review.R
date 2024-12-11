# hw week 5

library(tidyverse)
surveys <- read.csv("data/portal_data_joined.csv")

# part 2

# weight between 30 and 60 # filter out rows

# head only prints out first few rows


mini <- surveys %>% filter(weight > 30 & weight < 60) %>% head(n = 5)
mini <- surveys %>% filter(weight %in% 30:60) %>% head(n = 5)
# both do same thing

# part 3a
# new tibble showing max weight for each species by sex combination

biggest_critters <- surveys %>% filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarise(max_weight = max(weight))
# left side of arrow is the data frame 

biggest_critters

# part 3b
# arrange data frame

# - = desc (descending)
biggest_critters %>% arrange(-max_weight) %>% head()

# part 4

surveys %>% filter(is.na(weight)) %>% 
  group_by(species) %>% tally %>% arrange(-n)
# tally locates number of top values
# arrange (-n) goes biggest to smallest for organizing

# part 5

# remove rows where weight is NA using filter()
  # filter(!is.na(X)) filters NAs out of a certain group 
surveys %>% filter(!is.na(weight))

# new column = avg weight of species + sex combo

surveys %>% filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(avg_weight = mean(weight))

# get rid of all columns except species sex weight avg weight

surveys %>% filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(avg_weight = mean(weight)) %>% 
  select(species_id, sex, weight, avg_weight)

# save tibble by making it a data frame

surveys_avg_weight <- surveys %>% filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(avg_weight = mean(weight)) %>% 
  select(species_id, sex, weight, avg_weight)

# difference between mutate and summarize

# EVERYTHING AFTER THIS COMMENT IS NOT PART OF HW JSUT EXTRA

# make mini summary table ; idk if this is correct

surveys_mini <- surveys %>% filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarise(avg_weight = mean(weight))

surveys_mini

# part 6

# take surveys_avg_weight
# add new column
# called above_average that contains logical values
# stating whether or not the row's weight is above average
# for its species + sex combo

# mutate for add a column
# adding above_average column w mutate

surveys_avg_weight %>% mutate(above_average = weight > avg_weight)

# above_average = weight > avg_weight == this is the new column



