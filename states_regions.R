
#### Organizing State CCVI data into regions ####

setwd("/Users/simonminasse/GitAndR/ccvi_regions")

library(tidyverse)
library(readxl)

load()

# importing CCVI Surgo Dataset
state_data <- read_excel(path = "COVID-19 Community Vulnerability Index (CCVI)_V1.xlsx", sheet = 2)

glimpse(state_data)

# renaming columns to make referenceing easier and saving into new dataset
state_data2 <- state_data %>% rename(state = "State", state_abb = 'State Abbreviation', 
                                     theme_1 = "THEME 1: Socioeconomic Status",
                                     theme_2 = "THEME 2:\nHousehold Composition & Disability",
                                     theme_3 = "THEME 3: \nMinority Status & Language",
                                     theme_4 = "THEME 4: \nHousing Type & Transportation",
                                     theme_5 = "THEME 5: Epidemiological Factors",
                                     theme_6 = "THEME 6: Healthcare System Factors",
                                     ccvi_score = "CCVI SCORE\nHigher = More Vulnerable")
glimpse(state_data2)


#### Defining Regions
# Redundant: Including Abbreviations in case it will be useful later

## West
west_rg <- c("ALASKA", "HAWAII", "WASHINGTON", "OREGON", "IDAHO", "MONTANA", "WYOMING", "CALIFORNIA", 
             "NEVADA", "UTAH", "COLORADO")
west_rg <- west_rg %>% as.data.frame() %>% rename(state = ".") %>% add_column(region = "WEST")

west_abb <- c("AK", "HI", "WA", "OR", "ID", "MT", "WY", "CA", "NV", "UT", "CO")
west_abb <- west_abb %>% as.data.frame() %>% rename(state_abb = ".") %>% add_column(region = "WEST")

## Southeast
southeast_rg <- c("ARKANSAS", "LOUISIANA", "MISSISSIPPI", "ALABAMA", "GEORGIA",
                  "FLORIDA", "SOUTH CAROLINA", "NORTH CAROLINA", "TENNESSEE",
                  "KENTUCKY", "WEST VIRGINIA", "VIRGINIA", "DISTRICT OF COLUMBIA", "MARYLAND",
                  "DELAWARE")
southeast_rg <- southeast_rg %>% as.data.frame() %>% rename(state = ".") %>% add_column(region = "SOUTHEAST")
southeast_abb <- c("AR", "LA", "MS", "AL", "GA", "FL", "SC", "NC",
                   "TN", "KY", "WV", "VA", "DC", "MD", "DE")
southeast_abb <- southeast_abb %>% as.data.frame() %>% rename(state_abb = ".") %>% add_column(region = "SOUTHEAST")

## Southwest
southwest_rg <- c("ARIZONA", "NEW MEXICO", "TEXAS", "OKLAHOMA")
southwest_rg <- southwest_rg %>% as.data.frame() %>% rename(state = ".") %>% add_column(region = "SOUTHWEST")

southwest_abb <- c("AZ", "NM", "TX", "OK")
southwest_abb <- southwest_abb %>% as.data.frame() %>% rename(state_abb = ".") %>% add_column(region = "SOUTHWEST")

## Midwest
midwest_rg <- c("NORTH DAKOTA", "SOUTH DAKOTA", "NEBRASKA", "KANSAS", 
                "MINNESOTA", "IOWA", "MISSOURI", "WISCONSIN", "ILLINOIS", 
                "INDIANA", "MICHIGAN", "OHIO")
midwest_rg <- midwest_rg %>% as.data.frame() %>% rename(state = ".") %>% add_column(region = "MIDWEST")

midwest_abb <- c("ND", "SD", "NE", "KS", "MD", "IA", "MO", "WI", "IL", "IN", "MI", "OH")
midwest_abb <- midwest_abb %>% as.data.frame() %>% rename(state_abb = ".") %>% add_column(region = "MIDWEST")


## Northeast
northeast_rg <- c("PENNSYLVANIA", "NEW JERSEY", "NEW YORK", "CONNECTICUT",
                  "RHODE ISLAND", "MASSACHUSETTS", "VERMONT", "NEW HAMPSHIRE",
                  "MAINE")
northeast_rg <- northeast_rg %>% as.data.frame() %>% rename(state = ".") %>% add_column(region = "NORTHEAST")

northeast_abb <- c("PA", "NJ", "NY", "CT", "RI", "MA", "VT", "NH", "ME")
northeast_abb <- northeast_abb %>% as.data.frame() %>% rename(state_abb = ".") %>% add_column(region = "NORTHEAST")


#### Stacking/concatenating and merging regional data with state data

# stacking regional data
state_info <- as.data.frame(rbind(midwest_rg, 
southwest_rg,
southeast_rg,
northeast_rg,
west_rg))

state_abb_info <- as.data.frame(rbind(midwest_abb, 
                                  southwest_abb,
                                  southeast_abb,
                                  northeast_abb,
                                  west_abb))

glimpse(state_info)
glimpse(state_abb_info)
glimpse(state_data2)

# creating new dataset that merges state and regional data 
state_data3 <- left_join(x = state_data2, y = state_info, by = 'state')
glimpse(state_data3)
state_data3

# converting to factor for grouping
# not yet
# state_data3 <- state_data3 %>% mutate_if(is.character, as.factor)


save.image('/Users/simonminasse/GitAndR/ccvi_regions/states_regions.RData')



### NOTE: Below shows I could have used given state info / regions but chose to stick with regions based on NAT GEO
# state_info2 <- cbind(state.name,
# state.region,
# state.abb) %>% as.data.frame() %>% rename(state = "state.name", region = "state.region", state_abb = "state.abb")
# left_join(x = state_data2, y = state_info2, by = 'state')


  
