# Week 4 hw

library(tidyverse)

surveys <- read.csv("data/portal_data_joined.csv")
surveys

surveys_sub <- filter(surveys, weight > 30, weight < 60)
surveys_sub
head(surveys_sub)

biggest_critters <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarize(max_weight = max(weight))

biggest_critters            

biggest_critters %>% 
  arrange(max_weight) # starts w lowest make weight

biggest_critters %>% 
  arrange(-max_weight) # = to desc, starts with greatest weight

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(species) %>% 
  tally %>% 
  arrange(-n)

surveys %>% 
  filter(is.na(weight)) # only showing rows with a weight value of NA

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(species) # organizes by species in alphabetical order

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(species) %>% 
  tally # shows number of NA values of weights as divided by species - still in order of alphabet species

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(species) %>% 
  tally %>% 
  arrange(-n) # same thing but reorganizes to start w greatest NA weight value rather than by species



surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species, sex) %>% 
  mutate(avg_weight = mean(weight)) %>% # mutate not summarize when you want to add a new column to data frame
  select(species, sex, weight, avg_weight)

surveys_avg_weight  

surveys_avg_weight <- surveys_avg_weight %>% 
  mutate(above_average = weight > avg_weight) # above_average is when the weight = greater than avg weight

surveys_avg_weight
