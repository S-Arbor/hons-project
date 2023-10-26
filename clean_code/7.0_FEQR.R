library(haven)
library(tidyverse)
library(ggplot2)
library(quantreg)
library(plm)


## CLEANING

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../cleaned_data/v4", sep="/"))

income.raw <- read_dta("basic_cleaned.dta")

indis <- income.raw %>%
  group_by(xwaveid) %>%
  summarise(n_obs = n(),mean_sec=mean(sector_public))
income <- merge(income.raw, indis, by="xwaveid") %>%
  mutate_at(c("edu", "xwaveid", "state", "occupation"), as.factor)

income$sec_switcher = income$mean_sec > 0 & income$mean_sec < 1

income.males <- income[income$sex_male == 1 & income$n_obs > 1,]
income.females <- income[income$sex_female == 1 & income$n_obs > 1,]


## feqr function
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

formula.main <- formula(log_real_wage ~ sector_public + experience + experience_sq + married_yes + married_sep +
                          urban_no + state + shiftwork_yes + parttime + long_hours + casual + tenure + factor(occupation) + factor(wave))

test <- fe_qr(income.males[income.males$sec_switcher == 1,], formula.main, tau=0.5)

## bootstrap function

clustered_sample <- function(dataset) {
  individuals <- unique(dataset$xwaveid)
  selected_individuals <- sample(individuals, size=length(individuals),replace=TRUE)
  
  selected_rows <- c()
  for (individual in selected_individuals) {
    row_mask <- dataset$xwaveid == individual
    rows <- (1:nrow(dataset))[row_mask]
    selected_rows <- c(selected_rows, rows)
  }
  return(selected_rows)
}


bootstrap_feqr <- function(dataset, base_formula, reps, tau) {
  
  bootstrap_results <- matrix(ncol=45,nrow=reps)
  for (i in 1:reps) {
    print(paste("Rep:", i))
    sample_rows <- clustered_sample(dataset)
    feqr_res <- fe_qr(dataset[sample_rows,], base_formula, tau)
    bootstrap_results[i,] <- feqr_res$coefficients
  }
  return(bootstrap_results) 
}

main_res <- fe_qr(income.males[income.males$n_obs>2,],tau=0.5, base_formula=formula.main)
errors <- bootstrap_feqr(income.males[income.males$n_obs>2,], formula.main, reps=100, tau=0.5)

for (tau in c(0.1,0.25,0.5,0.75,0.9)) {
  print(tau)
  print(fe_qr(income.males[income.males$n_obs>2,],tau=tau, base_formula=formula.main)$coefficients[2])
}

for (tau in c(0.1,0.25,0.5,0.75,0.9)) {
  print(tau)
  print(fe_qr(income.females[income.females$n_obs>2,],tau=tau, base_formula=formula.main)$coefficients[2])
}

