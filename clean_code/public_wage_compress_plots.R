library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../cleaned_data/v4", sep="/"))

income <- read_dta("basic_cleaned.dta")

bootstrap_var_diff <- function(series_1, series_2, reps) {
  diff_in_var <- vector(length=reps)
  nobs <- length(series_1)
  individuals <- 1:nobs
  for (i in 1:reps) {
    individuals.boot <- sample(individuals, size=n, replace=TRUE)
    series_1_sd <- sd(series_1[individuals.boot])
    series_2_sd <- sd(series_2[individuals.boot])
    diff_in_var[i] <- series_1_sd - series_2_sd
  }
  return(diff_in_var)
}

# Males
males.to_pub <- income[income$leading_moved_public_1_year == 1 & income$sex_male == 1 & !(is.na(income$leading_moved_public_1_year)),]
ggplot(data=males.to_pub) +
  geom_density(aes(x=log_real_wage), colour="blue", label="private") +
  geom_density(aes(x=leading_log_real_wage), colour="red", label="public") +
  theme(legend.position = "right")

d.1 <- bootstrap_var_diff(males.to_pub$log_real_wage, males.to_pub$leading_log_real_wage, reps=10000)
plot(density(d.1))

males.to_priv <- income[income$leading_moved_private_1_year == 1 & income$sex_male == 1 & !(is.na(income$leading_moved_private_1_year)),]
ggplot(data=males.to_priv) +
  geom_density(aes(x=log_real_wage), colour="red", label="public") +
  geom_density(aes(x=leading_log_real_wage), colour="blue", label="private") +
  theme(legend.position = "right")

d.2 <- bootstrap_var_diff(males.to_priv$leading_log_real_wage, males.to_priv$log_real_wage, reps=10000)
plot(density(d.2))

# Females
females.to_pub <- income[income$leading_moved_public_1_year == 1 & income$sex_female == 1 & !(is.na(income$leading_moved_public_1_year)),]
ggplot(data=females.to_pub) +
  geom_density(aes(x=log_real_wage), colour="blue") +
  geom_density(aes(x=leading_log_real_wage), colour="red") +
  theme(legend.position = "right")

d.3 <- bootstrap_var_diff(females.to_pub$log_real_wage, females.to_pub$leading_log_real_wage, reps=10000)
plot(density(d.3))

females.to_priv <- income[income$leading_moved_private_1_year == 1 & income$sex_female == 1 & !(is.na(income$leading_moved_private_1_year)),]
ggplot(data=females.to_priv) +
  geom_density(aes(x=log_real_wage), colour="red", label="public") +
  geom_density(aes(x=leading_log_real_wage), colour="blue", label="private") +
  theme(legend.position = "right")

d.4 <- bootstrap_var_diff(females.to_priv$leading_log_real_wage, females.to_priv$log_real_wage, reps=10000)
plot(density(d.4))



## t tests
# first one displayed is public sector
# t.test(income.males.to_priv$log_real_wage, income.males.to_priv$leading_log_real_wage)
# t.test(income.males.to_pub$leading_log_real_wage, income.males.to_pub$log_real_wage)
# 
# t.test(income.females.to_priv$log_real_wage, income.females.to_priv$leading_log_real_wage)
# t.test(income.females.to_pub$leading_log_real_wage, income.females.to_pub$log_real_wage)

