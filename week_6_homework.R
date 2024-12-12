# Assignment 6


library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

gapminder
view(gapminder)

gapminder %>%
  group_by(continent, year) %>% 
  summarize(mean_lifeExp = mean(lifeExp))

?data

gapminder %>%
  group_by(continent, year) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  ggplot()+ geom_point(aes(x = year, y = mean_lifeExp, color = continent)

gapminder %>%
  group_by(continent, year) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  ggplot() +
  geom_point(aes(x = year, y = mean_lifeExp, color = continent))+ 
  geom_line(aes(x = year, y = mean_lifeExp, color = continent))


ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()


geom_boxplot             
geom_boxplot()

gapminder$country

gapminder %>% 
  filter(country %in% c("Brazil", "China", "El Salvador", "Niger", "United States")) %>% 
  ggplot(mapping = aes(x= country, y = lifeExp)) + 
  geom_boxplot() +
  geom_jitter(alpha = 0.4, color = "blue") +
  theme_update() +
  xlab("County") +
  ylab("Life Expectancy") +
  ggtitle("Life Expectancy of Five Countries") +
  theme(plot.title = element_text(hjust = 0.5))
