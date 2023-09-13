*summarize
clear
use "/Users/arbor/Documents/github repos/hons/dummyvar_longfile.dta"

keep if main_hours >= 1


keep if experience >= 0

generate experience_sq = 0
replace experience_sq = experience*experience

generate male = 0
replace male = 1 if sex == 1

generate female = 0
replace female = 1 if sex == 2

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

keep if ed_unknown == 0

keep if helth_cond_unknown == 0

generate no_health_cond = 0
replace no_health_cond = 1 if health_cond == 0

* poor English
drop if poor_english_unknown == 0

generate english_poor = 0
replace english_poor = 1 if poor_english == 1

generate english_good = 0
replace english_good = 1 if english_poor == 0

*country of birth
drop if birth_unknown == 1

*temporary
generate p_sec = 0
replace p_sec = 1 if sector_public == 1

// generate industry = 0
// replace industry = 1 if ind_1 == 1
// replace industry = 2 if ind_2 == 1
// replace industry = 3 if ind_3 == 1
// replace industry = 4 if ind_4 == 1
// replace industry = 5 if ind_5 == 1
// replace industry = 6 if ind_6 == 1
// replace industry = 7 if ind_7 == 1
// replace industry = 8 if ind_8 == 1
// replace industry = 9 if ind_9 == 1
// replace industry = 10 if ind_10 == 1
// replace industry = 11 if ind_11 == 1
// replace industry = 12 if ind_12 == 1
// replace industry = 13 if ind_13 == 1
// replace industry = 14 if ind_14 == 1
// replace industry = 15 if ind_15 == 1
// replace industry = 16 if ind_16 == 1
// replace industry = 17 if ind_17== 1
// replace industry = 18 if ind_18 == 1
// replace industry = 19 if ind_19 == 1
//
// tabulate industry, summarize(p_sec)


// tabulate p_sec ind_1
// tabulate p_sec ind_2
// tabulate p_sec ind_3
// tabulate p_sec ind_4
// tabulate p_sec ind_5
// tabulate p_sec ind_6
// tabulate p_sec ind_7
// tabulate p_sec ind_8
// tabulate p_sec ind_9
// tabulate p_sec ind_10
// tabulate p_sec ind_11
// tabulate p_sec ind_12
// tabulate p_sec ind_13
// tabulate p_sec ind_14
// tabulate p_sec ind_15
// tabulate p_sec ind_16
// tabulate p_sec ind_17
// tabulate p_sec ind_18
// tabulate p_sec ind_19

rename ind_1 ind_agri
rename ind_2 ind_mine
rename ind_3 ind_manufact
rename ind_4 ind_utilities
rename ind_5 ind_construct
rename ind_6 ind_wholesale
rename ind_7 ind_retail
rename ind_8 ind_accomo_food
rename ind_9 ind_logistics
rename ind_10 int_it
rename ind_11 ind_finance
rename ind_12 ind_rent_and_real_estate
rename ind_13 ind_prof_sci_technical
rename ind_14 ind_admin
rename ind_15 ind_public_admin
rename ind_16 ind_education
rename ind_17 ind_health
rename ind_18 ind_arts_rec
rename ind_19 ind_other_unknown
replace ind_other_unknown = 1 if ind_unknown == 1

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

keep if occupation_unknown == 0

rename occupation_1 occ_manage
rename occupation_2 occ_prof
rename occupation_3 occ_tech_trade
rename occupation_4 occ_community_personal_service
rename occupation_5 occ_clerical_admin
rename occupation_6 occ_sales
rename occupation_7 occ_machinery
rename occupation_8 occ_labourer
*summarize

*shifwork
keep if shiftwork_unknown == 0
generate shiftwork_no = 0
replace shiftwork_no = 1 if shiftwork == 0

*union
keep if union_unknown == 0
generate union_no = 0
replace union_no = 1 if union == 0

keep if main_income >= 1

generate wage = 0
replace wage = main_income / main_hours

generate log_wage = 0
replace log_wage = log(wage)

summarize
