* File does the essential cleaning of combining seperate instances of sector and English speaking ability
* It then renames and recodes several variables
* Observations are not dropped here as that will be handled in R

clear
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/alternate_longfile.dta"
*use "/home/sean/Code/honours/hons-project/cleaned_data/v3/base_longfile.dta"

*rename variables

rename (jbmhruc wscmei hgage ehtjb tcr jbempt jbmi61 jbmo61) (main_hours main_income age experience n_resident_children tenure industry occupation)
rename(jbhruc wscei hgsex) (all_hours all_wages sex)

*save "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta"
*save "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/alternate_cleaned.dta"

generate wage = main_income / main_hours if main_hours >= 1 & main_income >= 1

generate log_wage = log(wage)

regress log_wage industry



// THIS FILE IS UNRESTRICTED SO SUPEr eZ to get wacky results (e.g. regressing wage on industry with r-squared of 0.2)
