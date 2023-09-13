library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income_raw <- read_dta("basic_cleaned.dta")

income <- income_raw %>%
  mutate_at(c("edu", "children_cat", "birth", "married", "state"), as.factor)
income$wave_dummies <- as.factor(income$wave)
income$wave_sq <- income$wave ^ 2

# wage
no_wave_model <- lm(log_wage ~ sector_public + experience + experience_sq +
                           edu + children_cat + birth + married + urban_no + state +
                           shiftwork_yes + parttime + long_hours + casual,
                         data=income[income$sex_male==1,])
wave_dummies_model <- lm(log_wage ~ sector_public + experience + experience_sq +
                           edu + children_cat + birth + married + urban_no + state +
                           shiftwork_yes + parttime + long_hours + casual + wave_dummies,
                         data=income[income$sex_male==1,])
wave_term_model <- lm(log_wage ~ sector_public + experience + experience_sq +
                           edu + children_cat + birth + married + urban_no + state +
                           shiftwork_yes + parttime + long_hours + casual + wave,
                         data=income[income$sex_male==1,])

anova(wave_term_model, wave_dummies_model)
anova(no_wave_model, wave_dummies_model)

# real wage
no_wave_model <- lm(log_real_wage ~ sector_public + experience + experience_sq +
                      edu + children_cat + birth + married + urban_no + state +
                      shiftwork_yes + parttime + long_hours + casual,
                    data=income[income$sex_male==1,])
wave_dummies_model <- lm(log_real_wage ~ sector_public + experience + experience_sq +
                           edu + children_cat + birth + married + urban_no + state +
                           shiftwork_yes + parttime + long_hours + casual + wave_dummies,
                         data=income[income$sex_male==1,])
wave_term_model <- lm(log_real_wage ~ sector_public + experience + experience_sq +
                        edu + children_cat + birth + married + urban_no + state +
                        shiftwork_yes + parttime + long_hours + casual + wave,
                      data=income[income$sex_male==1,])
wave_term_model.2 <- lm(log_real_wage ~ sector_public + experience + experience_sq +
                        edu + children_cat + birth + married + urban_no + state +
                        shiftwork_yes + parttime + long_hours + casual + wave + wave_sq,
                      data=income[income$sex_male==1,])

anova(wave_term_model, wave_dummies_model)
anova(wave_term_model.2, wave_dummies_model)
anova(no_wave_model, wave_dummies_model)

# wpi adj wage
no_wave_model <- lm(log_wpi_adj_wage ~ sector_public + experience + experience_sq +
                      edu + children_cat + birth + married + urban_no + state +
                      shiftwork_yes + parttime + long_hours + casual, weights=hhwtrp,
                    data=income[income$sex_male==1,])
wave_dummies_model <- lm(log_wpi_adj_wage ~ sector_public + experience + experience_sq +
                           edu + children_cat + birth + married + urban_no + state +
                           shiftwork_yes + parttime + long_hours + casual + wave_dummies, weights=hhwtrp,
                         data=income[income$sex_male==1,])
wave_term_model <- lm(log_wpi_adj_wage ~ sector_public + experience + experience_sq +
                        edu + children_cat + birth + married + urban_no + state +
                        shiftwork_yes + parttime + long_hours + casual + wave, weights=hhwtrp,
                      data=income[income$sex_male==1,])

wave_term_model.2 <- lm(log_wpi_adj_wage ~ sector_public + experience + experience_sq +
                        edu + children_cat + birth + married + urban_no + state +
                        shiftwork_yes + parttime + long_hours + casual + wave + wave_sq, weights=hhwtrp,
                      data=income[income$sex_male==1,])


anova(wave_term_model, wave_dummies_model)
anova(wave_term_model.2, wave_dummies_model)
anova(no_wave_model, wave_dummies_model)
