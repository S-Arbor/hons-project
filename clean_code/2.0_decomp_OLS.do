// This file contains the basic OLS regressions of the project by gender and then presents decompositions

// Controls:
// M1: sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave
// M2: sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer

// For oaxaca replace i.wave with w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 since it does not accept factors

// use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v4/basic_cleaned.dta", clear
use "/home/sean/Code/honours/hons-project/cleaned_data/v4/basic_cleaned.dta", clear

eststo clear

// 1. BO decomposition
// weight(1) ensures that public sector coefficients are used as the reference group

// Men with occupation
oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo oax_men_oc

// Men short
oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 if sex_male == 1 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo oax_men_short

// Women with occupation
oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo oax_women_oc

// Women short
oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 if sex_male == 0 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo oax_women_short

//esttab
esttab oax_men_oc oax_men_short oax_women_oc oax_women_short using "/home/sean/Code/honours/hons-project/output_tables_v2/decomp/oax_full.csv", replace label se star(* 0.1 ** 0.05 *** 0.01) nogaps

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid)
eststo men_full_decomp

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid)
eststo women_full_decomp
esttab men_full_decomp women_full_decomp using "/home/sean/Code/honours/hons-project/output_tables_v2/decomp/full_decomp.tex", replace label se star(* 0.1 ** 0.05 *** 0.01) nogaps wide
