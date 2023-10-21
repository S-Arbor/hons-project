// use "/home/sean/Code/honours/hons-project/cleaned_data/v4/basic_cleaned.dta", replace
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v4/basic_cleaned.dta", replace

eststo clear

// men
// priv to pub
regress log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 & sector_private == 1 & leading_log_real_wage < ., vce(cluster xwaveid)
eststo men_priv_wage

predict male_priv_res if sex_male == 1 & sector_private == 1 & leading_log_real_wage < ., residuals
label variable male_priv_res "Wage Residual"


probit leading_moved_public_1_year male_priv_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 & sector_private == 1 & leading_log_real_wage < ., vce(robust)
eststo men_probit_all

probit leading_moved_public_1_year male_priv_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 & sector_private == 1 & leading_changed_emp_1_year == 1, vce(robust)
eststo men_probit_move

// women

regress log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 & sector_private == 1 & leading_log_real_wage < ., vce(cluster xwaveid)
eststo women_priv_wage

predict female_priv_res if sex_male == 0 & sector_private == 1 & leading_log_real_wage < ., residuals
label variable female_priv_res "Wage Residual"

probit leading_moved_public_1_year female_priv_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 & sector_private == 1 & leading_log_real_wage < ., vce(robust)
eststo women_probit_all

probit leading_moved_public_1_year female_priv_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 & sector_private == 1 & leading_changed_emp_1_year == 1, vce(robust)
eststo women_probit_move

esttab men_priv_wage women_priv_wage using "/Users/arbor/Documents/github repos/hons-project/output_tables_v2/selection/wage_models.tex",  label se(3) b(3) r2 drop(*.wave) replace star(* 0.1 ** 0.05 *** 0.01) nogaps wide

esttab men_probit_all men_probit_move women_probit_all women_probit_move using "/Users/arbor/Documents/github repos/hons-project/output_tables_v2/selection/probit_full.tex",  label se(3) b(3) replace star(* 0.1 ** 0.05 *** 0.01) nogaps

// extra tests
probit leading_moved_public_1_year male_priv_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_male == 1 & sector_private == 1, vce(robust)


probit leading_moved_public_1_year male_priv_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_male == 1 & sector_private == 1 & leading_changed_emp_1_year == 1 , vce(robust)

probit leading_moved_public_1_year female_priv_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_male == 0 & sector_private == 1, vce(robust)

probit leading_moved_public_1_year female_priv_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_male == 0 & sector_private == 1 & leading_changed_emp_1_year == 1, vce(robust)
