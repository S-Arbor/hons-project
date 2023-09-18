// This file contains the basic OLS regressions of the project by gender and then presents decompositions

// Controls:
// M1: sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave
// M2: sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer

// For oaxaca replace i.wave with w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 since it does not accept factors

use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v4/basic_cleaned.dta", clear
eststo clear

// 2. BO decomposition by wave
// weight(1) ensures that public sector coefficients are used as the reference group
// Men without occupation
oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w2 w3 w4 w5 if sex_male == 1 & wave >= 1 & wave <= 5 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w7 w8 w9 w10 if sex_male == 1 & wave >= 6 & wave <= 10 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w12 w13 w14 w15 if sex_male == 1 & wave >= 11 & wave <= 15 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w17 w18 w19 if sex_male == 1 & wave >= 16 & wave <= 19 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

esttab using "/Users/arbor/Documents/github repos/hons-project/data analysis/output_tables/men_no_occ_OLS_over_time.csv", replace

eststo clear

// Women without occupation
oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w2 w3 w4 w5 if sex_male == 0 & wave >= 1 & wave <= 5 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w7 w8 w9 w10 if sex_male == 0 & wave >= 6 & wave <= 10 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w12 w13 w14 w15 if sex_male == 0 & wave >= 11 & wave <= 15 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w17 w18 w19 if sex_male == 0 & wave >= 16 & wave <= 19 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

esttab using "/Users/arbor/Documents/github repos/hons-project/data analysis/output_tables/women_no_occ_OLS_over_time.csv", replace

eststo clear

// Men with occupation
oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w2 w3 w4 w5 occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 & wave >= 1 & wave <= 5 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w7 w8 w9 w10 occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 & wave >= 6 & wave <= 10 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w11 w12 w13 w14 w15 occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 & wave >= 10 & wave <= 15 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w17 w18 w19 occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 & wave >= 16 & wave <= 19 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

esttab using "/Users/arbor/Documents/github repos/hons-project/data analysis/output_tables/men_occ_OLS_over_time.csv", replace

eststo clear

// Women with occupation
oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w2 w3 w4 w5 occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 & wave >= 1 & wave <= 5 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w7 w8 w9 w10 occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 & wave >= 6 & wave <= 10 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w11 w12 w13 w14 w15 occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 & wave >= 10 & wave <= 15 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w17 w18 w19 occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 & wave >= 16 & wave <= 19 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo

esttab using "/Users/arbor/Documents/github repos/hons-project/data analysis/output_tables/women_occ_OLS_over_time.csv", replace

eststo clear
