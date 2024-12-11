library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length < mean(surveys$hindfoot_length, na.rm = TRUE), yes = "small", no = "big")
surveys$hindfoot_cat

# na.rm = TRUE makes it so that when calculating the mean, NA doesnt interfere but doesnt actually remove NA from the data frame

# dollar sign calls up the column name easily ( data frame $ columns within the data frame)

head(surveys$hindfoot_cat)
head(surveys$hindfoot_length)
summary(surveys$hindfoot_length)

# summary provides summary of data like mean
# what does summarize do?

surveys$record_id
unique(surveys$hindfoot_cat)

# unique is different kind of functions

?case_when


# ---


surveys %>% 
  mutate(hindfoot_cat = case_when(hindfoot_length > 29.29 ~ "big", TRUE ~ "small")) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head()

# hindfoot length over the mean (29.29) i want to be reclassified as BIG
# ~ introducing new something something something
# TRUE ~ "small" is the else part 
# so > 29.29 is labeled as BIG and TRUE ~ "small" means everything else is labeled as SMALL

table(surveys$hindfoot_cat)

# mutate similar to summarize but mutate conducts the test on every line, not summarize data; just categorizes

# ~ means label
# commas after every step where another step follows, so not at the end
# each line of a case is testing if fulfilled, if not goes down, if gets all the way to bottom it is "small" so TRUE ~ "small" means that if values dont fulfill any of the steps along the way it is TRUE at the end for "small"
# without the TRUE ~ to something those values will be labeled as NA

d <- surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 31.5 ~ "big",
    hindfoot_length > 29 ~ "medium",
    is.na(hindfoot_length) ~ NA_character_,
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head(100)

View(d)

# ---

surveys %>% 
  mutate(favorites = case_when(
    year < 1990 & hindfoot_length > 29.29 ~ "number1",
    species_id %in% c("NL", "DM", "PF", "PE") ~ "number2",
    month == 4 ~ "number3",
    TRUE ~ "other"
  )) %>% 
  group_by(favorites) %>%  UNFINISHED



# ----

# JOINS and PIVOTS
# interjoin, left join, right join (dont use this), full join

# join(x = , y = )
# inter join only where there are matches on left column (such as row number)
# inter join tends to make things smaller

# Left join = no matter what keep everything on the left side and give me stuff on the right
  # when there is no match fill in with NA

# right join = never use this ; does the opposite and only keeps right column 

# full join matches everything, keeps every value, fills w NAs


library(tidyverse)
tail <- read_csv("data/tail_length.csv")
surveys <- read_csv("data/portal_data_joined.csv")

dim(tail)
dim(surveys)
head(tail)

surveys_inner <- inner_join(x = surveys, y = tail)
dim(surveys_inner)
head(surveys_inner)

all(surveys$record_id %in% tail$record_id)
all(tail$record_id %in% surveys$record_id)

# 2 columns in tails
# 13 columns in surveys
# 14 columns when interjoined because both have record_id as matching columns and the rest are added together

surveys_left <- left_join(x = surveys, y = tail)
dim(surveys_left)

surveys_right <- right_join(x = surveys, y = tail)
dim(surveys_right)

# dim() gives number of values , number of rows x number of columns

surveys_full <- full_join(surveys, tail)
dim(surveys_full)

# x, y is assumed order unless you specify w x = X and y = X, in which case you can add the variables in any order

# get rid of a column in tidyverse w inverse select

tail %>% select(-record_id) 
left_join(surveys, tail %>% select(-record_id))

# R does not like that ^

left_join(surveys,tail %>% rename(record_id2 = record_id), by = c("record_id" = "record_id2"))



#----

# Pivots change shapes
# manipulation to visualization so that you can represent data a little more clearly
# either more rows to more columns or more columns to more rows

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

surveys_mz

# dont pivot everything , we want to keep ID columns
# in this case id columns is the genus

surveys_mz %>%
  pivot_wider(id_cols = "genus", 
              names_from = "plot_id", 
              values_from = "mean_weight")

# NA values are because of no weight measurement in that slot (matrix style table requires NA instead of holes)
# same data but more storage
# usually just use observed values

# long is x , y, value) fill in values
# wide is making a matrix of x and y w values