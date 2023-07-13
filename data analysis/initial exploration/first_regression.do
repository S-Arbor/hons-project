clear

*use "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta"
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta"

*human capital
regress log_wage sector_public experience experience_sq edu_uni edu_diploma  if sex_male == 1, vce(robust)
rvfplot, yline(0)

regress log_wage sector_public experience experience_sq edu_uni edu_diploma  if sex_female == 1, vce(robust)
*rvfplot, yline(0)

*human capital + demographic
regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT i.wave if sex_male == 1, vce(robust)

regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT i.wave if sex_female == 1, vce(robust)

*human capital + demographic + basic job char
regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual i.wave if sex_male == 1, vce(robust)

regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual i.wave if sex_female == 1, vce(robust)

*human capital + demographic + basic job char + union
regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes i.wave if sex_male == 1, vce(robust)

regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes i.wave if sex_female == 1, vce(robust)

*human capital + demographic + basic job char + union + WPS
regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown i.wave if sex_male == 1, vce(robust)

regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown i.wave if sex_female == 1, vce(robust)

*human capital + demographic + basic job char + union + WPS + ind
*ind_agri ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin
regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin i.wave if sex_male == 1, vce(robust)

regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin i.wave if sex_female == 1, vce(robust)

*human capital + demographic + basic job char + union + WPS + occ
*occ_manage occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer
regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_male == 1, vce(robust)

regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_female == 1, vce(robust)

*human capital + demographic + basic job char + union + WPS + ind + occ
regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_male == 1, vce(robust)

regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes firm_size_20_99 firm_size_100_199 firm_size_200_499 firm_size_500 firm_size_unknown ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_female == 1, vce(robust)

*human capital + demographic + basic job char + union + ind + occ
regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_male == 1, vce(robust)

regress log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer i.wave if sex_female == 1, vce(robust)


*blinder-oaxaca decomp
oaxaca log_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes i.wave if sex_male == 1, by(sector_public)
