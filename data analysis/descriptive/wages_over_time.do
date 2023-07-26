use "/Users/arbor/Documents/github repos/hons-project/cleaned_data/v3/basic_cleaned.dta", clear



forval i=1/19 {
 tab wave if sector_public==1 & sex_male == 1 & wave==`i', summarize(log_real_wage)
 tab wave if sector_public==0 & sex_male == 1 & wave==`i', summarize(log_real_wage)
 tab wave if sector_public==1 & sex_male == 0 & wave==`i', summarize(log_real_wage)
 tab wave if sector_public==0 & sex_male == 0 & wave==`i', summarize(log_real_wage)
}

