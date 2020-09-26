
#### Creating Plots ####

setwd("/Users/simonminasse/GitAndR/ccvi_regions")

library(tidyverse)
library(readxl)
library(RColorBrewer)
library(wesanderson)

# loading data from states_regions
load('/Users/simonminasse/GitAndR/ccvi_regions/states_regions.RData')

#### cleaning up for plotting
state_data4 <- state_data3 %>% as.data.frame()
glimpse(state_data4)
head(state_data4)

# rearranging data for side-by-side (mean / median) plots
rg_mean <- state_data4 %>% group_by(region) %>% 
            summarise_if(is.numeric, mean) %>% 
            add_column(value = 'mean') %>% mutate_if(is.numeric, round, 2) 

rg_median <- state_data4 %>% group_by(region) %>% 
              summarise_if(is.numeric, median) %>%
              add_column(value = 'median') 

rg_mean; rg_median

rg_data <- rbind(rg_mean, rg_median)

rg_data <- rg_data %>% mutate_if(is.character, as.factor); rg_data

# plot ccvi mean / median side-by-side
ggplot(data = rg_data, aes(x = region, y = ccvi_score, fill = value)) + 
  geom_col(position = position_dodge(), color = 'black') + 
  scale_fill_brewer(palette="Greens") +
  geom_text(aes(label=ccvi_score), position = position_dodge(width = 0.9),
            vjust=-0.5, size=4) +
  theme_minimal() +
  ylim(0,1) +
  ggtitle('Mean / Median CCVI Scores across U.S Regions')

