clear

*use "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta"
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta"

keep if sex_male == 1

bysort xwaveid (wave): gen lagged_sector_public_reported = sector_public[_n-1] == 1 if sector_public[_n-1] != .
bysort xwaveid (wave): gen lagged_employer_change_reported = changed_employer[_n-1] == 1 if changed_employer[_n-1] != .
bysort xwaveid (wave): gen lagged_real_wage = real_wage[_n-1] if real_wage[_n-1] != .

keep if lagged_sector_public_reported != . & lagged_employer_change_reported != .
generate moved_private = lagged_employer_change_reported & lagged_sector_public_reported
generate real_wage_change = real_wage - lagged_real_wage
generate real_wage_change_pct = real_wage_change/lagged_real_wage

save "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/pub_to_priv.dta"
