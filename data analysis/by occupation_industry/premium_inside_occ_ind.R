library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income <- read_dta("basic_cleaned.dta")
income$pub_wage <- income$log_real_wage
income$pub_wage[income$sector_public == 0] = NA

income$priv_wage <- income$log_real_wage
income$priv_wage[income$sector_public == 1] = NA

income.males <- income[income$sex_male == 1,]


min_obs <- 10
grouped_df <- income.males %>%
  mutate(colour = as.factor(as.integer(industry))) %>%
  filter(jbmi62 > 0 & jbmo62 > 0) %>%
  group_by(jbmi62, jbmo62, colour) %>%
  summarise(mean_log_rl_wg = mean(log_real_wage),
            mean_log_rl_wg.pub = mean(pub_wage, na.rm = TRUE),
            mean_log_rl_wg.priv = mean(priv_wage, na.rm=TRUE),
            n_obs = n(),
            n_pub = sum(sector_public),
            n_priv = sum(sector_private)) %>%
  mutate(prop_pub = n_pub / n_obs) %>%
  mutate(wage_gap = mean_log_rl_wg.pub - mean_log_rl_wg.priv) %>%
  filter(n_pub > min_obs & n_priv > min_obs) %>%
  filter(mean_log_rl_wg > 1.5) ######### DROP 52 OBSERVATIONS OF SOCIAL ASSISTANCE SERVICE FACTORY PROCESS WORKERS?!?!

ggplot(data=grouped_df,aes(y = wage_gap, x = prop_pub, size=n_obs)) +
  geom_point()
ggplot(data=grouped_df,aes(y = mean_log_rl_wg, x = prop_pub, size=n_obs, colour=colour)) +
  geom_point() +
  geom_smooth(method="lm", formula=y~x, colour="black")

lm.1 <- lm(mean_log_rl_wg~prop_pub, weights=n_obs, data=grouped_df)
summary(lm.1)

lm.2 <- lm(wage_gap~prop_pub, weights=n_obs, data=grouped_df)
summary(lm.2)
