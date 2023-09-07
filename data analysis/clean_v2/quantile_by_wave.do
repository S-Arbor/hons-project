// This file contains the basic OLS regressions of the project by gender and then presents decompositions

use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta", clear


// decompositions
// men without occupation

// rm'd vars shiftwork_yes and casual from all
// casual currently just in waves 1-5 PLEASe FIX, just needed results
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT  parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=1 & wave <=5 & casual == 0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=6 & wave <=10 & casual ==0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=11 & wave <=15, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT parttime long_hours [pw=hhwtrp] if sex_male == 1 & wave>=16 & wave <=19, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot




// cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual [pw=hhwtrp] if sex_male == 1, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

// OK, so including shiftwork causes wave 2 to error?? i cry :()

// men with occupation
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer [pw=hhwtrp] if sex_male == 1, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot


// women without occupation
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual [pw=hhwtrp] if sex_male == 0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot

// women with occupation
cdeco log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual occ_tech_trade occ_clerical_admin occ_machinery occ_prof occ_community_personal_service occ_sales occ_labourer [pw=hhwtrp] if sex_male == 0, group(sector_private) quantile(0.1, 0.25, 0.5, 0.75, 0.9) method(qr) noboot




forval i=1/21 {
	oaxaca log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual if sex_female == 1 & wave == `i' [pw=hhwtrp], by(sector_private) weight(1) nodetail // vce(bootstrap)
	eststo
}

esttab using "/Users/arbor/Documents/github repos/hons-project/data analysis/august_logs/women_no_occ_OLS.csv", replace

eststo clear
