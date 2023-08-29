library(haven)
library(tidyverse)
library(ggplot2)
library(quantreg)
library(plm)


## CLEANING

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income.raw <- read_dta("basic_cleaned.dta")

n_obs <- income %>%
  group_by(xwaveid) %>%
  summarise(n_obs = n())
table(n_obs$n_obs)
mean(n_obs$n_obs)

income <- merge(income.raw, n_obs, by="xwaveid") %>%
  mutate_at(c("sector", "edu", "xwaveid", "state", "occupation"), as.factor)

income.males <- income[income$sex_male == 1,]

sectoral_movers <- income.males %>%
  group_by(xwaveid) %>%
  summarise(mean_sector = mean(sector_public)) %>%
  mutate(only_public = mean_sector == 1) %>%
  mutate(only_private= mean_sector == 0) %>%
  mutate(mover = !(only_private | only_public))

income.males.mover <- income.males[income.males$xwaveid %in% sectoral_movers$xwaveid[sectoral_movers$mover],]

## ANALYSIS

formula.1 <- formula(log_real_wage ~ experience + experience_sq + edu + sector)
formula.2 <- update(formula.1, .~. + fixed.eff)

m.prelim <- plm(formula.1, data=income.males, index=c("xwaveid"), model="within")

fixed.effs <- fixef(m.prelim)
fixed.effs.names <- names(fixed.effs)
fixed.effs.df <- data.frame(xwaveid = fixed.effs.names, fixed.eff = fixed.effs)

full <- merge(income.males, fixed.effs.df, by="xwaveid")

m1 <- rq(formula.2, data=full, tau=0.9)
summary(m1)

dataset = income.males.mover
base_formula=formula.1

fe_qr <- function(dataset, base_formula, tau, extended_formula = "none", fe_details=FALSE) {
  # Returns the fixed effects quantile regression model
  ### dataset - a dataframe for estimation to be performed on
  ### base_formula - a formula object excluding the fixed effects term
  ### tau - the quantile to best estimated at
  ### index column must be named xwaveid
  
  m.prelim <- plm(base_formula, data=dataset, index="xwaveid", model="within")
  fixed.effs <- fixef(m.prelim)
  fixed.effs.df <- data.frame(xwaveid = names(fixed.effs), fixed.effs = fixed.effs)
  
  print(min(fixed.effs))
  print(max(fixed.effs))
  print(any(is.na(fixed.effs)))
  
  extended_df <- merge(dataset, fixed.effs.df, by="xwaveid")
  if (extended_formula == "none") {
    extended_formula <- update(base_formula, .~. + fixed.effs)
  }
  
  if (fe_details) {
    ggplot(data=fixed.effs.df, aes(x=fixed.effs)) +
      geom_density()
  }
  
  m.full <- rq(extended_formula, data=extended_df, tau=tau)
  return(m.full)
}

## Checking a basic FE-QR model

formula.1 <- formula(log_real_wage ~ sector + experience + experience_sq + married_yes + married_sep +
                       urban_no + state + shiftwork_yes + parttime + long_hours + casual + tenure + occupation)

m.1 <- fe_qr(income.males[income.males$wave<21 & income.males$edu == "uni",], formula.1, tau=0.9)
m.2 <- fe_qr(income.males[income.males$wave<11 & income.males$edu == "uni",], formula.1, tau=0.9)
m.3 <- fe_qr(income.males[income.males$wave>10 & income.males$wave<21 & income.males$edu == "uni",], formula.1, tau=0.9)

res.m1 <- unname(m.1$coefficients[names(m.1$coefficients) == "sectorpublic"])
res.m2 <- unname(m.2$coefficients[names(m.1$coefficients) == "sectorpublic"])
res.m3 <- unname(m.3$coefficients[names(m.1$coefficients) == "sectorpublic"])

res.m1 - (0.5 * (res.m2 + res.m3) - res.m1)


formula.2 <- update(formula.1, .~. + fixed.effs + sector*fixed.effs)

# FE-QR shows negative returns to skills at the highest end of the public sector wage distribution
m.2.1 <- fe_qr(income.males.mover[income.males.mover$edu == "uni",], formula.1, extended_formula=formula.2, tau=0.9, fe_details = TRUE)
summary(m.2.1)

# does this hold in just a linear model
for (min_nobs in 4:15) {
  formula.b.1 <- formula(log_real_wage ~ sector + experience + experience_sq + married_yes + married_sep +
                           urban_no + state + shiftwork_yes + parttime + long_hours + casual + tenure + occupation)
  
  test_df <- income.males.mover[income.males.mover$n_obs > min_nobs,]
  
  m.more_obs <- fe_qr(test_df, formula.b.1, tau=0.9)
  #summary(lm.1)
  print(m.more_obs$coefficients[2])
}

for (min_nobs in 4:21) {
  formula.b.1 <- formula(log_real_wage ~ sector + experience + experience_sq + married_yes + married_sep +
                           urban_no + state + shiftwork_yes + parttime + long_hours + casual + tenure + occupation)
  
  test_df <- income.males.mover[income.males.mover$n_obs > min_nobs & income.males.mover$edu == "uni",]
  
  m.more_obs <- fe_qr(test_df, formula.b.1, tau=0.9)
  #summary(lm.1)
  print(m.more_obs$coefficients[2])
}

for (min_nobs in 4:15) {
  formula.b.1 <- formula(log_real_wage ~ sector + experience + experience_sq + married_yes + married_sep +
                           urban_no + state + shiftwork_yes + parttime + long_hours + casual + tenure + occupation)
  
  test_df <- income.males[income.males$n_obs > min_nobs,]
  
  m.more_obs <- fe_qr(test_df, formula.b.1, tau=0.9)
  #summary(lm.1)
  print(m.more_obs$coefficients[2])
}

## ALSO if FE-QR didn't give a negative result then this is kinda cap

m.test <- lm(log_real_wage ~ experience + experience_sq + sector * factor(xwaveid), data=income.males.mover)
