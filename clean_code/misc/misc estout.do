// This file contains the quantile regressions and decompositions for men and women with and without occupation

// TODO: RUN DECOMPOSITIONS WITH CLUSTERED BOOTSTRAP

// use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v4/basic_cleaned.dta", clear
use "/home/sean/Code/honours/hons-project/cleaned_data/v4/basic_cleaned.dta"

eststo clear
// Men without occupation
regress log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave if sex_male == 1 [pw=hhwtrp]

eststo ols_men_noc

// Men without occupation
qrprocess log_real_wage sector_public experience experience_sq edu_uni edu_diploma children_1 children_2 children_3 children_4_plus health_poor birth_eng birth_neng married_yes married_sep urban_no state_VIC state_WA state_QLD state_SA state_NT state_TAS state_ACT shiftwork_yes parttime long_hours casual tenure i.wave if sex_male == 1 [pw=hhwtrp], quantile(0.1, 0.25, 0.5, 0.75, 0.9)

eststo qr_men_noc

eststo combi: appendmodels ols_men_noc qr_men_noc

estout ols_men_noc ols_men_noc using "/home/sean/Code/honours/hons-project/output_tables/estout_test.csv", replace

estout qr_men_noc qr_men_noc using "/home/sean/Code/honours/hons-project/output_tables/estout_test.csv", append
