#### Preamble ####
# Purpose: Get data and make table
# Author: Jierui Miao
# Date: 20 January 2024
# Contact: jierui.miao@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
install.packages("knitr")
install.packages("janitor")
install.packages("lubridate")
install.packages("opendatatoronto")
install.packages("tidyverse")

library(knitr)
library(janitor)
library(lubridate)
library(opendatatoronto)
library(tidyverse)
library(tibble)

#### Simulate ####

set.seed(344)

years <- 2005:2020
light_conditions <- c("Daylight", "Dark", "Dawn", "Dusk")
road_conditions <- c("Dry", "Wet", "Snow", "Ice", "Gravel")

# Create a data frame with all combinations of years, light conditions, and road surface conditions
simulated_data <- expand.grid(Year = years,
                              Light_Condition = light_conditions,
                              Road_Surface_Condition = road_conditions)

# Assume the number of collisions follows a Poisson distribution
# with an average of 30 collisions per condition per year
simulated_data$Number_of_Collisions <- rpois(nrow(simulated_data), lambda = 30)

# View the first few rows of the simulated data
head(simulated_data)


