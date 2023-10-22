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

income.males <- income[income$sex_male == 1 & income$n_obs > 1,]
income.females <- income[income$sex_female == 1 & income$n_obs > 1,]


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

perform_test <- function(df, fig_name, tau=0.5, ts=8:19, columns=4,reps=5) {
  formula.main <- formula(log_real_wage ~ sector_public + experience + experience_sq + married_yes + married_sep +
                            urban_no + state + shiftwork_yes + parttime + long_hours + casual + tenure + factor(occupation) + factor(wave))
  
  sampling_ids <- matrix(nrow=nrow(df),ncol=columns)
  
  for (xwaveid in unique(df$xwaveid)) {
    row_mask = df$xwaveid == xwaveid
    nobs = sum(row_mask)
    for (i in 1:columns) {
      sampling_ids[row_mask,i] = sample(1:19,size=nobs,replace=FALSE) 
    }
  }
  
  v.results <- c()
  v.n_t <- c()
  t = rep(ts, reps * columns)
  colset <- rep(1:columns,each=length(ts)*reps)
  for (i in 1:length(t)) {
    sampling_ids_to_include <- sample(1:19,t[i])
    df_mask = sampling_ids[,colset[i]] %in% sampling_ids_to_include
    test_df <- df[df_mask,]
    
    m.fe_qr <- fe_qr(test_df, formula.main, tau=0.5)
    v.results[i] <- m.fe_qr$coefficients[2]
    v.n_t[i] <- sum(df_mask) / t[i]
    
    print(paste("Fitted:", i))
  }
  
  df.1 <- data.frame(v.n_t, v.results)
  df.1$t_n <- 1 / df.1$v.n_t
  out_fig <- ggplot(df.1, aes(t_n, v.results)) +
    geom_point() +
    geom_smooth(method="lm") +
    xlab("n/t") +
    ylab("Estimated Differential") +
    theme(legend.position="none")
  
  ggsave(paste("../../output_figures/qrfe_bias/",fig_name,".png",sep=""), out_fig)
}

set.seed(2020)
perform_test(income.males, fig_name = "feqr_men_75", tau=0.75, ts=8:19, columns=5,reps=5)
perform_test(income.males, fig_name = "feqr_men_25", tau=0.25, ts=8:19, columns=5,reps=5)
perform_test(income.males, fig_name = "feqr_men_50", tau=0.5, ts=8:19, columns=5,reps=5)
perform_test(income.males, fig_name = "feqr_men_10", tau=0.10, ts=8:19, columns=5,reps=5)
perform_test(income.males, fig_name = "feqr_men_90", tau=0.9, ts=8:19, columns=5,reps=5)

perform_test(income.females, fig_name = "feqr_women_50", tau=0.5, ts=8:19, columns=5,reps=5)
perform_test(income.females, fig_name = "feqr_women_75", tau=0.75, ts=8:19, columns=5,reps=5)
perform_test(income.females, fig_name = "feqr_women_25", tau=0.25, ts=8:19, columns=5,reps=5)
perform_test(income.females, fig_name = "feqr_women_10", tau=0.1, ts=8:19, columns=5,reps=5)
perform_test(income.females, fig_name = "feqr_women_90", tau=0.9, ts=8:19, columns=5,reps=5)


########################################################################################
### Perform Bias Test for Males ########################################################
########################################################################################

## set sampling ids
set.seed(2020202)

sampling_ids <- matrix(nrow=nrow(income.males),ncol=columns)

for (xwaveid in unique(income.males$xwaveid)) {
  row_mask = income.males$xwaveid == xwaveid
  nobs = sum(row_mask)
  for (i in 1:columns) {
    sampling_ids[row_mask,i] = sample(1:19,size=nobs,replace=FALSE) 
  }
}

## New Test


## Dated Test
v.males.0.5 <- c()
v.males.0.5.n_t <- c()
t = rep(ts, reps * columns)
colset <- rep(1:columns,each=length(ts)*reps)
for (i in 1:length(t)) {
  sampling_ids_to_include <- sample(1:19,t[i])
  df_mask = sampling_ids[,colset[i]] %in% sampling_ids_to_include
  test_df <- income.males[df_mask & income.males$n_obs > 2,]
  
  m.fe_qr <- fe_qr(test_df, formula.main, tau=0.5)
  v.males.0.5[i] <- m.fe_qr$coefficients[2]
  v.males.0.5.n_t[i] <- sum(df_mask) / t[i]
  
  print(paste("Fitted:", i))
}

plot(t, v.males.0.5)

df.1 <- data.frame(t, v.males.0.5)
df.1$t_inv <- 1 / df.1$t
males.50 <- ggplot(df.1, aes(t_inv, v.males.0.5)) +
  geom_point() +
  geom_smooth(method="lm") +
  ggtitle("FE-QR Convergence for Quantile 0.5") +
  xlab("n/t") +
  ylab("Public Sector Wage Differential") +
  theme(legend.position="none")

ggsave("../../output_figures/qrfe_bias/qrfe_male_q50.png", males.50)

## Men Q90

## Men Q10

