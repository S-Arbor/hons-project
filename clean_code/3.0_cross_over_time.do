// This file contains the quantile regressions and decompositions for men and women with and without occupation

// use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v4/basic_cleaned.dta", clear
use "/home/sean/Code/honours/hons-project/cleaned_data/v4/basic_cleaned.dta", clear

tabulate wave, generate(wave_)

// Comparing full and reduced model
// men
// cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 1 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot
//
// cdeco log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave if sex_male == 1 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot
//
// // women
// cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 0 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot
//
//
// cdeco log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave if sex_male == 0 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot

// killed vars
// i.wave for wave and wave_sq
// long hours not significant
// children down to just children_0
// state (not strongly correlated with working in the public sector (except ACT and NT))


// OLS
// men
oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave_2 wave_3 wave_4 wave_5 if sex_male == 1 & wave >= 1 & wave <= 5 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo oax_men_1

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave_10 wave_7 wave_8 wave_9 if sex_male == 1 & wave >= 6 & wave <= 10 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo oax_men_6

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave_15 wave_12 wave_13 wave_14 if sex_male == 1 & wave >= 11 & wave <= 15 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo oax_men_11

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave_17 wave_18 wave_19 if sex_male == 1 & wave >= 16 & wave <= 19 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo oax_men_16

// women
oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave_2 wave_3 wave_4 wave_5 if sex_male == 0 & wave >= 1 & wave <= 5 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo oax_women_1

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave_7 wave_8 wave_9 wave_10 if sex_male == 0 & wave >= 6 & wave <= 10 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo oax_women_6

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave_12 wave_13 wave_14 wave_15 if sex_male == 0 & wave >= 11 & wave <= 15 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo oax_women_11

oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure wave_17 wave_18 wave_19 if sex_male == 0 & wave >= 16 & wave <= 19 [pw=hhwtrp], by(sector_private) weight(1) vce(cluster xwaveid) nodetail
eststo oax_women_16

// Quantile Regression

// men for diff waves
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 1 & wave >= 1 & wave <= 5 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) reps(250)
eststo qr_men_1

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 1 & wave >= 6 & wave <= 10 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) reps(250)
eststo qr_men_6

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 1 & wave >= 11 & wave <= 15 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) reps(250)
eststo qr_men_11

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 1 & wave >= 16 & wave <= 19 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) reps(250)
eststo qr_men_16

// women for diff waves
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 0 & wave >= 1 & wave <= 5 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) reps(250)
eststo qr_women_1

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 0 & wave >= 6 & wave <= 10 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) reps(250)
eststo qr_women_6

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 0 & wave >= 11 & wave <= 15 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) reps(250)
eststo qr_women_11

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 0 & wave >= 16 & wave <= 19 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) reps(250)
eststo qr_women_16

// esttab

esttab oax_men_1 oax_men_6 oax_men_11 oax_men_16 oax_women_1 oax_women_6 oax_women_11 oax_women_16 using "/home/sean/Code/honours/hons-project/output_tables_v2/over_time/oax_full_3dp.csv", replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab oax_men_1 oax_men_6 oax_men_11 oax_men_16 oax_women_1 oax_women_6 oax_women_11 oax_women_16 using "/home/sean/Code/honours/hons-project/output_tables_v2/over_time/oax_full.csv", replace label se star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab qr_men_1 qr_men_6 qr_men_11 qr_men_16 qr_women_1 qr_women_6 qr_women_11 qr_women_16 using "/home/sean/Code/honours/hons-project/output_tables_v2/over_time/qrd_full_3dp.csv", replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab qr_men_1 qr_men_6 qr_men_11 qr_men_16 qr_women_1 qr_women_6 qr_women_11 qr_women_16 using "/home/sean/Code/honours/hons-project/output_tables_v2/over_time/qrd_full.csv", replace label se b star(* 0.1 ** 0.05 *** 0.01) nogaps

