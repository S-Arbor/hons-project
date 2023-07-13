clear

*use "/home/sean/Code/honours/hons-project/cleaned_data/v3/basic_cleaned.dta"
use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta"

generate test_interaction = sector_public * log_real_wage

regress job_satisfaction sector_public log_real_wage test_interaction

regress pay_satisfaction sector_public log_real_wage test_interaction

regress chance_find_better_job sector_public log_real_wage test_interaction

regress chance_volun_leave sector_public log_real_wage test_interaction

keep if real_wage < 400

// aaplot????
