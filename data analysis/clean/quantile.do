// This file contains the basic OLS regressions of the project by gender and then presents decompositions
// Current issues:
// Need to figure out the correct standard errors
// https://www.stata.com/statalist/archive/2005-10/msg00754.html suggests bootstrapping may be incorrect
// but package thinks it is okay?

use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta", clear


// Men without occupation
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual if sex_male == 1 [pw=hhwtrp], quantile(0.1, 0.25, 0.5, 0.75, 0.9)

// Men with occupation
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer [pw=hhwtrp] if sex_male == 1, quantile(0.1, 0.25, 0.5, 0.75, 0.9)

// Women without occupation
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual [pw=hhwtrp] if sex_male == 0, quantile(0.1, 0.25, 0.5, 0.75, 0.9)

// Women with occupation
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer [pw=hhwtrp] if sex_male == 0, quantile(0.1, 0.25, 0.5, 0.75, 0.9)


// decompositions
// men without occupation
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual [pw=hhwtrp] if sex_male == 1, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

// men with occupation
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer [pw=hhwtrp] if sex_male == 1, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot


// women without occupation
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual [pw=hhwtrp] if sex_male == 0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

// women with occupation
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer [pw=hhwtrp] if sex_male == 0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot




