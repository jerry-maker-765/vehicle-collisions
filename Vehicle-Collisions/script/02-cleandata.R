#### Preamble ####
# Purpose: Cleans the raw plane data
# Author: Jierui Miao
# Date: 20 January 2024
# Contact: jierui.miao@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(dplyr)
library(readr)

#### Clean data ####
data <- read_csv(here::here("Vehicle-Collisions/input/data/Collision_data.csv"))
str(data$date)
data$date <- as.Date(data$date, format = "%Y-%m-%d")
data <- mutate(data, month = format(date, "%m"))

str(data$month)
winter_data <- filter(data, month %in% c("11", "12", "01", "02"))


collision_data_clean <- winter_data %>%
  clean_names() %>%
  rename(road_condition = rdsfcond,
         Fatality = acclass) %>%
  drop_na(year) %>%
  filter(Fatality != "Property Damage Only",
         visibility != "Other",
         visibility !="None",
         road_condition != "Other",
         redlight == "None",
         speeding == "None",
         alcohol == "None",
         ag_driv == "None") %>%
  mutate(light = case_when(
    light %in% c("Dark, artificial") ~ "Dark",
    light %in% c("Dusk, artificial") ~ "Dusk",
    light %in% c("Daylight, artificial") ~ "Daylight",
    light %in% c("Dawn, artificial") ~ "Dawn",
    TRUE ~ light
  )) %>%
  mutate(visibility = case_when(
    visibility %in% c("Drifting Snow") ~ "Snow",
    visibility %in% c("Fog, Mist, Smoke, Dust") ~ "Fog",
    TRUE ~ visibility
  )) %>%
  mutate(road_condition = case_when(
    road_condition %in% c("Loose Snow", "Packed Snow", "Slush") ~ "Snow",
    road_condition %in% c("Loose Sand or Gravel") ~ "Gravel",
    TRUE ~ road_condition
  ))%>%
  select(year, district, light, visibility, road_condition, Fatality)

#### Save data ####
write.csv(collision_data_clean, "/cloud/project/Vehicle-Collisions/input/data/Collision_data_clean.csv", row.names = FALSE)

