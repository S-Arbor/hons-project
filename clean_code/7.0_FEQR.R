library(haven)
library(tidyverse)
library(ggplot2)
library(quantreg)
library(plm)


## CLEANING

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../cleaned_data/v4", sep="/"))

income.raw <- read_dta("basic_cleaned.dta")

n_obs <- income.raw %>%
  group_by(xwaveid) %>%
  summarise(n_obs = n())
income <- merge(income.raw, n_obs, by="xwaveid") %>%
  mutate_at(c("edu", "xwaveid", "state", "occupation"), as.factor)

income.males <- income[income$sex_male == 1,]
income.females <- income[income$sex_female == 1,]


## function
fe_qr <- function(dataset, base_formula, tau, extended_formula = "none", fe_details=FALSE) {
  # Returns the fixed effects quantile regression model
  ### dataset - a dataframe for estimation to be performed on
  ### base_formula - a formula object excluding the fixed effects term
  ### tau - the quantile to best estimated at
  ### index column must be named xwaveid
  
  m.prelim <- plm(base_formula, data=dataset, index="xwaveid", model="within")
  fixed.effs <- fixef(m.prelim)
  fixed.effs.df <- data.frame(xwaveid = names(fixed.effs), fixed.effs = fixed.effs)
  
  extended_df <- merge(dataset, fixed.effs.df, by="xwaveid")
  if (extended_formula == "none") {
    extended_formula <- update(base_formula, .~. + fixed.effs)
  }
  
  if (fe_details == TRUE) {
    ggplot(data=fixed.effs.df, aes(x=fixed.effs)) +
      geom_density()
    print(min(fixed.effs))
    print(max(fixed.effs))
    print(any(is.na(fixed.effs)))
  }
  
  m.full <- rq(extended_formula, data=extended_df, tau=tau)
  return(m.full)
}
## set sampling ids
v.males.all <- c()
income.males$sampling_id <- 1
set.seed(2020202)
sampling_ids = sample(1:19,size=19)
for (xwaveid in unique(income.males$xwaveid)) {
  income.males$sampling_id[income.males$xwaveid == xwaveid] = sample(1:19, size=nrow(income.males[income.males$xwaveid == xwaveid,]), replace=FALSE)
}

income.females$sampling_id <- 1
set.seed(2020202)
sampling_ids = sample(1:19,size=19)
for (xwaveid in unique(income.females$xwaveid)) {
  income.females$sampling_id[income.females$xwaveid == xwaveid] = sample(1:19, size=nrow(income.females[income.females$xwaveid == xwaveid,]), replace=FALSE)
}

## Males, 0.5 quantile
v.males.0.5 <- c()
formula.main <- formula(log_real_wage ~ sector_public + experience + experience_sq + married_yes + married_sep +
                          urban_no + state + shiftwork_yes + parttime + long_hours + casual + tenure + occupation)
t = rep(8:19, 5)
for (i in 0:4) {
  sampling_ids = sample(1:19,size=19)
  for (waves in 8:19) {
    test_df <- income.males[income.males$sampling_id %in% sampling_ids[1:waves] & income.males$n_obs > 3,]
    
    m.fe_qr <- fe_qr(test_df, formula.main, tau=0.5)
    v.males.0.5[waves-7+i*12] <- m.fe_qr$coefficients[2]
    print(waves)
  }
}
plot(t, v.males.0.5)
length(v.males.0.5)
series=c(rep(1,12),rep(2,12),rep(3,12),rep(4,12),rep(5,12))

df.1 <- data.frame(t, v.males.0.5, series)
df.1$t_inv <- 1 / df.1$t
ggplot(df.1, aes(t_inv, v.males.0.5, colour=factor(series))) +
  geom_point() +
  geom_smooth(method="lm") +
  ggtitle("FE-QR Convergence for Quantile 0.5") +
  xlab("1/t") +
  ylab("Public Sector Wage Differential") +
  theme(legend.position="none")



## 0.9 quantile
v.males.0.9 <- c()
formula.main <- formula(log_real_wage ~ sector_public + experience + experience_sq + married_yes + married_sep +
                         urban_no + state + shiftwork_yes + parttime + long_hours + casual + tenure + occupation)
t = rep(8:19, 5)
for (i in 0:4) {
  sampling_ids = sample(1:19,size=19)
  for (waves in 8:19) {
    test_df <- income.males[income.males$sampling_id %in% sampling_ids[1:waves] & income.males$n_obs > 3,]
    
    m.fe_qr <- fe_qr(test_df, formula.main, tau=0.9)
    v.males.0.9[waves-7+i*12] <- m.fe_qr$coefficients[2]
    print(waves)
  }
}
plot(t, v.males.0.9)
length(v.males.0.9)
series=c(rep(1,12),rep(2,12),rep(3,12),rep(4,12),rep(5,12))

df.1 <- data.frame(t, v.males.0.9, series)
df.1$t_inv <- 1 / df.1$t
ggplot(df.1, aes(t_inv, v.males.0.9, colour=factor(series))) +
  geom_point() +
  geom_smooth(method="lm")  +
  ggtitle("FE-QR Convergence for Quantile 0.9") +
  xlab("1/t") +
  ylab("Public Sector Wage Differential") +
  theme(legend.position="none")

## Women 0.5 quantile
v.females.0.5 <- c()
formula.main <- formula(log_real_wage ~ sector_public + experience + experience_sq + married_yes + married_sep +
                          urban_no + state + shiftwork_yes + parttime + long_hours + casual + tenure + occupation)
t = rep(8:19, 5)
for (i in 0:4) {
  sampling_ids = sample(1:19,size=19)
  for (waves in 8:19) {
    test_df <- income.females[income.females$sampling_id %in% sampling_ids[1:waves] & income.females$n_obs > 3,]
    
    m.fe_qr <- fe_qr(test_df, formula.main, tau=0.5)
    v.females.0.5[waves-7+i*12] <- m.fe_qr$coefficients[2]
    print(waves)
  }
}
plot(t, v.females.0.5)
length(v.females.0.5)
series=c(rep(1,12),rep(2,12),rep(3,12),rep(4,12),rep(5,12))

df.1 <- data.frame(t, v.females.0.5, series)
df.1$t_inv <- 1 / df.1$t
ggplot(df.1, aes(t_inv, v.females.0.5, colour=factor(series))) +
  geom_point() +
  geom_smooth(method="lm") +
  ggtitle("FE-QR Convergence for Quantile 0.5") +
  xlab("1/t") +
  ylab("Public Sector Wage Differential") +
  theme(legend.position="none")



## 0.9 quantile
v.females.0.9 <- c()
formula.main <- formula(log_real_wage ~ sector_public + experience + experience_sq + married_yes + married_sep +
                          urban_no + state + shiftwork_yes + parttime + long_hours + casual + tenure + occupation)
t = rep(8:19, 5)
for (i in 0:4) {
  sampling_ids = sample(1:19,size=19)
  for (waves in 8:19) {
    test_df <- income.females[income.females$sampling_id %in% sampling_ids[1:waves] & income.females$n_obs > 3,]
    
    m.fe_qr <- fe_qr(test_df, formula.main, tau=0.9)
    v.females.0.9[waves-7+i*12] <- m.fe_qr$coefficients[2]
    print(waves)
  }
}
plot(t, v.females.0.9)
length(v.females.0.9)
series=c(rep(1,12),rep(2,12),rep(3,12),rep(4,12),rep(5,12))

df.1 <- data.frame(t, v.females.0.9, series)
df.1$t_inv <- 1 / df.1$t
ggplot(df.1, aes(t_inv, v.females.0.9, colour=factor(series))) +
  geom_point() +
  geom_smooth(method="lm")  +
  ggtitle("FE-QR Convergence for Quantile 0.9") +
  xlab("1/t") +
  ylab("Public Sector Wage Differential") +
  theme(legend.position="none")
  