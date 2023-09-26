library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../cleaned_data/v4", sep="/"))

income <- read_dta("basic_cleaned.dta")


quantiles = c(0.1, 0.25, 0.5, 0.75, 0.9, 0.1, 0.25, 0.5, 0.75, 0.9)
Gender = c(rep("Male", 5), rep("Female", 5))
estimates = c(0.082, 0.087, 0.074, 0.016, -0.065,
              0.09, 0.123, 0.143, 0.126, 0.066)

decomp = data.frame(quantiles, Gender, estimates)

c_men = "#00AFBB"
c_women = "#FC0E07"
ggplot(decomp, aes(x=quantiles, y=estimates, colour=Gender)) +
  geom_line() +
  geom_point() +
  scale_color_manual(values=c(c_women, c_men)) +
  theme_bw() +
  ggtitle("Decomposition Estimates of the Wage Differential") +
  xlab("Quantile") +
  ylab("Estimated Wage Differential") +
  geom_hline(yintercept=0.04, colour=c_men, linetype="dashed") +
  geom_hline(yintercept=0.106, colour=c_women, linetype="dashed")

decomp_over_time_dat <- read_csv("../../findings_presentation/Decomp_over_time.csv")

data_long <- gather(decomp_over_time_dat, quantile, wage_differential, Mean:Q90, factor_key=TRUE)
data_long           

par(mfrow=c(1,2))
ggplot(data_long[data_long$Gender == "Male" & data_long$quantile != "Q90" & data_long$quantile != "Q10",], aes(x=Period, y=wage_differential, colour=quantile)) +
  geom_line() +
  geom_point() +
  theme_bw() +
  ggtitle("Decomposition Estimates of the Wage Differential Over Time (Men)") +
  xlab("Period") +
  ylab("Estimated Wage Differential")

ggplot(data_long[data_long$Gender == "Female" & data_long$quantile != "Q90" & data_long$quantile != "Q10",,], aes(x=Period, y=wage_differential, colour=quantile)) +
  geom_line() +
  geom_point() +
  theme_bw() +
  ggtitle("Decomposition Estimates of the Wage Differential Over Time (Women)") +
  xlab("Period") +
  ylab("Estimated Wage Differential")

fe_over_time_dat <- read_csv("../../findings_presentation/fe_prem_over_time.csv")
ggplot(data=fe_over_time_dat, aes(x=Wave,y=Premium,colour=Gender)) +
  geom_line() +
  scale_color_manual(values=c(c_women, c_men)) +
  theme_bw() +
  ggtitle("Decomposition Estimates of the Wage Differential") +
  xlab("Wave") +
  ylab("Estimated Wage Differential")
