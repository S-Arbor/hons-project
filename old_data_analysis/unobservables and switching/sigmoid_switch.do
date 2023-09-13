clear

use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta"

generate xwaveid_int = real(xwaveid)
tsset xwaveid_int wave

bysort xwaveid (wave): gen leading_sector_public_reported = sector_public[_n+1] == 1 if sector_public[_n+1] != .
bysort xwaveid (wave): gen leading_employer_change_reported = changed_employer[_n+1] == 1 if changed_employer[_n+1] != .

keep if sector_private == 1


keep if leading_sector_public_reported != . & leading_employer_change_reported != .

tab leading_sector_public_reported leading_employer_change_reported

generate leading_moved_public = leading_employer_change_reported & leading_sector_public_reported
tab leading_moved_public

// twoway (histogram real_wage if leading_moved_public==1, start(0) width(3) color(red%30)) ///        
//        (histogram real_wage if leading_moved_public==0, start(0) width(3) color(green%30)), ///   
// 	   legend(order(1 "Moved to public" 2 "Stayed in private"))
//
// twoway (histogram real_wage if leading_moved_public==1, start(0) width(3) color(red%30)) ///        
//        (histogram real_wage if leading_moved_public==0 & leading_employer_change_reported == 1, start(0) width(3) color(green%30)), /// 
//        legend(order(1 "Moved to public" 2 "Moved within private"))
	   
	   //	   
// twoway (histogram real_wage if leading_moved_public==1, start(0) width(5) color(red%30)) ///        
//        (histogram real_wage if leading_moved_public==0, start(0) width(5) color(green%30)), ///   
//        legend(order(1 "Moved to public" 2 "Stayed" ))

logistic leading_moved_public real_wage experience if sex_male == 1
logistic leading_moved_public real_wage experience if sex_female == 1

generate real_wage_sq = real_wage ^ 2

logistic leading_moved_public real_wage real_wage_sq experience if sex_male == 1
logistic leading_moved_public real_wage real_wage_sq experience if sex_female == 1

logistic leading_moved_public log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT if sex_male == 1, vce(robust)

logistic leading_moved_public log_real_wage experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT if sex_female == 1, vce(robust)

save "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/private_only_with_leavers.dta"
