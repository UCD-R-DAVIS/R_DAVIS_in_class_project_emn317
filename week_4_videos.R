library(tidyverse)

surveys_t <- read_csv(file = "data/portal_data_joined.csv")
head(surveys_t) # this is a tibble

select(surveys_t)

select(.data = surveys_t, plot_id, species_id, weight)
# select selects certain columns in a data frame

filter(surveys_t, year == 1995)
# only 1995 selected

filter(surveys_t, year != 1995)
# all years that are NOT 1995

# pipes  %>%  are an operator ; 

surveys2 <- select(surveys_t, plot_id, species_id, weight)

surveys_sml <- filter(surveys_t, weight < 5)

surveys2_filtered <- select(surveys_sml, plot_id, species_id, weight)

head(surveys2_filtered)

# nesting functions (versus single lines of filtering)

surveys_filtered_2 <- select(filter(surveys_t, weight < 5), plot_id, species_id, weight)
identical(surveys2_filtered, surveys_filtered_2)

# Pipes!

surveys_filtered_pipe <- surveys_t %>% 
  filter(weight < 5) %>% # dont need to say : filter(surveys_t, weight < 5) because surveys_t has already been opened 
  select(plot_id, species_id, weight)

head(surveys_filtered_pipe)

  # same as nesting 
 # %>%  can effectively be replaced with the word "then" 

# filters one level at a time

identical(surveys_filtered_2, surveys_filtered_pipe)
# samesies




# PART 2 (week 4.2)


library(tidyverse)
surveys_t <- read_csv("data/portal_data_joined.csv")

# mutate - change data itself

str(surveys_t)
# weight is measured in grams in original data set , can change to be kg

surveys_t$weight/1000

# mutate(new column name = edit to existing column)
# mutate creates a new column doesnt change or delete existing one


surveys_t %>%  # R knows that you are talking about the weight inside of surveys_t BECAUSE of this pipe
  mutate(weight_kg = weight/1000)

# need to override dataframe or create new dataframe in order to solidify the new column 

surveys2 <- surveys_t %>% 
  mutate(weight_kg = weight/1000)

surveys2$weight_kg
# shows just values of weight_kg 

# group by and summarize 

mean(surveys_t$weight)
  # mean of weight within surveys_t dataframe

# remove NAs within a function w : na.rm = T
mean(surveys_t$weight, na.rm = T)


surveys_t %>%  # pipe to next function that will take place within surveys_t
  summarise(max(weight, na.rm = T))

surveys_t %>% 
  group_by(sex) %>% # list all of the diff columns by which we want to group our data
  summarise(mean(weight, na.rm = T)) \
# this creates 2 means, one for Male one for Female because of the group by
# strips out NAs from weight but NOT from sex

surveys_t %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T), # gives a name to mean_weight - creates new data set
            max_weight = max(weight, na.rm = T)) # gives name to max_weight ; remember = is the same as <- (i think)

# multiple group bys at a time

surveys_t %>% 
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T))

# filter out NAs BEFORE calculations

surveys_t %>% 
  filter(!is.na(sex)) %>% # this is the filter to get rid of NAs before grouping
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T))


# arrange

surveys_t %>% 
  filter(!is.na(sex)) %>% 
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T)) %>% 
  arrange(mean_weight) # arranges by mean weight from lowest value up

summary_table <- surveys_t %>% # give this a name (make it a data frame) in order to see the data in a t table
  filter(!is.na(sex)) %>% 
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T)) %>% 
  arrange(mean_weight)

summary_table
View(summary_table)

