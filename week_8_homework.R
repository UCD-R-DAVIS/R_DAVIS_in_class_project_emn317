library(tidyverse)

mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

mloa
summarize(mloa)
view(mloa)

head(mloa)
summary(mloa$rel_humid)

mloa2 <- mloa %>% filter(
    rel_humid != -99 &
      windSpeed_m_s != -999.9 &
      temp_C_2m != -999.9)

mloa2$datetime <- paste(mloa2$year, "-", mloa2$month,"-", mloa2$day, ", ", mloa2$hour24, ":", mloa2$min, sep = "")

view(mloa2)
mloa2 %>% select(datetime, month, day, year, hour24, min) %>% head()
mloa2 %>% select(datetime, month, day, year, hour24, min) %>% tail()

mloa2$datetime <- ymd_hm(mloa2$datetime, 
                         tz = "UTC")

tail(mloa2)

?with_tz

mloa2$datetime <- with_tz(mloa2$datetime, tzone = "Pacific/Honolulu")
tail(mloa2)
view(mloa2)


mloa2 %>%
  mutate(month=month(datetime,label=TRUE)) %>% 
  mutate(hour=hour(datetime)) %>%
  group_by(month,hour) %>% 
  summarise(meanhourlytemp=mean(temp_C_2m))

mloa2 %>%
  mutate(month=month(datetime,label=TRUE)) %>% 
  mutate(hour=hour(datetime)) %>%
  group_by(month,hour) %>% 
  summarise(meanhourlytemp=mean(temp_C_2m)) %>% 
  ggplot(aes(x = month,
             y = meanhourlytemp)) +
  geom_point(aes(col = hour)) + 
  theme_classic() +
  ylab("Mean Temperature (Degrees C)") +
  xlab("Month") +
  ggtitle("Mean Hourly Temperature per Month") +
  scale_color_viridis_c(direction = -1) +
  theme(plot.title = element_text(hjust = 0.5)
        