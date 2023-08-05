library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income <- read_dta("pub_to_priv.dta")
income$experience_cat <- cut(income$experience, breaks=c(0:3, seq(4,8,2), seq(10,40,5), 55))
table(income$experience_cat)

# Males
income.males <- income[income$sex_male == 1,]
income.males <- income.males %>%
  group_by(wave, experience_cat, edu, married_yes, married_sep) %>%
  mutate(subset_id = cur_group_id())

## The number of individuals with different numbers of observations in this sample
table(data.frame(table(income.males$xwaveid))$Freq)
## Number of moves in the sample
table(income.males$leading_moved_public)

groups.males = list()
for (i in 1:sum(income$leading_moved_public)) {
  row = income[income$leading_moved_public==1,][i,]
  
  
}


# Females
income.females <- income[income$sex_female == 1,]

## The number of individuals with different numbers of observations in this sample
table(data.frame(table(income.males$xwaveid))$Freq)
# Number of moves in the sample
table(income.females$leading_moved_public)
