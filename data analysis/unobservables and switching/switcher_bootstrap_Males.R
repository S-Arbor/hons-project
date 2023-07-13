library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income <- read_dta("male_private_resid.dta")
# income$experience_cat <- cut(income$experience, breaks=c(0:3, seq(4,8,2), seq(10,40,5), 55))
# table(income$experience_cat)

income$leading_moved_public = as.factor(income$leading_moved_public)

inc_subs = income[income$leading_employer_change_reported == 1 & income$real_wage< 150,]
ggplot(inc_subs[inc_subs$leading_moved_public == 0,]) + aes(x=real_wage, y=m4_res, alpha=0.5) +
  geom_point(alpha=0.2) +
  geom_smooth(alpha=0.2, method="loess") +
  geom_point(data=inc_subs[inc_subs$leading_moved_public == 1,], aes(colour="red")) +
  geom_smooth(data=inc_subs[inc_subs$leading_moved_public == 1,], aes(colour="red"), method="loess")

mean(income[income$leading_moved_public == 1,]$m4_res)
mean(income[income$leading_moved_public == 0 & income$leading_employer_change_reported == 1,]$m4_res)

ggplot(income, aes(log_real_wage, m4_res)) +
  geom_point()

income <- income %>%
  group_by(wave, industry, occupation) %>%
  mutate(subset_id = cur_group_id())

income$idx <- 1:nrow(income)

## The number of individuals with different numbers of observations in this sample
table(data.frame(table(income$subset_id))$Freq)
## Number of moves in the sample
table(income$leading_moved_public)

comparable_individuals = list()
for (i in 1:sum(income$leading_moved_public)) {
  row = income[income$leading_moved_public == 1,][i,]
  group = row$subset_id
  pred_wage = row$m5_pred
  min_pred_wage = 0.95 * pred_wage
  max_pred_wage = 1.05 * pred_wage
  similar_indi = income[income$subset_id == group & income$m5_pred > min_pred_wage & income$m5_pred < max_pred_wage,]
  comparable_individuals[[i]] = similar_indi$idx
}
