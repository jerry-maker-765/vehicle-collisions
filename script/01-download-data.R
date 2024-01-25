#### Preamble ####
# Purpose: Downloads, saves, and reads data from the OpenDataToronto portal
# Author: Jierui Miao
# Date: 20 January 2024
# Contact: jierui.miao@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(knitr)
library(dplyr)
library(readr)
library(opendatatoronto)
library(tidyverse)


#### Download data ####
# Each package is associated with a unique id  found in the "For 
# Developers" tab of the relevant page from Open Data Toronto
# source: https://open.toronto.ca/dataset/motor-vehicle-collisions-involving-killed-or-seriously-injured-persons/
collision_data <-
  list_package_resources("0b6d3a00-7de1-440b-b47c-7252fd13929f") |>
  filter(name == 
           "Motor Vehicle Collisions with KSI Data - 4326.csv") |>
  get_resource()

#### Save data ####
dir.create("Vehicle-Collisions/input/data", recursive = TRUE)
write.csv(collision_data, "Vehicle-Collisions/input/data/Collision_data.csv", row.names = FALSE)
head(collision_data)


