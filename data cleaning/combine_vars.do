* File does the essential cleaning of combining seperate instances of sector and English speaking ability

clear
*use "/Users/arbor/Documents/github repos/hons/dummyvar_longfile.dta"
use "/home/sean/Code/honours/hons-project/cleaned_data/v3/base_longfile.dta"

*rename variables
rename (jbmhruc wscmei hgage ehtjb hgsex tcr jbempt) (main_hours main_income age experience sex n_resident_children tenure)

*generate sector data
generate sector_public = 0
replace sector_public = 1 if jbmmpl == 3 | jbmmplr == 3 | jbmmply == 2 | jbmmpl == 5 | jbmmplr == 5 | jbmmply == 5

generate sector_private = 0
replace sector_private = 1 if jbmmpl == 1 | jbmmplr == 1 | jbmmply == 1 | jbmmpl == 2 | jbmmplr == 2 | jbmmply == 4

generate sector_other_unknown = 0
replace sector_other_unknown = 1 if sector_private == 0 & sector_public == 0

*generate english speaking data
*aneab is missing data for wave 1, but hgeab also has some data in wave 11
generate english_poor = 0
replace english_poor = 1 if wave==1 & hgeab > 2
replace english_poor = 1 if wave!=1 & aneab > 2

generate english_unknown = 0
replace english_unknown = 1 if wave==1 & hgeab < 0
replace english_unknown = 1 if wave!=1 & aneab < 0

generate english_good = 0
replace english_good = 1 if english_poor == 0 & english_unknown == 0

*** SOMETHING IS WRONG HERE
gen c = aneab > 0 & wave==1
summarize c

save "/home/sean/Code/honours/hons-project/cleaned_data/v3/vars_combined.dta"
