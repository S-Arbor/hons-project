// This file contains the basic OLS regressions of the project by gender and then presents decompositions

*use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta", clear
use "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta", replace


// decompositions
// men without occupation

// rm'd vars shiftwork_yes and casual from all
// casual currently just in waves 1-5 PLEASe FIX, just needed results, make sure consistent model
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT  parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=1 & wave <=5, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=6 & wave <=10, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=11 & wave <=15, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=16 & wave <=19, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

// but this model did not work for women
// therefore restricted model
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus birth_eng birth_neng married_yes married_sep urban_no parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=1 & wave <=5 & shiftwork_yes == 0 & casual==0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus birth_eng birth_neng married_yes married_sep urban_no parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=6 & wave <=10 & shiftwork_yes == 0 & casual==0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus birth_eng birth_neng married_yes married_sep urban_no parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=11 & wave <=15 & shiftwork_yes == 0 & casual==0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus birth_eng birth_neng married_yes married_sep urban_no parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=16 & wave <=19 & shiftwork_yes == 0 & casual==0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

// women with restricted model
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus birth_eng birth_neng married_yes married_sep urban_no parttime long_hours [pw=hhwtrp] if sex_male == 0 & wave>=1 & wave <=5 & shiftwork_yes == 0 & casual==0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus birth_eng birth_neng married_yes married_sep urban_no parttime long_hours [pw=hhwtrp] if sex_male == 0 & wave>=6 & wave <=10 & shiftwork_yes == 0 & casual==0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus birth_eng birth_neng married_yes married_sep urban_no parttime long_hours [pw=hhwtrp] if sex_male == 0 & wave>=11 & wave <=15 & shiftwork_yes == 0 & casual==0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus birth_eng birth_neng married_yes married_sep urban_no parttime long_hours [pw=hhwtrp] if sex_male == 0 & wave>=16 & wave <=19 & shiftwork_yes == 0 & casual==0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot


// men but not removing problematic variables
rqdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes casual parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=1 & wave <=5, by(sector_private) quantile(0.5)




eststo clear
