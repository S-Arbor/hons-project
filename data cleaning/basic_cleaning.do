* File does the essential cleaning of combining seperate instances of sector and English speaking ability
* It then drops missing observations, codes dummies and cleans up categorical variables to have the correct levels

clear
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/base_longfile.dta"
*use "/home/sean/Code/honours/hons-project/cleaned_data/v3/base_longfile.dta"

*rename variables

rename (jbmhruc wscmei hgage ehtjb tcr jbempt jbmi61 jbmo61) (main_hours main_income age experience n_resident_children tenure industry occupation)
rename(jbhruc wscei hgsex) (all_hours all_wages sex)

*drop variables that were only used for cleaning in the rfile
drop esbrd edfts

*generate sector data
generate sector_public = 0
replace sector_public = 1 if jbmmpl == 3 | jbmmplr == 3 | jbmmply == 2 | jbmmpl == 5 | jbmmplr == 5 | jbmmply == 5
* Government business enterprise or commercial statutory authority x3 | other government organisation x3

generate sector_private = 0
replace sector_private = 1 if jbmmpl == 1 | jbmmplr == 1 | jbmmply == 1 | jbmmpl == 2 | jbmmplr == 2 | jbmmply == 4
* Private sector for profit x3 | private sector not for profit x3

*generate sector_other_unknown = 0
*replace sector_other_unknown = 1 if sector_private == 0 & sector_public == 0
drop if sector_private == 0 & sector_public == 0
* Other commercial, other non-commercial, NA

generate sector = "public"
replace sector = "private" if sector_private == 1

drop jbmmpl jbmmplr jbmmply


*generate english speaking data
*aneab is missing data for wave 1, but hgeab also has some data in wave 11
generate english_poor = 0
replace english_poor = 1 if wave==1 & (hgeab == 3 | hgeab == 4)
replace english_poor = 1 if wave!=1 & (aneab == 3 | aneab == 4)

*only ESL people were asked if their English was good
generate english_good = 0
replace english_good = 1 if english_poor == 0

generate english = "good"
replace english = "poor" if english_poor == 1
drop aneab hgeab


*experience
keep if experience >= 0
generate experience_sq = experience^2


*sex
generate sex_male = 0
replace sex_male = 1 if sex == 1

generate sex_female = 0
replace sex_female = 1 if sex == 2


*children
generate children_0 = n_resident_children == 0
generate children_1 = n_resident_children == 1
generate children_2 = n_resident_children == 2
generate children_3 = n_resident_children == 3
generate children_4_plus = n_resident_children >= 4

drop if n_resident_children < 0

generate children_cat = "0"
replace children_cat = "1" if children_1 == 1
replace children_cat = "2" if children_2 == 1
replace children_cat = "3" if children_3 == 1
replace children_cat = "4" if children_4_plus == 1


*education
generate edu = "uni"

generate edu_uni = edhigh1 == 1 | edhigh1 == 3

generate edu_diploma_cert = edhigh1 == 2 | edhigh1 == 4 | edhigh1 == 5
replace edu = "diploma_cert" if edu_diploma_cert == 1

generate edu_y12_or_less = edhigh1 == 8 | edhigh1 == 9
replace edu = "y12_or_less" if edu_y12_or_less == 1

keep if edu_uni == 1 | edu_diploma_cert == 1 | edu_y12_or_less == 1
drop edhigh1


*health
generate health_good = 0
replace health_good = 1 if helth == 2

generate health_poor = 0
replace health_poor = 1 if helth == 1

keep if health_good == 1 | health_poor == 1
drop helth


*country of birth
generate birth_aus = 0
replace birth_aus = 1 if anbcob == 1

generate birth_eng = 0
replace birth_eng = 1 if anbcob == 2

generate birth_neng = 0
replace birth_neng = 1 if anbcob == 3

keep if birth_aus == 1 | birth_eng == 1 | birth_neng == 1

generate birth = "aus"
replace birth = "eng" if birth_eng == 1
replace birth = "non eng" if birth_neng == 1
drop anbcob


*industry
replace industry = 19 if industry < 0
gen ind_agri = 1.industry
gen ind_mine = 2.industry
gen ind_manufact = 3.industry
gen ind_utilities = 4.industry
gen ind_construct = 5.industry
gen ind_wholesale = 6.industry
gen ind_retail = 7.industry
gen ind_accomo_food = 8.industry
gen ind_logistics = 9.industry
gen ind_it = 10.industry
gen ind_finance = 11.industry
gen ind_housing = 12.industry
gen ind_prof_sci_technical = 13.industry
gen ind_admin = 14.industry
gen ind_public_admin = 15.industry
gen ind_education = 16.industry
gen ind_health = 17.industry
gen ind_arts_rec = 18.industry
gen ind_other_unknown = 19.industry


*occupation
keep if occupation > 0
gen occ_manage = 1.occupation
gen occ_prof = 2.occupation
gen occ_tech_trade = 3.occupation
gen occ_community_personal_service = 4.occupation
gen occ_clerical_admin = 5.occupation
gen occ_sales = 6.occupation
gen occ_machinery = 7.occupation
gen occ_labourer = 8.occupation
*tabulate occupation, summarize(psec)


*marriage
gen married = "yes"

gen married_yes = mrcurr == 1 | mrcurr == 2

gen married_sep = mrcurr == 3 | mrcurr == 4 | mrcurr == 5
replace married = "seperated" if married_sep == 1

gen married_never = mrcurr == 6
replace married = "never" if married_never == 1

drop if mrcurr < 0
drop mrcurr

*large capital (using hhssos instead)
drop hhsgcc
**generate large_capital = 0
**replace large_capital = 1 if hhsgcc == 11 | hhsgcc == 21 | hhsgcc == 31 | hhsgcc == 41 | hhsgcc == 51
**generate large_capital_unknown = 0
**replace large_capital_unknown = 1 if hhsgcc < 0


* urban
generate urban_yes = 0
replace urban = 1 if hhssos == 0 | hhssos == 1

generate urban_no = hhssos > 1

drop if hhssos < 0
drop hhssos

*state
keep if hhstate > 0
gen state_NSW = 1.hhstate
gen state_VIC = 2.hhstate
gen state_QLD = 3.hhstate
gen state_SA = 4.hhstate
gen state_WA = 5.hhstate
gen state_TAS = 6.hhstate
gen state_NT = 7.hhstate
gen state_ACT = 8.hhstate

rename hhstate state


*shiftwork
keep if jbmsch > 0

generate shiftwork_yes = 1
replace shiftwork_yes = 0 if jbmsch == 1

generate shiftwork_no = 0
replace shiftwork_no = 1 if shiftwork_yes == 0

drop jbmsch


*firm size
*jbmwpsz for waves 1-4
*jbmwps for waves 5-21
generate firm_size = "unknown"
replace firm_size = "1-20" if jbmwpsz >= 1 & jbmwpsz <= 3 
replace firm_size = "1-20" if jbmwps >= 1 & jbmwps <= 4 

replace firm_size = "20-99" if jbmwpsz == 4 | jbmwpsz == 5
replace firm_size = "20-99" if jbmwps == 5 | jbmwps == 6

replace firm_size = "100-199" if jbmwpsz == 6
replace firm_size = "100-199" if jbmwps == 7

replace firm_size = "200-499" if jbmwpsz == 7
replace firm_size = "200-499" if jbmwps == 8

replace firm_size = "500+" if jbmwpsz == 8
replace firm_size = "500+" if jbmwps == 9

generate firm_size_1_20 = firm_size == "1-20"
generate firm_size_20_99 = firm_size == "20-99"
generate firm_size_100_199 = firm_size == "100-199"
generate firm_size_200_499 = firm_size == "200-499"
generate firm_size_500 = firm_size == "500+"
generate firm_size_unknown = firm_size == "unknown"

drop jbmwps jbmwpsz

*drop if firm_size == "unknown"
*<20, 20-99, 100-199, 200-499, 500+, unknown


*self employed
keep if esempst == 1
drop esempst


*union
keep if jbmtuea > 0
generate union_yes = 0
replace union_yes = 1 if jbmtuea == 1

generate union_no = 0
replace union_no = 1 if union_yes == 0

drop jbmtuea

*part time and long hours
generate parttime = main_hours < 35
generate partime_no = main_hours >= 35

generate long_hours = main_hours >= 41


*casual
generate casual = jbcasab == 1
generate casual_no = jbcasab == 2
drop if casual ==0 & casual_no == 0
drop jbcasab


*changed employer
generate changed_employer = .
replace changed_employer = 1 if pjsemp == 2
replace changed_employer = 0 if pjsemp == 1
drop pjsemp


*income and wage
keep if main_hours >= 5
keep if main_hours <= 60

keep if main_income >= 1

generate wage = main_income / main_hours
generate log_wage = log(wage)

generate real_wage = wage * 100 / cpi
generate log_real_wage = log(real_wage)

summarize

*save "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta"
save "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta"
