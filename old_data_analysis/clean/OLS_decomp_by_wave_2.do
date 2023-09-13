// This file contains the basic OLS regressions of the project by gender and then presents decompositions
// Current issues:
// Include tenure as specificity test
// Should errors be boot strapped rather than robust
// Should I drop waves 20-21

use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta", clear

eststo clear

// Men without occupation
forval i=1/21 {
	oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual if sex_male == 1 & wave == `i' [pw=hhwtrp], by(sector_private) weight(1) nodetail // vce(bootstrap)
	eststo
}

esttab using "/Users/arbor/Documents/github repos/hons-project/data analysis/august_logs/men_no_occ_OLS.csv", replace

eststo clear

// Women without occupation
forval i=1/21 {
	oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual if sex_female == 1 & wave == `i' [pw=hhwtrp], by(sector_private) weight(1) nodetail // vce(bootstrap)
	eststo
}

esttab using "/Users/arbor/Documents/github repos/hons-project/data analysis/august_logs/women_no_occ_OLS.csv", replace

eststo clear


// men no occ

// cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual [pw=hhwtrp] if sex_male == 1 & wave >= 1 & wave <= 5, group(sector_private) quantile(0.5) method(qr) noboot
// eststo

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual [pw=hhwtrp] if sex_male == 1 & wave == 2, group(sector_private) quantile(0.5) method(qr) noboot
eststo

esttab using "/Users/arbor/Documents/github repos/hons-project/data analysis/august_logs/men_no_occ_OLS.csv", replace

// stata error with this right now :


eststo clear

