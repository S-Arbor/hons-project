// This file contains the basic OLS regressions of the project by gender and then presents decompositions


// M1: sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave
// M2: sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer

use "/home/sean/Code/honours/hons-project/cleaned_data/v4/basic_cleaned.dta", clear

eststo clear

xtset xwaveid_factor

// basic fe
// men to pub
xtreg log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 & mover_to_pub == 1, fe

// men to priv
xtreg log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 & mover_to_priv == 1, fe

// women to pub
xtreg log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_female == 1 & mover_to_pub == 1, fe

// women to priv
xtreg log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_female == 1 & mover_to_priv == 1, fe
// not signif but is in other specification

// education_interaction
gen sector_public_edu_diploma = sector_public * edu_diploma
gen sector_public_edu_uni = sector_public * edu_uni

// men to pub
xtreg log_real_wage sector_public sector_public_edu_diploma sector_public_edu_uni experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 & mover_to_pub == 1, fe

// men to priv
xtreg log_real_wage sector_public sector_public_edu_diploma sector_public_edu_uni experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 & mover_to_priv == 1, fe

// women to pub
xtreg log_real_wage sector_public sector_public_edu_diploma sector_public_edu_uni experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_female == 1 & mover_to_pub == 1, fe

// women to priv
xtreg log_real_wage sector_public sector_public_edu_diploma sector_public_edu_uni experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_female == 1 & mover_to_priv == 1, fe
