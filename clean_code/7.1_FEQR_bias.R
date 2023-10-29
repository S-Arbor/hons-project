library(haven)
library(tidyverse)
library(ggplot2)
library(quantreg)
library(plm)
library(scales)


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

perform_test <- function(df, fig_name, tau=0.5, ts=8:19, columns=4,reps=2) {
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
    
    m.fe_qr <- fe_qr(test_df, formula.main, tau=tau)
    v.results[i] <- m.fe_qr$coefficients[2]
    v.n_t[i] <- sum(df_mask) / t[i]
    
    print(paste("Fitted:", i))
  }
  
  df.1 <- data.frame(v.n_t, v.results, t)
  df.1$t_inv <- 1 / df.1$t
  df.1$s_group <- as.factor(colset)
  out_fig <- ggplot(df.1, aes(t_inv, v.results)) +
    geom_point() +
    theme_bw() +
    scale_x_continuous(labels = label_number(accuracy = 0.001)) +
    geom_smooth(method="lm") +
    xlab("1/t") +
    ylab("Estimated Differential") +
    theme(legend.position="none") +
    theme(axis.text=element_text(size=18),
          axis.title=element_text(size=20,face="bold"))
  
  colour_fig <- ggplot(df.1, aes(t_inv, v.results,colour=s_group)) +
    geom_point() +
    theme_bw() +
    scale_x_continuous(labels = label_number(accuracy = 0.001)) +
    geom_smooth(method="lm") +
    xlab("1/T") +
    ylab("Estimated Differential") +
    theme(legend.position="none") +
    theme(axis.text=element_text(size=18),
          axis.title=element_text(size=20,face="bold"))
  
  write.csv(df.1, file=paste("../../output_figures/qrfe_bias_3/",fig_name,".csv",sep=""),row.names = FALSE)
  ggsave(paste("../../output_figures/qrfe_bias_3/",fig_name,".png",sep=""), out_fig)
  ggsave(paste("../../output_figures/qrfe_bias_3/colourful/",fig_name,".png",sep=""), colour_fig)
}

set.seed(2020)
perform_test(income.males, fig_name = "feqr_men_75", tau=0.75, ts=8:19)
perform_test(income.males, fig_name = "feqr_men_25", tau=0.25, ts=8:19)
perform_test(income.males, fig_name = "feqr_men_50", tau=0.5, ts=8:19)
perform_test(income.males, fig_name = "feqr_men_10", tau=0.10, ts=8:19)
perform_test(income.males, fig_name = "feqr_men_90", tau=0.9, ts=8:19)

perform_test(income.females, fig_name = "feqr_women_50", tau=0.5, ts=8:19)
perform_test(income.females, fig_name = "feqr_women_75", tau=0.75, ts=8:19)
perform_test(income.females, fig_name = "feqr_women_25", tau=0.25, ts=8:19)
perform_test(income.females, fig_name = "feqr_women_10", tau=0.1, ts=8:19)
perform_test(income.females, fig_name = "feqr_women_90", tau=0.9, ts=8:19)


