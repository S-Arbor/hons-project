// This file performs the core cleaning to transform the data before analysis
// Several steps are included:

// 1. Renaming variables
// 2. Aggregating variables across waves where the naming convention changed
// 3. Dropping all individuals who misreported sector or are excluded from the
//    sample
// 4. Cleaning each variable in detail: dropping observations with missing data
//    on core variables and generating dummies and rebalancing categorical
//    variables where necessary
// 5. Create additional variables for real and logged wages as well as leading
//    indicators of whether somebody changed job


///////////////////////////////////////////
// 1. Loading and Renaming ////////////////
///////////////////////////////////////////

// use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v4/base_longfile.dta", clear
use "/home/sean/Code/honours/hons-project/cleaned_data/v4/base_longfile.dta", clear

rename (jbmhruc wscmei hgage ehtjb tcr tcr04 jbempt jbmi61 jbmo61) (main_hours main_income age experience n_resident_children n_children_under_5 tenure industry occupation)
rename (jbhruc wscei hgsex hhtup) (all_hours all_wages sex top_up)

// Just use waves 1-19 so I drop all other waves here

keep if wave < 20

///////////////////////////////////////////
// 2. Aggregating Split Variables /////////
///////////////////////////////////////////

// Some variables names change across waves, this code merges those variables

// Sector
generate sector_public = .
replace sector_public = 1 if jbmmpl == 3 | jbmmplr == 3 | jbmmply == 2 | jbmmpl == 5 | jbmmplr == 5 | jbmmply == 5
// Government business enterprise or commercial statutory authority x3 | other government organisation x3

generate sector_private = .
replace sector_private = 1 if jbmmpl == 1 | jbmmplr == 1 | jbmmply == 1 | jbmmpl == 2 | jbmmplr == 2 | jbmmply == 4
// Private sector for profit x3 | private sector not for profit x3

replace sector_public = 0 if sector_private == 1
replace sector_private = 0 if sector_public == 1

// Variable for cleaning only
generate sector_factor = .
replace sector_factor = 1 if sector_public == 1
replace sector_factor = 2 if sector_private == 1
replace sector_factor = 3 if jbmmpl == 4 | jbmmpl == 6 | jbmmplr == 4 | jbmmplr == 6 | jbmmply == 3 | jbmmply == 6


// Poor English
// aneab is missing data for wave 1
generate english_poor = 0
replace english_poor = 1 if wave==1 & (hgeab == 3 | hgeab == 4)
replace english_poor = 1 if wave!=1 & (aneab == 3 | aneab == 4)

*only ESL people were asked if their English was good
generate english_good = 0
replace english_good = 1 if english_poor == 0

drop aneab hgeab


///////////////////////////////////////////
// 3. Restrict Sample /////////////////////
///////////////////////////////////////////

// Data quality risks in the sample
// We drop all individuals who:
//     1. Report changing sector without changing employer
//     2. Ever report not knowing sector

generate changed_employer = .
replace changed_employer = 1 if pjsemp == 2
replace changed_employer = 0 if pjsemp == 1
drop pjsemp

bysort xwaveid (wave): gen changed_sector = sector_factor[_n-1] != sector_factor if sector_factor[_n-1] != . & sector_factor != .

generate sector_misreport_risk = changed_sector == 1 & changed_employer == 0
gen sector_dont_know = jbmmpl == -3 | jbmmplr == -3 | jbmmply == -3

bysort xwaveid (wave): egen tot_sector_misreport_risk = total(sector_misreport_risk)
bysort xwaveid (wave): egen tot_sector_dont_know = total(sector_dont_know)

keep if tot_sector_misreport_risk < 1
keep if tot_sector_dont_know < 1

drop jbmmpl jbmmplr jbmmply
drop tot_sector_dont_know tot_sector_misreport_risk changed_sector sector_dont_know

// Additional restrictions:
//     1. Employed
//     2. Age 22-64
//     3. Not studying full time
//     4. Has data on sector private or public
//     5. Worked 5-60 hours and earned at least $1
//     6. Not employed by own business or self-employed or unpaid family worker

keep if esbrd == 1
keep if age >= 22 & age <= 64
keep if edfts == 0
keep if sector_public == 1 | sector_private == 1
keep if main_hours >= 5 & main_hours <= 60 & main_income > 1
keep if esempst == 1

drop esbrd edfts sector_factor esempst

///////////////////////////////////////////
// 4. Clean Each Variable /////////////////
///////////////////////////////////////////

// For each variable in analysis:
//     1. Create dummies or relevel var where necessary
//     2. Drop observations with missing data

// experience
keep if experience >= 0
generate experience_sq = experience^2

// sex
generate sex_male = sex == 1
generate sex_female = sex_male == 0

// children
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

generate children_under_5 = n_children_under_5 > 0
generate children_under_5_no = n_children_under_5 == 0

generate residents_under_5 = hhyng < 5

// education
generate edu = "uni"

generate edu_uni = edhigh1 >= 1 & edhigh1 <= 3

generate edu_diploma_cert = edhigh1 == 4 | edhigh1 == 5
replace edu = "diploma_cert" if edu_diploma_cert == 1

generate edu_y12_or_less = edhigh1 == 8 | edhigh1 == 9
replace edu = "y12_or_less" if edu_y12_or_less == 1

keep if edu_uni == 1 | edu_diploma_cert == 1 | edu_y12_or_less == 1
drop edhigh1


// health
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


// industry
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

// occupation
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


// marriage
gen married = "yes"

gen married_yes = mrcurr == 1 | mrcurr == 2

gen married_sep = mrcurr == 3 | mrcurr == 4 | mrcurr == 5
replace married = "seperated" if married_sep == 1

gen married_never = mrcurr == 6
replace married = "never" if married_never == 1

drop if mrcurr < 0
drop mrcurr

// urban
// tabbing revealed hhssos was always 0-3 except 10 occurences of -7
generate urban_yes = 0
replace urban = 1 if hhssos == 0 | hhssos == 1

generate urban_no = hhssos > 1

drop if hhssos < 0
drop hhssos

// state
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

// shiftwork
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

// tenure
keep if tenure>=0

// union
// Not a core variable so I do not restrict sample based on it
// keep if jbmtuea > 0
generate union_yes = 0
replace union_yes = 1 if jbmtuea == 1

generate union_no = 0
replace union_no = 1 if union_yes == 0

drop jbmtuea

// part time and long hours
generate parttime = main_hours < 35
generate partime_no = main_hours >= 35

generate long_hours = main_hours >= 41

// casual
generate casual = jbcasab == 1
generate casual_no = jbcasab == 2
drop if casual == 0 & casual_no == 0
drop jbcasab

// wave
tabulate wave, generate(w)

///////////////////////////////////////////
// 2. Generate Additional Variables ///////
///////////////////////////////////////////

// xwaveid as factor for qrprocess
encode xwaveid, gen(xwaveid_factor)

// wave_sq for simpler model
gen wave_sq = wave*wave

// transformed wage
generate wage = main_income / main_hours
generate log_wage = log(wage)

generate real_wage = wage * 100 / cpi
generate log_real_wage = log(real_wage)

generate wpi_adj_wage = wage * 100 / wpi
generate log_wpi_adj_wage = log(wpi_adj_wage)

// generate 1 year movers
// create a leading indicator of someone's switch in sector for use in switching analysis
// additionally, create leading changing in wages
bysort xwaveid (wave): gen leading_sector_change_1_year = sector_public[_n+1] != sector_public if wave[_n+1] == wave + 1
bysort xwaveid (wave): gen leading_real_wage = real_wage[_n+1]
bysort xwaveid (wave): gen leading_log_real_wage = log_real_wage[_n+1]
bysort xwaveid (wave): gen leading_changed_emp_1_year = changed_employer[_n+1] if wave[_n+1] == wave + 1

gen leading_real_wage_change = leading_real_wage - real_wage
gen leading_log_real_wage_change = leading_log_real_wage - log_real_wage
gen leading_moved_public_1_year = sector_public == 0 & leading_sector_change_1_year == 1 if leading_sector_change_1_year < .
gen leading_moved_private_1_year = sector_public == 1 & leading_sector_change_1_year == 1 if leading_sector_change_1_year < .


///////////////////////////////////////////
// 6. Summarize & Save ////////////////////
///////////////////////////////////////////

summarize

save "/home/sean/Code/honours/hons-project/cleaned_data/v4/basic_cleaned.dta", replace
// save "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v4/basic_cleaned.dta", replace
