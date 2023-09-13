library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income <- read_dta("basic_cleaned.dta")

income.2 <- income %>%
  group_by(sex_male, wave, sector_public) %>%
  summarise(mean_wage=weighted.mean(log_real_wage,hhwtrp))

income.2$sector_public <- as.factor(income.2$sector_public)
ggplot(data=income.2[income.2$sex_male==1,], aes(y=mean_wage,x=wave, colour=sector_public)) +
  geom_line() +
  geom_line(data=income.2[income.2$sex_male == 0,], linetype="dotted")
