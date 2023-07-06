library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income <- read_dta("basic_cleaned.dta")

ggplot(income, aes(x = all_hours, y = log_real_wage)) +
  geom_density_2d()



ggplot(income, aes(x = main_hours)) +
  geom_density()

ggplot(income, aes(x = main_income)) +
  geom_density()

ggplot(income[income$wage < 80,], aes(x = wage)) +
  geom_density()

summary(income$wage)

ggplot(income, aes(x = log_real_wage, y = job_satisfaction)) +
  geom_density_2d_filled() +
  scale_fill_brewer()

ggplot(income, aes(x = real_wage, y = job_satisfaction)) +
  geom_density_2d_filled() +
  scale_fill_brewer()

ggplot(income, aes(x = log_real_wage, y = pay_satisfaction)) +
  geom_density_2d_filled() +
  scale_fill_brewer()

ggplot(income, aes(x = log_real_wage, y = chance_volun_leave)) +
  geom_density_2d_filled() +
  scale_fill_brewer()
  
ggplot(income, aes(x = log_real_wage, y = chance_find_better_job)) +
  geom_density_2d_filled() +
  scale_fill_brewer()

ggplot(income, aes(x = log_real_wage, y = chance_find_better_job)) +
  geom_density_2d_filled() +
  scale_fill_brewer()
  