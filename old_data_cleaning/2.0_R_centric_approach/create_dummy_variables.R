# Purpose of the program:
# =======================
# This program splits the many factor variables into a long set of dummy variable columns

rm(list = ls())

library(haven)
library(tidyverse)

data_dir <- "/home/sean/Code/honours/hons-project/cleaned_data/v2"
setwd(data_dir)

base <- read_dta("base_longfile.dta")

# Take variables that don't need to be transformed
new <- base[,c("xwaveid", "jbmhruc", "wscmei", "hgage", "ehtjb", "hgsex", "tcr", "jbempt", "wave")]
colnames(new) <- c("xwaveid", "main_hours", "main_income", "age", "experience", "sex", "n_resident_children", "tenure", "wave")

missing_dat_cols <- c("age", "experience", "sex", "n_resident_children", "tenure")
for (colname in missing_dat_cols) {
  new[,paste(colname, "_unknown", sep="")] = new[,colname] < 0
}
head(new)

# Add in wage
# Code left blank for now while dealing with people who were paid for no hours

# Combine the "jbmmpl", "jbmmply" and "jbmmplr" columns
new$sector_public <- base$jbmmpl == 3 | base$jbmmplr == 3 | base$jbmmply == 2 | base$jbmmpl == 5 | base$jbmmplr == 5 | base$jbmmply == 5
new$sector_private <- base$jbmmpl == 1 | base$jbmmplr == 1 | base$jbmmply == 1 | base$jbmmpl == 2 | base$jbmmplr == 2 | base$jbmmply == 4
new$sector_unknown <- base$jbmmpl < 0 | base$jbmmplr < 0 | base$jbmmply < 0
new$sector_other <- !(new$sector_public | new$sector_private | new$sector_unknown)

sum(sum(new$sector_public), sum(new$sector_private), sum(new$sector_other)) == nrow(base)

# Split edhigh1 into dummy variables
new$ed_uni <- base$edhigh1 == 1 | base$edhigh1 == 3
new$ed_diploma_cert <- base$edhigh1 == 2 | base$edhigh1 == 4 | base$edhigh1 == 5
new$ed_y12_or_less <- base$edhigh1 == 8 | base$edhigh1 == 9
new$ed_unknown <- !(new$ed_uni | new$ed_diploma_cert | new$ed_y12_or_less)


# Split mrcurr into dummy variables
new$married <- base$mrcurr == 1 | base$mrcurr == 2
new$married_unknown <- base$mrcurr < 0

# Split helth into dummy variables
new$health_cond <- base$helth == 1
new$helth_cond_unknown <- base$helth < 0

# Combine aneab and hgeab
new$poor_english <- base$aneab > 2 | base$hgeab > 2
new$poor_english_unknown <- base$aneab < 0 | base$hgeab < 0

# Split anbcob into dummy variables
new$birth_aus <- base$anbcob == 1
new$birth_eng <- base$anbcob == 2
new$birth_neng <- base$anbcob == 3
new$birth_unknown <- base$anbcob < 0

# Split hsgcc into dummy variables
new$large_capital <- base$hhsgcc == 11 | base$hhsgcc == 21 | base$hhsgcc == 31 | base$hhsgcc == 41 | base$hhsgcc == 51
new$large_capital_unknown <- base$hhsgcc < 0

# Split hhstate into dummy variables
new$state_NSW <- base$hhstate == 1
new$state_VIC <- base$hhstate == 2
new$state_QLD <- base$hhstate == 3
new$state_SA <- base$hhstate == 4
new$state_WA <- base$hhstate == 5
new$state_TAS <- base$hhstate == 6
new$state_NT <- base$hhstate == 7
new$state_ACT <- base$hhstate == 8
new$state_unknown <- base$hhstate < 0

# Split jbmi61 into dummy variables
for (i in 1:19) {
  new[,paste("ind_",as.character(i),sep="")] = base$jbmi61 == i
}
new$ind_unknown <- base$jbmi61 < 0

# Split jbmo61 into dummy variables
for (i in 1:8) {
  new[,paste("occupation_",as.character(i),sep="")] = base$jbmo61 == i
}
new$occupation_unknown <- base$jbmo61 < 0

# Split jbmsch into dummy variables
new$shiftwork <- !(base$jbmsch == 1)
new$shiftwork_unknown <- base$jbmsch < 0
  
# Split jbmtuea into dummy variables

new$union <- base$jbmtuea == 1
new$union_unknown <- base$jbmtuea < 0

write_dta(new, "dummyvar_longfile.dta")