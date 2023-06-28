clear

*use "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta"
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta"

keep if sex_male == 1

regress log_wage sector_public experience experience_sq edu_uni edu_diploma, vce(robust)
*children_1 children_2 children_3 children_4_plus

*regress log_real_wage sector_public english_poor experience experience_sq children_1 children_2 children_3 children_4_plus edu_uni edu_diploma health_poor birth_eng birth_neng married_yes married_sep urban_no shiftwork_yes union_yes if sex_female == 1
