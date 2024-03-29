// This file contains the basic OLS regressions of the project by gender and then presents decompositions

// Controls:
// M1: sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave
// M2: sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer

// For oaxaca replace i.wave with w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 since it does not accept factors

// use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v4/basic_cleaned.dta", clear
use "/home/sean/Code/honours/hons-project/cleaned_data/v4/basic_cleaned.dta", clear

eststo clear

// 1. Basic OLS

// Men without occupation
// regress log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave if sex_male == 1 [pw=hhwtrp], vce(cluster xwaveid)
// eststo ols_men_noc

// Men with occupation
regress log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 [pw=hhwtrp], vce(cluster xwaveid)
eststo ols_men_oc

// Men short
regress log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 1 [pw=hhwtrp], vce(cluster xwaveid)
eststo ols_men_simple

// Women without occupation
// regress log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave if sex_male == 0 [pw=hhwtrp], vce(cluster xwaveid)
// eststo ols_women_noc

// Women with occupation
regress log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 [pw=hhwtrp], vce(cluster xwaveid)
eststo ols_women_oc

// Women short
regress log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 0 [pw=hhwtrp], vce(cluster xwaveid)
eststo ols_women_simple

// Men wps union
regress log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown if sex_male == 1 [pw=hhwtrp], vce(cluster xwaveid)
eststo ols_men_wpsun

// Women wps union
regress log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown if sex_female == 1 [pw=hhwtrp], vce(cluster xwaveid)
eststo ols_women_wpsun

esttab ols_men_oc ols_men_simple ols_men_wpsun ols_women_oc ols_women_simple ols_women_wpsun using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/ols_unwps_nowave.tex", replace label  se(3) b(3) drop(*.wave) star(* 0.1 ** 0.05 *** 0.01) nogaps
// "/Users/arbor/Documents/github repos/hons-project/output_tables/cross_sect_no_decomp.csv"
/*
esttab ols_men_oc ols_men_simple ols_women_oc ols_women_simple using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/ols_sec_pub.csv", keep(sector_public) replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab ols_men_oc ols_men_simple ols_women_oc ols_women_simple using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/ols_sec_pub.tex", keep(sector_public) replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab ols_men_oc ols_men_simple ols_women_oc ols_women_simple using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/ols_full.csv", replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab ols_men_oc ols_men_simple ols_women_oc ols_women_simple using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/ols_full.tex", replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab ols_men_oc ols_men_simple ols_women_oc ols_women_simple using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/ols_no_wave.csv", replace label drop(*.wave) se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab ols_men_oc ols_men_simple ols_women_oc ols_women_simple using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/ols_no_wave.tex", replace label drop(*.wave) se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps
*/
esttab ols_men_oc ols_men_simple ols_women_oc ols_women_simple using "/Users/arbor/Documents/github repos/hons-project/output_tables_v2/dummy_var/ols_sec_pub.csv", keep(sector_public) replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab ols_men_oc ols_men_simple ols_women_oc ols_women_simple using "/Users/arbor/Documents/github repos/hons-project/output_tables_v2/dummy_var/ols_sec_pub.tex", keep(sector_public) replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab ols_men_oc ols_men_simple ols_women_oc ols_women_simple using "/Users/arbor/Documents/github repos/hons-project/output_tables_v2/dummy_var/ols_full.csv", replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab ols_men_oc ols_men_simple ols_women_oc ols_women_simple using "/Users/arbor/Documents/github repos/hons-project/output_tables_v2/dummy_var/ols_full.tex", replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab ols_men_oc ols_men_simple ols_women_oc ols_women_simple using "/Users/arbor/Documents/github repos/hons-project/output_tables_v2/dummy_var/ols_no_wave.csv", replace label drop(*.wave) se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab ols_men_oc ols_men_simple ols_women_oc ols_women_simple using "/Users/arbor/Documents/github repos/hons-project/output_tables_v2/dummy_var/ols_no_wave.tex", replace label drop(*.wave) se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

// 2. Basic Quantile

// Men with occupation
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 [pw=hhwtrp], quantile(0.1, 0.25, 0.5, 0.75, 0.9) vce(bootstrap, cluster(xwaveid_factor) reps(500))
eststo qr_men_oc

// Men short
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 1 [pw=hhwtrp], quantile(0.1, 0.25, 0.5, 0.75, 0.9) vce(bootstrap, cluster(xwaveid_factor) reps(500))
eststo qr_men_simple

// Women with occupation
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 [pw=hhwtrp], quantile(0.1, 0.25, 0.5, 0.75, 0.9) vce(bootstrap, cluster(xwaveid_factor) reps(500))
eststo qr_women_oc

// Women short
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_yes health_poor birth_eng birth_neng married_yes married_sep urban_no parttime casual tenure i.wave if sex_male == 0 [pw=hhwtrp], quantile(0.1, 0.25, 0.5, 0.75, 0.9) vce(bootstrap, cluster(xwaveid_factor) reps(500))
eststo qr_women_simple



// esttab
esttab qr_men_oc qr_men_simple qr_women_oc qr_women_simple using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/qr_sec_pub.csv", keep(sector_public) replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab qr_men_oc qr_men_simple qr_women_oc qr_women_simple using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/qr_sec_pub.tex", keep(sector_public) replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab qr_men_oc qr_men_simple qr_women_oc qr_women_simple using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/qr_full.csv", replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab qr_men_oc qr_men_simple qr_women_oc qr_women_simple using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/qr_full.tex", replace label se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab qr_men_oc qr_men_simple qr_women_oc qr_women_simple using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/qr_no_wave.csv", replace label drop(*.wave) se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab qr_men_oc qr_men_simple qr_women_oc qr_women_simple using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/qr_no_wave.tex", replace label drop(*.wave) se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps


// Extra
// Men with workplace size and union status
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown i.wave if sex_male == 1 [pw=hhwtrp], quantile(0.1, 0.25, 0.5, 0.75, 0.9) vce(bootstrap, cluster(xwaveid_factor) reps(500))
eststo qr_men_unwps

// Women with workplace size and union status
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown i.wave if sex_male == 0 [pw=hhwtrp], quantile(0.1, 0.25, 0.5, 0.75, 0.9) vce(bootstrap, cluster(xwaveid_factor) reps(500))
eststo qr_women_unwps

esttab qr_men_oc qr_men_simple qr_men_unwps qr_women_oc qr_women_simple qr_women_unwps using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/qr_unwps.csv", replace label  se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab qr_men_oc qr_men_simple qr_men_unwps qr_women_oc qr_women_simple qr_women_unwps using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/qr_unwps.tex", replace label  se(3) b(3) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab qr_men_oc qr_men_simple qr_men_unwps qr_women_oc qr_women_simple qr_women_unwps using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/qr_unwps_nowave.csv", replace label  se(3) b(3) drop(*.wave) star(* 0.1 ** 0.05 *** 0.01) nogaps

esttab qr_men_oc qr_men_simple qr_men_unwps qr_women_oc qr_women_simple qr_women_unwps using "/home/sean/Code/honours/hons-project/output_tables_v2/dummy_var/qr_unwps_nowave.tex", replace label  se(3) b(3) drop(*.wave) star(* 0.1 ** 0.05 *** 0.01) nogaps
