library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income <- read_dta("movers.dta")

income.males.to_priv <- income[income$sex_male == 1 & income$l_moved_priv == 1,]
income.males.to_pub <- income[income$sex_male == 1 & income$l_moved_pub == 1,]

ggplot(data=income.males.to_priv) +
  geom_density(aes(x=log_real_wage), colour="red") +
  geom_density(aes(x=leading_log_real_wage), colour="blue") +
  labs(title="Males Pub to Priv")

ggplot(data=income.males.to_pub) +
  geom_density(aes(x=log_real_wage), colour="blue") +
  geom_density(aes(x=leading_log_real_wage), colour="red") +
  labs(title="Males Priv to Pub")

ggplot(data=income.males.to_priv, aes(x=age)) +
  geom_density(colour="blue") +
  geom_density(data=income.males.to_pub, colour="red")
  

income.females.to_priv <- income[income$sex_female == 1 & income$l_moved_priv == 1,]
income.females.to_pub <- income[income$sex_female == 1 & income$l_moved_pub == 1,]

ggplot(data=income.females.to_priv) +
  geom_density(aes(x=log_real_wage), colour="red") +
  geom_density(aes(x=leading_log_real_wage), colour="blue") +
  labs(title="Females Pub to Priv")

ggplot(data=income.females.to_pub) +
  geom_density(aes(x=log_real_wage), colour="blue") +
  geom_density(aes(x=leading_log_real_wage), colour="red") +
  labs(title="Females Priv to Pub")
  
ggplot(data=income.females.to_priv, aes(x=age)) +
  geom_density(colour="blue") +
  geom_density(data=income.females.to_pub, colour="red")
