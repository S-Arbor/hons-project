clear

// see https://www.princeton.edu/~otorres/Panel101.pdf

*use "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta"
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta"

generate xwaveid_int = real(xwaveid)
tsset xwaveid_int wave


xtreg log_real_wage experience experience_sq if sex_male == 1, fe
estimates store fixed
xtreg log_real_wage experience experience_sq if sex_male == 1, re
estimates store random

// If Prob > chi2 is < 0.05 use fixed effects
hausman fixed random, sigmamore


xtreg log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1, fe
estimates store fixed_2
xtreg log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual union_yes ind_wholesale ind_finance ind_education ind_mine ind_retail ind_housing ind_health ind_manufact ind_accomo_food ind_prof_sci_technical ind_arts_rec ind_utilities ind_logistics ind_admin ind_other_unknown ind_construct ind_it ind_public_admin occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1, re
estimates store random_2
hausman fixed_2 random_2, sigmamore
