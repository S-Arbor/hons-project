clear
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/lagged_movers.dta"


*histogram real_wage_change if moved_into_public_sector == 1, kdensity
*histogram real_wage_change if moved_into_private_sector == 1, kdensity

twoway (histogram real_wage_change if moved_into_public_sector==1, width(3) color(red%30)) ///        
       (histogram real_wage_change if moved_into_private_sector==1, width(3) color(green%30)), ///   
       legend(order(1 "Into Public" 2 "Out of Public" )) ///
	   name("Lag_1", replace)

// this doesn't show anything because it is contigent on age moved, if young people leave pub sector they have more room for wage growth than old people joining public

twoway (histogram real_wage_change_10_year if lag10_into_pub==1 & real_wage_change_10_year > -200 & real_wage_change_10_year < 200, width(3) color(red%30)) ///        
       (histogram real_wage_change_10_year if lag10_into_priv==1 & real_wage_change_10_year > -200 & real_wage_change_10_year < 200, width(3) color(green%30)), ///   
       legend(order(1 "Into Public" 2 "Out of Public" )) ///
	   name("Lag_10", replace)
