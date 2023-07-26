// This file contains the basic OLS regressions of the project by gender and then presents decompositions
// Current issues:
// Include tenure as specificity test
// Should errors be boot strapped rather than robust
// Should I drop waves 20-21

use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta", clear

// Size of pooling
// By testing with waves 1-5 as pooling size went from 1 to 5 standard error went from around 0.025 to around 0.01
// oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual if sex_male == 1 & (wave == 1 | wave == 2 | wave == 3 | wave == 4 | wave==5), by(sector_private) weight(1) nodetail vce(bootstrap, reps(100))


// Men without occupation
forval i=1/15 {
	display "5 year pool centred on:"
	display `i' + 2
	oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual if sex_male == 1 & wave >= `i' & wave <= (`i' + 4) [pw=hhwtrp], by(sector_private) weight(1) nodetail // vce(bootstrap)
}

// Women without occupation
forval i=1/15 {
	display "5 year pool centred on:"
	display `i' + 2
	oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual if sex_male == 0 & wave >= `i' & wave <= (`i' + 4) [pw=hhwtrp], by(sector_private) weight(1) nodetail // vce(bootstrap)
}


// Men with occupation
forval i=1/15 {
	display "5 year pool centred on:"
	display `i' + 2
	oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual occ_machinery occ_tech_trade occ_clerical_admin  occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 1 & wave >= `i' & wave <= (`i' + 4) [pw=hhwtrp], by(sector_private) weight(1) nodetail // vce(bootstrap)
}

// Women with occupation
forval i=1/15 {
	display "5 year pool centred on:"
	display `i' + 2
	oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual occ_machinery occ_tech_trade occ_clerical_admin  occ_prof occ_community_personal_service occ_sales occ_labourer if sex_male == 0 & wave >= `i' & wave <= (`i' + 4) [pw=hhwtrp], by(sector_private) weight(1) nodetail // vce(bootstrap)
}


/// Repeat later years without topup sample
// Men without occupation (no topup)
forval i=7/15 {
	display "5 year pool centred on:"
	display `i' + 2
	oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual if sex_male == 1 & wave >= `i' & wave <= (`i' + 4) & top_up == 0 [pw=hhwtrp], by(sector_private) weight(1) nodetail // vce(bootstrap)
}

// Women without occupation
forval i=7/15 {
	display "5 year pool centred on:"
	display `i' + 2
	oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual if sex_male == 0 & wave >= `i' & wave <= (`i' + 4) & top_up == 0, by(sector_private) weight(1) nodetail // vce(bootstrap)
}
