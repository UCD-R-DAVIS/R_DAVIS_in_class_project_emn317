library(tidyverse)

gapminder <- read_csv("data/gapminder.csv") #didnt work?

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

view(gapminder)

graph <- gapminder %>% 
  select(country, year, pop, continent) %>% 
  filter(year > 2001) %>% 
  pivot_wider(names_from = year, values_from = pop) %>% 
  mutate(pop_change_0207 = 2007-2002)

view(graph)

graph %>% 
  filter(continent != "Oceania") %>% 
  ggplot(aes(x=reorder(country, pop_change_0207), y= pop_change_0207)) +
  geom_col(aes(fill = continent)) +
  facet_wrap(~continent, scales = "free") +
  theme_bw() +
  scale_fill_viridis_d() +
  xlab("Country") +
  ylab("Change in population between 2002 and 2007") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")
