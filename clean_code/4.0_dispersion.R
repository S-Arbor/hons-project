library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../cleaned_data/v4", sep="/"))

income <- read_dta("basic_cleaned.dta")
income$leading_changed_emp_1_year[is.na(income$leading_changed_emp_1_year)] = 0

bootstrap_var_diff <- function(series_1, series_2, reps, noisy=TRUE) {
  series_1.var <- vector(length=reps)
  series_2.var <- vector(length=reps)
  nobs <- length(series_1)
  individuals <- 1:nobs
  for (i in 1:reps) {
    individuals.boot <- sample(individuals, size=nobs, replace=TRUE)
    series_1.var[i] <- var(series_1[individuals.boot])
    series_2.var[i] <- var(series_2[individuals.boot])
  }
  diff_in_var <- series_1.var / series_2.var
  
  print("Var_1")
  print(var(series_1))
  print(sd(series_1.var))
  print(quantile(series_1.var, probs=c(0.005, 0.025, 0.05, 0.95, 0.975, 0.995)))
  
  print("Var_2")
  print(var(series_2))
  print(sd(series_2.var))
  print(quantile(series_2.var, probs=c(0.005, 0.025, 0.05, 0.95, 0.975, 0.995)))
  
  print("Var_1 / Var_2")
  print(var(series_1) / var(series_2))
  print(sd(diff_in_var))
  print(quantile(diff_in_var, probs=c(0.005, 0.025, 0.05, 0.95, 0.975, 0.995)))
  return(diff_in_var)
}



# males.mover
males.mover <- income[income$sex_male == 1 & income$leading_changed_emp_1_year == 1 & !(is.na(income$leading_log_real_wage)),]
males.mover.bs <- bootstrap_var_diff(males.mover$leading_log_real_wage, males.mover$log_real_wage, 10000)

# Males
males.to_pub <- income[income$leading_moved_public_1_year == 1 & income$sex_male == 1 & !(is.na(income$leading_moved_public_1_year)),]


d.1 <- bootstrap_var_diff(males.to_pub$log_real_wage, males.to_pub$leading_log_real_wage, reps=10000)
plot(density(d.1))

males.to_priv <- income[income$leading_moved_private_1_year == 1 & income$sex_male == 1 & !(is.na(income$leading_moved_private_1_year)),]


d.2 <- bootstrap_var_diff(males.to_priv$leading_log_real_wage, males.to_priv$log_real_wage, reps=10000)
plot(density(d.2))

# Females
females.to_pub <- income[income$leading_moved_public_1_year == 1 & income$sex_female == 1 & !(is.na(income$leading_moved_public_1_year)),]


d.3 <- bootstrap_var_diff(females.to_pub$log_real_wage, females.to_pub$leading_log_real_wage, reps=10000)
plot(density(d.3))

females.to_priv <- income[income$leading_moved_private_1_year == 1 & income$sex_female == 1 & !(is.na(income$leading_moved_private_1_year)),]


d.4 <- bootstrap_var_diff(females.to_priv$leading_log_real_wage, females.to_priv$log_real_wage, reps=10000)
plot(density(d.4))



## Plots
ggplot(data=males.to_pub) +
  geom_density(aes(x=log_real_wage), colour="blue", label="private") +
  geom_density(aes(x=leading_log_real_wage), colour="red", label="public") +
  theme(legend.position = "right")
ggplot(data=males.to_priv) +
  geom_density(aes(x=log_real_wage), colour="red") +
  geom_density(aes(x=leading_log_real_wage), colour="blue") +
  theme(legend.position = "right") +
  ggtitle("Male Public Leavers") +
  theme_bw() +
  xlim(2, 5)
ggplot(data=females.to_pub) +
  geom_density(aes(x=log_real_wage), colour="blue") +
  geom_density(aes(x=leading_log_real_wage), colour="red") +
  theme(legend.position = "right") +
  ggtitle("Female Public Joiners") +
  theme_bw() +
  xlim(1.8, 4.2)
ggplot(data=females.to_priv) +
  geom_density(aes(x=log_real_wage), colour="red", label="public") +
  geom_density(aes(x=leading_log_real_wage), colour="blue", label="private") +
  theme(legend.position = "right")

## by edu
ggplot(data=males.to_priv[males.to_priv$edu_uni == 1,]) +
  geom_density(aes(x=log_real_wage), colour="blue", label="private") +
  geom_density(aes(x=leading_log_real_wage), colour="red", label="public") +
  theme(legend.position = "right")
ggplot(data=males.to_pub[males.to_pub$edu_uni == 1,]) +
  geom_density(aes(x=log_real_wage), colour="blue", label="private") +
  geom_density(aes(x=leading_log_real_wage), colour="red", label="public") +
  theme(legend.position = "right")
