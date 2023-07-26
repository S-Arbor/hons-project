clear

use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/male_private_resid.dta"

ttest m5_res, by(leading_moved_public)
ttest m5_res if leading_employer_change_reported==1, by(leading_moved_public)

ttest real_wage, by(leading_moved_public)
ttest real_wage if leading_employer_change_reported==1, by(leading_moved_public)

ttest log_real_wage, by(leading_moved_public)
ttest log_real_wage if leading_employer_change_reported==1, by(leading_moved_public)

probit leading_moved_public m5_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT if sex_male == 1, vce(robust)

probit leading_moved_public m5_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT if sex_male == 1 &leading_employer_change_reported == 1, vce(robust)

logistic leading_moved_public m5_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT if sex_male == 1, vce(robust)

logistic leading_moved_public m5_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT if sex_male == 1 &leading_employer_change_reported == 1, vce(robust)
