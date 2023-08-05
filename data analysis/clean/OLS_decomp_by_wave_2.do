// This file contains the basic OLS regressions of the project by gender and then presents decompositions
// Current issues:
// Include tenure as specificity test
// Should errors be boot strapped rather than robust
// Should I drop waves 20-21

use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta", clear



// Men without occupation
forval i=1/15 {
	display "5 year pool centred on:"
	display `i' + 2
	oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual if sex_male == 1 & wave >= `i' & wave <= (`i' + 4) [pw=hhwtrp], by(sector_private) weight(1) nodetail // vce(bootstrap)
	eststo
}


esttab using "tester.tex", keep(unexplained)
