library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income <- read_dta("basic_cleaned.dta")
income.males <- income[income$sex_male == 1,]
min_obs <- 10
grouped_df <- income.males %>%
  filter(jbmi62 > 0 & jbmo62 > 0) %>%
  group_by(xwaveid) %>%
  summarise(n_jobs = sum(changed_employer, rm.na = TRUE) + 1,
            n_ind = n_distinct(industry),
            n_occ = n_distinct(occupation),
            n_ind.dtl = n_distinct(jbmi62),
            n_occ.dtl = n_distinct(jbmo62))

summary(grouped_df)
