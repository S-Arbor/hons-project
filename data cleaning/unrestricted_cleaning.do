* File does the essential cleaning of combining seperate instances of sector and English speaking ability
* It then renames and recodes several variables
* Observations are not dropped here as that will be handled in R

clear
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/unrestricted_longfile.dta"
*use "/home/sean/Code/honours/hons-project/cleaned_data/v3/base_longfile.dta"

*rename variables

rename (jbmhruc wscmei hgage ehtjb tcr jbempt jbmi61 jbmo61) (main_hours main_income age experience n_resident_children tenure industry occupation)
rename(jbhruc wscei hgsex) (all_hours all_wages sex)

replace industry = . if industry == -10 | industry == -1
replace industry = 19 if industry == -4 | industry == -7
tabulate industry, gen(ind)

summarize



// THIS FILE IS UNRESTRICTED SO SUPEr eZ to get wacky results (e.g. regressing wage on industry with r-squared of 0.2)

*save "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta"
*save "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/alternate_cleaned.dta"
