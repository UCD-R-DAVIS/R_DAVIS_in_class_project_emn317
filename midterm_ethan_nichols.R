# Midterm 10/31

library(tidyverse)
surveys <- read.csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv")

surveys
View(surveys)

surveys_running <- surveys$running # X
surveys_running

surveys_running <- surveys %>% 
  filter(sport == "running")

surveys_running_laps <- surveys_running %>% 
  filter(minutes_per_mile < 10, minutes_per_mile > 5)

surveys_running_laps
View(surveys_running_laps)

surveys_running_laps <- surveys_running_laps %>% 
  mutate(pace = case_when(minutes_per_mile < 6 ~ "fast",
                                     minutes_per_mile >=6 & minutes_per_mile < 8 ~ "medium",
                                     T ~ "slow"))
                          
surveys_running_laps <- surveys_running_laps %>% 
  mutate(year_category = case_when(year == 2024 ~ "New",
                                   year < 2024 ~ "Old"))

surveys_running_table <- surveys_running_laps %>% group_by(year_category, pace) %>% 
  summarize(avg_steps_per_minute = mean(steps_per_minute)) %>%
  pivot_wider(id_cols = year_category, values_from = avg_steps_per_minute,names_from = pace) %>%
  select(year_category, slow, medium, fast)

summarize(running_time_stats = surveys_running_table$minutes_per_mile) # X
