*summarize
clear
use "/home/sean/Code/honours/hons-project/cleaned_data/v3/vars_combined.dta"

keep if main_hours >= 1

*experience
keep if experience >= 0

generate experience_sq = 0
replace experience_sq = experience*experience


*sex
generate male = 0
replace male = 1 if sex == 1

generate female = 0
replace female = 1 if sex == 2


*children
generate children_0 = 0
replace children_0 = 1 if n_resident_children == 0

generate children_1 = 0
replace children_1 = 1 if n_resident_children == 1

generate children_2 = 0
replace children_2 = 1 if n_resident_children == 2

generate children_3 = 0
replace children_3 = 1 if n_resident_children == 3

generate children_4_plus = 0
replace children_4_plus = 1 if n_resident_children >= 4

summarize children_0 children_1 children_2 children_3 children_4_plus

*education
generate ed_uni = 0
replace ed_uni = 1 if edhigh1 == 1 | edhigh1 == 3

generate ed_diploma_cert = 0
replace ed_diploma_cert = 1 if edhigh1 == 2 | edhigh1 == 4 | edhigh1 == 5

generate ed_y12_or_less = 0
replace ed_y12_or_less = 1 if edhigh1 == 8 | edhigh1 == 9

keep if ed_uni == 1 | ed_diploma_cert == 1 | ed_y12_or_less == 1


*health
generate health_good = 0
replace health_good = 1 if helth == 2

generate health_poor = 0
replace health_poor = 1 if helth == 1

keep if health_good == 1 | health_poor == 1


* poor English
**** EDIT HERE ***
*replace english_good = 1 if english_unknown == 0

*country of birth
generate birth_aus = 0
replace birth_aus = 1 if anbcob == 1

generate birth_eng = 0
replace birth_eng = 1 if anbcob == 2

generate birth_neng = 0
replace birth_neng = 1 if anbcob == 3

keep if birth_aus == 1 | birth_eng == 1 | birth_neng == 1

*industry
replace jbmi61 = 19 if jbmi61 < 0
gen ind_agri = 1.jbmi61
gen ind_mine = 2.jbmi61
gen ind_manufact = 3.jbmi61
gen ind__utilities = 4.jbmi61
gen ind_construct = 5.jbmi61
gen ind_wholesale = 6.jbmi61
gen ind_retail = 7.jbmi61
gen ind_accomo_food = 8.jbmi61
gen ind_logistics = 9.jbmi61
gen ind_it = 10.jbmi61
gen ind_finance = 11.jbmi61
gen ind_rent_and_real_estate = 12.jbmi61
gen ind_prof_sci_technical = 13.jbmi61
gen ind_admin = 14.jbmi61
gen ind_public_admin = 15.jbmi61
gen ind_education = 16.jbmi61
gen ind_health = 17.jbmi61
gen ind_arts_rec = 18.jbmi61
gen ind_other_unknown = 19.jbmi61


*occupation
// generate occ = 0
// replace occ = 1 if occupation_1 == 1
// replace occ = 2 if occupation_2 == 1
// replace occ = 3 if occupation_3 == 1
// replace occ = 4 if occupation_4 == 1
// replace occ = 5 if occupation_5 == 1
// replace occ = 6 if occupation_6 == 1
// replace occ = 7 if occupation_7 == 1
// replace occ = 8 if occupation_8 == 1
//
// tabulate occ, summarize(p_sec)

keep if jbmo61 > 0
gen occ_manage = 1.jbmo61
gen occ_prof = 2.jbmi61
gen occ_tech_trade = 3.jbmi61
gen occ_community_personal_service = 4.jbmi61
gen occ_clerical_admin = 5.jbmi61
gen occ_sales = 6.jbmi61
gen occ_machinery = 7.jbmi61
gen occ_labourer = 8.jbmi61


*marriage
** Review here!
gen married_yes = 0
replace married_yes = 1 if mrcurr == 1 | mrcurr == 2

gen married_no = 0
replace married_no = 1 if mrcurr > 2


*large capital
generate large_capital = 0
replace large_capital = 1 if hhsgcc == 11 | hhsgcc == 21 | hhsgcc == 31 | hhsgcc == 41 | hhsgcc == 51

generate large_capital_unknown = 0
replace large_capital_unknown = 1 if hhsgcc < 0


* urban to be reviewed

generate urban = 0
replace urban = 1 if hhssos == 0 | hhssos == 1


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


*shiftwork
keep if jbmsch > 0

generate shiftwork_yes = 1
replace shiftwork_yes = 1 if jbmsch == 1

generate shiftwork_no = 0
replace shiftwork_no = 1 if shiftwork_yes == 0

*union
keep if jbmtuea > 0
generate union_yes = 0
replace union_yes = 1 if jbmtuea == 1

generate union_no = 0
replace union_no = 1 if union_yes == 0

keep if main_income >= 1

generate wage = 0
replace wage = main_income / main_hours

generate log_wage = 0
replace log_wage = log(wage)

summarize
