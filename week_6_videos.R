# Week 6 VIDEOS


library(tidyverse)

surveys_complete <- read_csv("data/portal_data_joined.csv") %>% 
  filter(!is.na(weight), !is.na(hindfoot_length))

# ggplot(data = <data>, mapping = aes(<mappings>)) + <geometric function>()
  # + instead of %>% 
  # geom function is the shape of the data ; how it is represented

ggplot(data = surveys_complete)
 # havent specified any variables to work with or the shape they will take

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))
  # no indexing bc data is already specified

# geom functions
# geom_point() for scatter plots, dot plots etc
# geom_boxplot() for boxplots
# geom_line() trend lines , time series, etc.

# geom_point for continuous data

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

surveys_plot <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

surveys_plot +
  geom_point()

# now can manipulate elements within the figure (within the geom_point aesthetic function)

surveys_plot +
  geom_point(alpha=0.1) # alpha=X adds level of transparency 

surveys_plot +
  geom_point(alpha=0.5, color="blue")

# can highlight data colors by different variables

surveys_plot +
  geom_point(alpha=0.5, aes(color=species_id)) # use species id not in quotes


             