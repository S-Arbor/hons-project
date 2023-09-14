// This file contains the quantile regressions and decompositions for men and women with and without occupation

use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v4/basic_cleaned.dta", clear


// Men without occupation
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave if sex_male == 1 [pw=hhwtrp], quantile(0.1, 0.25, 0.5, 0.75, 0.9) vce(bootstrap, cluster(xwaveid_factor))

// Men with occupation
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 [pw=hhwtrp], quantile(0.1, 0.25, 0.5, 0.75, 0.9) vce(bootstrap, cluster(xwaveid_factor))

// Women without occupation
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave if sex_male == 0 [pw=hhwtrp], quantile(0.1, 0.25, 0.5, 0.75, 0.9) vce(bootstrap, cluster(xwaveid_factor))

// Women with occupation
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 [pw=hhwtrp], quantile(0.1, 0.25, 0.5, 0.75, 0.9) vce(bootstrap, cluster(xwaveid_factor))


// decompositions
// men without occupation
cdeco log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave if sex_male == 1 [pw=hhwtrp], group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) noboot

// repeat




