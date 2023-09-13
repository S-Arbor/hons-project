library(haven)
library(tidyverse)
library(ggplot2)
library(quantreg)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income$wave_n <- income$wave
income <- income %>%
  mutate_at(c("children_cat", "married", "birth", "edu", "state", "wave"), as.factor)

formula.1 <- log_real_wage ~ sector_public + experience + experience_sq + edu + children_cat + health_poor + birth + married + urban_no + shiftwork_yes + parttime + long_hours + casual + state + wave
m1 <- rq(formula.1, tau=0.1, data=income, weights=hhwtrp)
summary(m1)

m2 <- update(m1, data=income[income$wave_n < 6,])
summary(m2)
