clear

*use "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta"
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta"

generate xwaveid_int = real(xwaveid)
tsset xwaveid_int wave

// 1 year lag

bysort xwaveid (wave): gen lagged_sector_public = sector_public[_n-1] if wave[_n-1] == wave - 1
bysort xwaveid (wave): gen lagged_sector_private = sector_private[_n-1] if wave[_n-1] == wave - 1
bysort xwaveid (wave): gen lagged_real_wage = real_wage[_n-1] if wave[_n-1] == wave - 1 & real_wage > 0 & real_wage[_n-1] > 0

generate moved_into_private_sector = changed_employer == 1 & lagged_sector_private == 1 & sector_public == 1
generate moved_into_public_sector = changed_employer == 1 & lagged_sector_private == 1 & sector_public == 0
generate real_wage_change = real_wage - lagged_real_wage

// 10 year lag

bysort xwaveid (wave): gen lag10_into_pub = moved_into_public_sector[_n-9] == 1 if wave[_n-9] == wave - 9
bysort xwaveid (wave): gen lag10_into_priv = moved_into_private_sector[_n-9] == 1 if wave[_n-9] == wave - 9
bysort xwaveid (wave): gen real_wage_change_10_year = real_wage - real_wage[_n-10] if wave[_n-10] == wave - 10 & real_wage > 0 & real_wage[_n-10] > 0

generate real_wage_change_10_year_log = log(real_wage_change_10_year)


save "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/lagged_movers.dta"
