# this code reads in the cpi data, creates a column for year based on the quarter column
# then it sets up a table of the year and the mean CPI for that year
aus_cpi <- read.csv("aus_cpi.csv")
aus_cpi$year <- sub("^[^-]+-", "", aus_cpi$Quarter)
annual_cpi <- aus_cpi %>%
  group_by(year) %>%
  summarise(annual_cpi = mean(CPI))

# this code is run for the data for each year, and sets the cpi for that year to the mean CPI
# across quarters as calculated above.
temp$cpi <- annual_cpi$annual_cpi[annual_cpi$year == 2000+i]