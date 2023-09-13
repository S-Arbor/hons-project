clear

*use "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta"
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta"

bysort xwaveid (wave): gen leading_sector_public = sector_public[_n+1] if wave[_n+1] == 1 + wave
bysort xwaveid (wave): gen leading_log_real_wage = log_real_wage[_n+1] if real_wage[_n+1] != . & wave[_n+1] == 1 + wave
bysort xwaveid (wave): gen leading_employer_change = changed_employer[_n+1] if wave[_n+1] == 1 + wave

generate l_moved_pub = leading_sector_public == 1 & sector_public == 0 & leading_employer_change == 1
generate l_moved_priv = leading_sector_public == 0 & sector_public == 1 & leading_employer_change == 1

save "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/movers.dta", replace
