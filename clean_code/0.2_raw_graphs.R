library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../cleaned_data/v4", sep="/"))

income <- read_dta("basic_cleaned.dta")

c_pub = "#FC0E07"
c_priv = "#00AFBB"

ggplot(income[income$sex_male == 1,], aes(x=log_real_wage, colour=factor(sector_public))) +
  geom_density() +
  scale_color_manual(values=c(c_priv, c_pub)) +
  theme_bw() +
  xlim(1.8,5.0) +
  ggtitle("Raw Distribution - Males")

ggplot(income[income$sex_female == 1,], aes(x=log_real_wage, colour=factor(sector_public))) +
  geom_density() +
  scale_color_manual(values=c(c_priv, c_pub)) +
  theme_bw() +
  xlim(1.8,5.0) +
  ggtitle("Raw Distribution - Females")

by_year <- income %>%
  group_by(wave,sex_male,sector_public) %>%
  summarise(mean_lrw=mean(log_real_wage))

male_gap = by_year$mean_lrw[by_year$sex_male == 1 & by_year$sector_public==1] - by_year$mean_lrw[by_year$sex_male == 1 & by_year$sector_public==0]
female_gap = by_year$mean_lrw[by_year$sex_male == 0 & by_year$sector_public==1] - by_year$mean_lrw[by_year$sex_male == 0 & by_year$sector_public==0]
gap = data.frame(male_gap = male_gap, female_gap=female_gap, year=2001:2019)

ggplot(gap, aes(x=year,y=male_gap)) +
  geom_line(colour="green") +
  geom_point(colour="green") +
  geom_line(aes(y=female_gap), colour="purple") +
  geom_point(aes(y=female_gap), colour="purple") +
  ylab("Raw Gap") +
  xlab("Year") +
  theme_bw()