## Results are quite different for 2020 and 2021, likely due to job keeper and other issues surrounding COVID
## Wanted to plot the raw data to understand the trend
## Will likely drop waves 20 and 21.


library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income <- read_dta("with_20_21.dta")
income$sector_public = as.factor(income$sector_public)

income.r <- income[income$log_real_wage > 2 & income$log_real_wage < 5.5,]
ggplot(data=income.r[income.r$wave %in% c(20, 21),], aes(x=log_real_wage, colour=sector_public)) +
  geom_density(size=1.3) +
  geom_density(data=income.r[income.r$wave %in% c(18, 19),], linetype="longdash") +
  geom_density(data=income.r[income.r$wave %in% c(16, 17),], linetype="dotted") +
  geom_density(data=income.r[income.r$wave %in% c(14, 15),], linetype="dotdash") 
