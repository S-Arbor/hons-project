clear

*use "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta"
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta"

// males public
regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown if sex_male == 1 & sector_public == 1, vce(robust)

//males private
regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown if sex_male == 1 & sector_public == 0, vce(robust)

//females public
regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown if sex_female == 1 & sector_public == 1, vce(robust)

//females private
regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown if sex_female == 1 & sector_public == 0, vce(robust)
