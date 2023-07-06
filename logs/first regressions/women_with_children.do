
clear
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta"

*Trying to use the children under 4 variable to test the effect on women

regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT i.wave if sex_female == 1, vce(robust)

regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_under_4 health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT i.wave if sex_female == 1, vce(robust)

regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus children_under_4 health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT i.wave if sex_female == 1, vce(robust)
