library(haven)
library(tidyverse)
library(ggplot2)
library(ggbeeswarm)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income_raw <- read_dta("basic_cleaned.dta")
income = income[income$sex_male == 1,]

## examining satisfaction variables by pay level

income.reduced = income[income$real_wage < 400,]

breaks <- c(seq(0,100,5),seq(130,250,30), seq(300,400,50))
labels <- c((breaks[-length(breaks)] + breaks[-1]) / 2)
income.reduced$wage_cat <- cut(income.reduced$real_wage, breaks=breaks, labels = labels)

mean_responses <- income.reduced %>%
  drop_na(job_satisfaction, pay_satisfaction, chance_volun_leave, chance_find_geq_job_if_lose) %>%
  group_by(wage_cat,sector) %>%
  summarise(mean_job_sat=mean(job_satisfaction),
            mean_pay_sat= mean(pay_satisfaction),
            mean_chance_leave= mean(chance_volun_leave),
            mean_geq_job= mean(chance_find_geq_job_if_lose),
            .groups = 'drop') %>%
  as.data.frame() #%>%
mean_responses$wage_cat_int <- as.numeric(levels(mean_responses$wage_cat))[mean_responses$wage_cat]
mean_responses

ggplot(data=mean_responses, aes(x=wage_cat_int, y=mean_job_sat, colour=sector)) +
  geom_line()

ggplot(data=mean_responses, aes(x=wage_cat_int, y=mean_pay_sat, colour=sector)) +
  geom_line()

ggplot(data=mean_responses, aes(x=wage_cat_int, y=mean_chance_leave, colour=sector)) +
  geom_line()

ggplot(data=mean_responses, aes(x=wage_cat_int, y=mean_geq_job, colour=sector)) +
  geom_line()

## examining satisfaction variables by experience

income.reduced.2 = income[income$real_wage < 400,]

breaks <- c(seq(0,55,3))
labels <- c((breaks[-length(breaks)] + breaks[-1]) / 2)
income.reduced.2$experience_cat <- cut(income.reduced.2$experience, breaks=breaks, labels = labels)

mean_responses.2 <- income.reduced.2 %>%
  drop_na(job_satisfaction, pay_satisfaction, chance_volun_leave, chance_find_geq_job_if_lose) %>%
  group_by(experience_cat,sector) %>%
  summarise(mean_job_sat=mean(job_satisfaction),
            mean_pay_sat= mean(pay_satisfaction),
            mean_chance_leave= mean(chance_volun_leave),
            mean_geq_job= mean(chance_find_geq_job_if_lose),
            .groups = 'drop') %>%
  as.data.frame() #%>%
mean_responses.2$experience_cat_int <- as.numeric(levels(mean_responses.2$experience_cat))[mean_responses.2$experience_cat]
mean_responses.2

ggplot(data=mean_responses.2, aes(x=experience_cat_int, y=mean_job_sat, colour=sector)) +
  geom_line()

ggplot(data=mean_responses.2, aes(x=experience_cat_int, y=mean_pay_sat, colour=sector)) +
  geom_line()

ggplot(data=mean_responses.2, aes(x=experience_cat_int, y=mean_chance_leave, colour=sector)) +
  geom_line()

ggplot(data=mean_responses.2, aes(x=experience_cat_int, y=mean_geq_job, colour=sector)) +
  geom_line()

### also experience but now only those with uni experience

income.reduced.3 = income[income$real_wage < 400 & income$edu_uni == 1,]

breaks <- c(seq(0,55,3))
labels <- c((breaks[-length(breaks)] + breaks[-1]) / 2)
income.reduced.3$experience_cat <- cut(income.reduced.3$experience, breaks=breaks, labels = labels)

mean_responses.3 <- income.reduced.3 %>%
  drop_na(job_satisfaction, pay_satisfaction, chance_volun_leave, chance_find_geq_job_if_lose) %>%
  group_by(experience_cat,sector) %>%
  summarise(mean_job_sat=mean(job_satisfaction),
            mean_pay_sat= mean(pay_satisfaction),
            mean_chance_leave= mean(chance_volun_leave),
            mean_geq_job= mean(chance_find_geq_job_if_lose),
            .groups = 'drop') %>%
  as.data.frame() #%>%
mean_responses.3$experience_cat_int <- as.numeric(levels(mean_responses.3$experience_cat))[mean_responses.3$experience_cat]
mean_responses.3
# income[income$sector_public==1 & income$experience < 3 & income$edu_uni==1,]

ggplot(data=mean_responses.3, aes(x=experience_cat_int, y=mean_job_sat, colour=sector)) +
  geom_line()

ggplot(data=mean_responses.3, aes(x=experience_cat_int, y=mean_pay_sat, colour=sector)) +
  geom_line()

ggplot(data=mean_responses.3, aes(x=experience_cat_int, y=mean_chance_leave, colour=sector)) +
  geom_line()

ggplot(data=mean_responses.3, aes(x=experience_cat_int, y=mean_geq_job, colour=sector)) +
  geom_line()

