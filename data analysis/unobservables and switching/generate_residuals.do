clear

*use "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta"
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta"

keep if sex_male == 1

bysort xwaveid (wave): gen leading_sector_public_reported = sector_public[_n+1] == 1 if sector_public[_n+1] != .
bysort xwaveid (wave): gen leading_employer_change_reported = changed_employer[_n+1] == 1 if changed_employer[_n+1] != .

keep if sector_private == 1

*human capital
regress log_real_wage experience experience_sq edu_uni edu_diploma  if sex_male == 1, vce(robust)

predict m1_pred
predict m1_res, residuals


*human capital + demographic
regress log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT i.wave if sex_male == 1, vce(robust)

predict m2_pred
predict m2_res, residuals

*human capital + demographic + basic job char
regress log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual i.wave if sex_male == 1, vce(robust)

predict m3_pred
predict m3_res, residuals

// *human capital + demographic + basic job char + union
// regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes i.wave if sex_male == 1, vce(robust)
//
// regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes i.wave if sex_female == 1, vce(robust)
//
// *human capital + demographic + basic job char + union + WPS
// regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown i.wave if sex_male == 1, vce(robust)
//
// regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown i.wave if sex_female == 1, vce(robust)
//
// *human capital + demographic + basic job char + union + WPS + ind
// *ind_agri ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin
// regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin i.wave if sex_male == 1, vce(robust)
//
// regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin i.wave if sex_female == 1, vce(robust)
//
// *human capital + demographic + basic job char + union + WPS + occ
// *occ_manage occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer
// regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_male == 1, vce(robust)

*human capital + demographic + basic job char + union + WPS + ind + occ
regress log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_male == 1, vce(robust)

predict m4_pred
predict m4_res, residuals

*human capital + demographic + basic job char + union + ind + occ
regress log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_male == 1, vce(robust)

predict m5_pred
predict m5_res, residuals

*human capital + demographic + basic job char + union + ind + occ + pay_sat
regress log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave pay_sat if sex_male == 1, vce(robust)

predict m6_pred
predict m6_res, residuals

// restrict sample for analysis on those who we have movement information on
keep if leading_sector_public_reported != . & leading_employer_change_reported != .

generate leading_moved_public = leading_employer_change_reported & leading_sector_public_reported


tab leading_moved_public, summarize(m1_res)
ttest m1_res if leading_employer_change_reported==1, by(leading_moved_public)

tab leading_moved_public, summarize(m2_res)
ttest m2_res if leading_employer_change_reported==1, by(leading_moved_public)

tab leading_moved_public, summarize(m3_res)
ttest m3_res if leading_employer_change_reported==1, by(leading_moved_public)

tab leading_moved_public, summarize(m4_res)
ttest m4_res if leading_employer_change_reported==1, by(leading_moved_public)

tab leading_moved_public, summarize(m4_res)
ttest m4_res if leading_employer_change_reported==1 & real_wage < 100 & real_wage > 20, by(leading_moved_public)

tab leading_moved_public, summarize(m4_res)
ttest real_wage if leading_employer_change_reported==1 & real_wage < 100 & real_wage > 20, by(leading_moved_public)
ttest real_wage, by(leading_moved_public)

tab leading_moved_public, summarize(m5_res)
ttest m5_res if leading_employer_change_reported==1 & wave==19, by(leading_moved_public)

ttest m6_res if leading_employer_change_reported==1, by(leading_moved_public)


// now need to run the same test on comparable candidates (i.e. not people in high paying jobs unlikely to move)


probit leading_moved_public m5_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT if sex_male == 1, vce(robust)

probit leading_moved_public m5_res experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT if sex_male == 1 &leading_employer_change_reported == 1, vce(robust)


save "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/male_private_resid.dta"
*save "/home/sean/Code/honours/hons-project/cleaned_data/v3/male_private_resid.dta"
