
#### Creating Plots ####

setwd("/Users/simonminasse/GitAndR/ccvi_regions")

library(tidyverse)
library(readxl)
library(RColorBrewer)
library(wesanderson)
library(ggpubr)

# loading data from states_regions
load('/Users/simonminasse/GitAndR/ccvi_regions/states_regions.RData')

# loading results from below
load('/Users/simonminasse/GitAndR/ccvi_regions/regional_plots.RData')

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
p0 <- ggplot(data = rg_data, aes(x = region, y = ccvi_score, fill = value)) + 
  geom_col(position = position_dodge(), color = 'black') + 
  scale_fill_brewer(palette="Blues") +
  geom_text(aes(label=ccvi_score), position = position_dodge(width = 0.9),
            vjust=-0.5, size=4) +
  theme_minimal() +
  ylim(0,1) +
  ggtitle('Mean / Median CCVI Scores across U.S Regions')

# plot Theme 1 mean / median side-by-side
p1 <- ggplot(data = rg_data, aes(x = region, y = theme_1, fill = value)) + 
  geom_col(position = position_dodge(), color = 'black') + 
  scale_fill_brewer(palette="Greens") +
  geom_text(aes(label=theme_1), position = position_dodge(width = 0.9),
            vjust=-0.5, size=4) +
  theme_minimal() +
  ylim(0,1) +
  ggtitle('Mean / Median Socioeconomic Scores across U.S Regions')

# plot Theme 2 mean / median side-by-side
p2 <- ggplot(data = rg_data, aes(x = region, y = theme_2, fill = value)) + 
  geom_col(position = position_dodge(), color = 'black') + 
  scale_fill_brewer(palette="Greens") +
  geom_text(aes(label=theme_2), position = position_dodge(width = 0.9),
            vjust=-0.5, size=4) +
  theme_minimal() +
  ylim(0,1) +
  ggtitle('Mean / Median Household Scores across U.S Regions')

# plot Theme 3 mean / median side-by-side
p3 <- ggplot(data = rg_data, aes(x = region, y = theme_3, fill = value)) + 
  geom_col(position = position_dodge(), color = 'black') + 
  scale_fill_brewer(palette="Greens") +
  geom_text(aes(label=theme_3), position = position_dodge(width = 0.9),
            vjust=-0.5, size=4) +
  theme_minimal() +
  ylim(0,1) +
  ggtitle('Mean / Median Minority Scores across U.S Regions')

# plot Theme 4 mean / median side-by-side
p4 <- ggplot(data = rg_data, aes(x = region, y = theme_4, fill = value)) + 
  geom_col(position = position_dodge(), color = 'black') + 
  scale_fill_brewer(palette="Greens") +
  geom_text(aes(label=theme_4), position = position_dodge(width = 0.9),
            vjust=-0.5, size=4) +
  theme_minimal() +
  ylim(0,1) +
  ggtitle('Mean / Median Housing/Transportation Scores across U.S Regions')

# plot Theme 5 mean / median side-by-side
p5 <- ggplot(data = rg_data, aes(x = region, y = theme_5, fill = value)) + 
  geom_col(position = position_dodge(), color = 'black') + 
  scale_fill_brewer(palette="Greens") +
  geom_text(aes(label=theme_5), position = position_dodge(width = 0.9),
            vjust=-0.5, size=4) +
  theme_minimal() +
  ylim(0,1) +
  ggtitle('Mean / Median Epidemiological Scores across U.S Regions')

# plot Theme 6 mean / median side-by-side
p6 <- ggplot(data = rg_data, aes(x = region, y = theme_6, fill = value)) + 
  geom_col(position = position_dodge(), color = 'black') + 
  scale_fill_brewer(palette="Greens") +
  geom_text(aes(label=theme_6), position = position_dodge(width = 0.9),
            vjust=-0.5, size=4) +
  theme_minimal() +
  ylim(0,1) +
  ggtitle('Mean / Median Healthcare Scores across U.S Regions')

# arranging plots on one page
ggarrange(p1,p2,p3,p4,p5,p6,p0, ncol = 2, nrow = 4)


save.image('/Users/simonminasse/GitAndR/ccvi_regions/regional_plots.RData') 

