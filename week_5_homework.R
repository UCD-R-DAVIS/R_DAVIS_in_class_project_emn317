# Week 5 hw

library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")

# step 1: make wide survey w/
  # colummns for genus + every plot type
  # rows have genus names and mean hindfoot length for every plot type

  # Control is plot type column

surveys_wide <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(genus, plot_type) %>% # selects? focuses on? genus and plot type as columns
  summarize(mean_hindfoot = mean(hindfoot_length)) %>% # need to create a mean_hindfoot column here ; values of pivot_wider only pull from columns
  pivot_wider(names_from = "plot_type", values_from = "mean_hindfoot") %>% 
  arrange(Control) # in this case Control is a column created from plot type 

surveys_wide


# pt 2

# use surveys
  # create a new weight category called "weight_cat" ;
    # define rodent weight by 3 categories:
      # "small" =< 1st quartile of weight distribution
      # "medium" > 1st quartile, < 3rd quartile
      # "large" >= 3rd quartile 
        # summarize function shows quartile values
  # compare how if_else and case_when variables effect NAs 

summarize(surveys$weight) # doesnt work
summary(surveys$weight) # yep

surveys %>% 
  mutate(weight_cat = case_when(weight <= 20 ~ "small", 
                                weight > 20 & weight < 48 ~ "medium", # must use & not , 
                                weight >= 48 ~ "large"))

