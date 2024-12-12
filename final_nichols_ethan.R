# part 1

library(tidyverse)

surveys <- read_csv("https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv")

view(surveys)

# part 2

surveys_running <- surveys %>% 
  filter(sport == "running")

view(surveys_running)

# part 3

normal_running <- surveys_running %>% 
  filter("minutes_per_mile" < 10, "minutes_per_mile" > 5) %>% 
  filter("total_elapsed_time_s" > 60) # didnt work

summarise(normal_running)
view(normal_running)

normal_running <- surveys_running %>% 
  filter(minutes_per_mile < 10, minutes_per_mile > 5) %>% 
  filter(total_elapsed_time_s > 60)

view(normal_running)

# part 4
# Group observations into three time periods corresponding to pre-2024 running, Tyler’s initial rehab efforts from January to June of this year, and activities from July to the present.

?mutate

normal_running_grouped <- normal_running %>% 
  mutate(time_period = case_when(
    timestamp < "2024-01-01" ~ "Pre_2024",
    timestamp >= "2024-01-01" ~ "Jan_to_Jul_2024",
    timestamp > "2024-07-01" ~ "Jul_to_Dec_2024"
  ))

view(normal_running_grouped)

# this added a new column called time_period

# part 5

library(ggplot2)

# graph steps per minute over speed by lap (minutes per mile?)

ggplot(data = normal_running_grouped, mapping = aes(x = minutes_per_mile, y = steps_per_minute)) +
  geom_point(alpha = 1, size = 1)

# part 6

ggplot(data = normal_running_grouped, mapping = aes(x = minutes_per_mile, y = steps_per_minute)) +
  geom_point(alpha = 1, size = 1) +
  ggtitle("Steps per Minute over Speed by Lap (Minutes per Mile)") +
  xlab("Steps per Minute") +
  ylab("Minutes per Mile")

ggplot(data = normal_running_grouped, mapping = aes(x = minutes_per_mile, y = steps_per_minute)) +
  geom_point(alpha = 0.5, size = 0.5) +
  ggtitle("Steps per Minute over Speed by Lap (Minutes per Mile)") +
  xlab("Steps per Minute") +
  ylab("Minutes per Mile") +
  theme_bw()
  
# part 7

ggplot(data = normal_running_grouped, mapping = aes(x = minutes_per_mile, y = steps_per_minute)) +
  geom_point(alpha = 0.5, size = 0.5) +
  ggtitle("Steps per Minute over Speed by Lap (Minutes per Mile)") +
  xlab("Steps per Minute") +
  ylab("Minutes per Mile") +
  theme_bw() +
  geom_smooth(method = "lm")

ggplot(data = normal_running_grouped, mapping = aes(x = minutes_per_mile, y = steps_per_minute)) +
  geom_point(alpha = 0.5, size = 0.5) +
  ggtitle("Steps per Minute over Speed by Lap (Minutes per Mile)") +
  xlab("Steps per Minute") +
  ylab("Minutes per Mile") +
  theme_bw() +
  geom_smooth(method = "lm", aes(group = "Pre_2024", group = "Jan_to_Jul_2024", group = "Jul_to_Dec_2024"))
      # could not figure out exactly how to divide the line into 3 sections; but I assume three distinct lines would need to be added based on 3 different categories within the "time_period" column

?geom_smooth

