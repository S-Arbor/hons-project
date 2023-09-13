library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income <- read_dta("basic_cleaned.dta")
income$one <- 1

individuals <- income %>%
  group_by(xwaveid) %>%
  summarise(mean_wage=mean(real_wage), years=sum(one), sector_public=mean(sector_public),
            edu_uni=mean(edu_uni), edu_diploma_cert=mean(edu_diploma_cert), edu_y12_or_less=mean(edu_y12_or_less),
            sex_male=mean(sex_male), age=mean(age))

subs <- individuals[individuals$sex_male==1 & individuals$years>10 & (individuals$sector_public == 1 | individuals$sector_public==0) & individuals$edu_uni == 1,]
subs$sector_public <- as.factor(subs$sector_public)
ggplot(data=subs, aes(x=mean_wage, colour=sector_public)) +
  geom_density()
ggplot(data=subs, aes(x=age, colour=sector_public)) +
  geom_density()

ggplot(data=subs[subs$age <= 35,], aes(x=mean_wage, colour=sector_public)) +
  geom_density()

income$sector_public <- as.factor(income$sector_public)
ggplot(data=income[income$sex_male == 1,], aes(x=log_real_wage, colour=sector_public)) +
  geom_density()
