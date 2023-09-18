// This file contains the quantile regressions and decompositions for men and women with and without occupation

// use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v4/basic_cleaned.dta", clear
use "/home/sean/Code/honours/hons-project/cleaned_data/v4/basic_cleaned.dta", clear

gen wave_sq = wave*wave

// Comparing full and reduced model
// men
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_0 health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave wave_sq if sex_male == 1 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot

cdeco log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave if sex_male == 1 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot

// women
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_0 health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave wave_sq if sex_male == 0 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot


cdeco log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave if sex_male == 0 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot

// killed vars
// i.wave for wave and wave_sq
// long hours not significant
// children down to just children_0
// state (not strongly correlated with working in the public sector (except ACT and NT))

// men for diff waves
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_0 health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave wave_sq if sex_male == 1 & wave >= 1 & wave <= 5 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_0 health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave wave_sq if sex_male == 1 & wave >= 6 & wave <= 10 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_0 health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave wave_sq if sex_male == 1 & wave >= 11 & wave <= 15 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_0 health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave wave_sq if sex_male == 1 & wave >= 16 & wave <= 19 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot

// women for diff waves
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_0 health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave wave_sq if sex_male == 0 & wave >= 1 & wave <= 5 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_0 health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave wave_sq if sex_male == 0 & wave >= 6 & wave <= 10 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_0 health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave wave_sq if sex_male == 0 & wave >= 11 & wave <= 15 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_0 health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave wave_sq if sex_male == 0 & wave >= 16 & wave <= 19 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot



