// This file contains the basic OLS regressions of the project by gender and then presents decompositions


// M1: sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave
// M2: sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer

//use "/home/sean/Code/honours/hons-project/cleaned_data/v4/basic_cleaned.dta", clear
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v4/basic_cleaned.dta", clear


eststo clear

xtset xwaveid_factor

// basic fe
xtreg log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1, fe
eststo men_basic_fe

xtreg log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_female == 1, fe
eststo women_basic_fe

// wave interaction
gen sector_public_times_wave = sector_public * wave
gen sector_public_times_wave_sq = sector_public * wave_sq
xtreg log_real_wage sector_public sector_public_times_wave sector_public_times_wave_sq experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1, fe
eststo men_wave_fe

xtreg log_real_wage sector_public sector_public_times_wave sector_public_times_wave_sq experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_female == 1, fe
eststo women_wave_fe

// education_interaction
gen sector_public_edu_diploma = sector_public * edu_diploma
gen sector_public_edu_uni = sector_public * edu_uni
xtreg log_real_wage sector_public sector_public_edu_diploma sector_public_edu_uni experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1, fe
eststo men_edu_fe

xtreg log_real_wage sector_public sector_public_edu_diploma sector_public_edu_uni experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0, fe
eststo women_edu_fe

// xp_interaction
gen sector_public_exp = sector_public * experience
xtreg log_real_wage sector_public sector_public_exp experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1, fe

xtreg log_real_wage sector_public sector_public_exp experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0, fe

esttab men_basic_fe men_wave_fe men_edu_fe women_basic_fe women_wave_fe women_edu_fe using "/home/sean/Code/honours/hons-project/output_tables/basic_fe.tex", cells(b se) replace

esttab men_basic_fe men_edu_fe women_basic_fe women_edu_fe using "/home/sean/Code/honours/hons-project/output_tables/basic_fe_v2.tex", cells(b se) drop(*.wave state_* children_* occ_*) replace
