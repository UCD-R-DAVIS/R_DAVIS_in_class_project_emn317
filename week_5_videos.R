# Week 5 vids

# conditional statements
# conditions for when R does certain things
# if something here happens, do this, if this happens, do that

library(tidyverse)

surveys <-read_csv("data/portal_data_joined.csv")

# read_cvs is the tidyverse version of read.csv
  # use when you want it to show w a tibble

# if else - if this, do that

ifelse(test = surveys$year==1977, yes = print("year is 1977"), no = print("not 1977"))

# group animals between small and big

surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length < 29.29, "small", "big") # "small" is the if and "big" is the else, if first thing is satisfied (< 29.29), the first word is printed, if it does not satisfy that it goes by the second word
surveys$hindfoot_cat
head(surveys$hindfoot_cat)

# if else works best for 2 categories
# case_when allows you to nest a bunch of ifelse functions for multiple categories

surveys %>% 
  mutate(hindfoot_cat = case_when( # mutate is to create a new category called hindfoot_cat
    hindfoot_length > 29.29 ~ "big", # ~ used in case_when 
    TRUE ~ "small" # TRUE is the replacement value ; # last TRUE means any other value ; if anything else is true, label as "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head


surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big",
    hindfoot_length < 10 ~ "really small",
    TRUE ~ "small" # NAs are returns as small wootst
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  group_by(hindfoot_cat) %>% summarise(n()) # bonus function this shows number that fulfill each category (summarize)
# (n()) just means "count the number"

surveys %>% 
  mutate(hindfoot_cat = case_when(
    is.na(hindfoot_length) ~ NA_character_,
    hindfoot_length > 29.29 ~ "big",
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head

# in case_when you have to use NA_character_ not just NA


# WEEK 5 part 2 5.2


library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")

# Joining data

tail <- read_csv("data/tail_length.csv")
str(tail)

summary(surveys$record_id)
summary(tail$record_id)
identical(surveys, tail)
identical(surveys$record_id, tail$record_id)

# join_type ( x = first table,
#              y = second table1
#              by = column to join by)

?left_join
# left join is most common

surveys_joined <- left_join(surveys, tail)
# take the right and then join the left to it
# joined by record id
# identified that they were the same column bc of column name
# using "by = " specifies the column name so that it doesnt just pick for you

surveys_joined <- left_join(surveys, tail, by="record_id")
surveys_joined



# Pivoting 
# aka reshaping data

# ex.  create a summary table to compare different mean weights of each species among plots
  # first calc mean weight for each species within each plot

surveys_weight <- surveys %>% # pipe means we are working within surveys for following commands
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight)) # mean_weight is the new column

surveys_weight # creates a tibble, tibble is a fancy data frame
head(surveys_weight)

# bad tibble, 196 rows long and only 3 columns

# how many rows and columns do we want?
  # may want to have genus by rows and plot id by columns

unique(surveys_weight$genus)
# unique tells us all of the unique values within column genus

length(unique(surveys_weight$genus))
# gives number of unique values

# n_distinct is the same 
n_distinct(surveys_weight$genus) # 10 genus - make rows
n_distinct(surveys_weight$plot_id) # 24 plot id - make columns

# pivot wider increases columns and decreases the number of rows

# pivot_wider(dataframe, names_from = column to create new column names, values_from = column to fill values inside table cells)

wide_survey <- surveys_weight %>% 
  pivot_wider(names_from = "plot_id", values_from = "mean_weight") # so the column from surveys_weight used to create new column names come from plot_id, mean_weight values then fill the cells

wide_survey

# pivbot longer increases rows and decreases columns (opposite of pivot wider)
  # stack columns on top of each other in order to have more rows

# pivot_longer(dataframe, cols = columns to stack, names_to = new column name to store old/wide column NAMES, values_to = new column name to store old/wide column VALUES

surveys_long <- wide_survey %>% 
  pivot_longer(cols = -genus, names_to = "plot_id", values_to = "mean_weight") # says -genus gets rid of genus column (which is a label column name an actual value)

surveys_long # essentially how we started
# columns are genus, plot it, mean weight

identical(surveys_weight, surveys_long)
# false ; when we pivoted wide, NAs were made, NAs were kept when we pivoted long so there are more rows than in surveys_weight

surveys_long <- surveys_long %>% 
  filter(!is.na(mean_weight))

identical(surveys_weight, surveys_long)
# still false? bc all NAs were removed but surveys_weight had a few NAs ( i think))

