# Purpose of the program:
# This code converts the Hilda waves into one longfile, selecting only a subset of variables.
# This is because the file sizes are too large for Stata's cheaper versions to handle
#
# Based on code from the Hilda program library by Mossamet Nesa

rm(list = ls())

library(haven)
library(tidyverse)

# Hilda parameters
last_wave <- 21 # Last wave to analyse
maxwave <- 21   # Update to the latest wave.
rls <- 210      # Update to the latest release.

# File structure parameters
rel_origdatdir <- "../hilda_data/stata_combined" # Relative location of Hilda
rel_xtradatdir <- "../supplementary_data"        # Relative location of cpi, wpi data
rel_newdatdir <- "../cleaned_data/v4"            # Relative location of where to store results

# Set absolute directory variables
doc_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
origdatdir <- paste(doc_dir, "/", rel_origdatdir, sep="")
xtradatdir <- paste(doc_dir, "/", rel_xtradatdir, sep="")
newdatdir <- paste(doc_dir, "/", rel_newdatdir, sep="")

# Load CPI, WPI data
setwd(xtradatdir)
aus_cpi <- read.csv("aus_cpi.csv")
aus_cpi$year <- sub("^[^-]+-", "", aus_cpi$Quarter)
annual_cpi <- aus_cpi %>%
  group_by(year) %>%
  summarise(annual_cpi = mean(CPI))

aus_wpi <- read.csv("aus_wpi.csv")
aus_wpi$year <- sub("^[^-]+-", "", aus_wpi$Quarter)
annual_wpi <- aus_wpi %>%
  group_by(year) %>%
  summarise(annual_wpi = mean(WPI))


# Load main data
setwd(origdatdir)

var <- c("jbmhruc", "wscmei", "jbhruc", "wscei", # income variables
         "jbmmply", "jbmmpl", "jbmmplr",         # sector
         "hgage", "ehtjb",                       # age and experience
         "hgsex", "edhigh1", "mrcurr", "helth",  # sex, education, marriage, long term health condition
         "anbcob", "hhsgcc", "hhstate",          # birth and locality
         "hhssos",                               # urban
         "jbmi61", "jbmo61",                     # industry and occupation
         "aneab", "hgeab",                       # English proficiency
         "jbmsch", "jbmtuea",                    # shiftwork, union
         "tcr", "tcr04", "hhyng",                # number of children
         "edfts", "esbrd", "esempst",            # full time student, employed, ft/pt, self employed / own business
         "jbempt", "pjsemp",                     # tenure, changed employer
         "jbmwpsz", "jbmwps", "jbmemsz",         # firm size (office, early waves), firm size (office, late waves), firm size (across Aus)
         "jbcasab",                              # casual
         "hhtup", "hhwtrp",                      # top up sample, cross-sectional weights
         "jbmi62", "jbmo62"                      # more detailed industry / occupation
        )

for( i in 1:last_wave) {
  file_list <- paste0("Combined_", letters[i], rls, "c.dta")
  temp <- read_dta(file_list)
  var_add <- paste0(letters[i], var) # Add wave letter onto the variable names
  temp <- temp %>% dplyr::select(xwaveid, any_of(var_add)) 
  # any_of() lets the program avoid selecting the variable not included in a specific wave and set NA to that variable. eg: "hwhmhl" not included in wave 1
  names(temp)[-1] <-substring(names(temp)[-1], 2) # Remove wave letter from variable names except for xwaveid
  temp$wave <- i
  temp$cpi <- annual_cpi$annual_cpi[annual_cpi$year == 2000+i]
  temp$wpi <- annual_wpi$annual_wpi[annual_wpi$year == 2000+i]
  
  # Previously restrictions on the sample were done here. This meant data on the previous wave was occassionally missing,
  # this data is necessary for data quality (did the reported sector change after a change in employer)
  # Therefore a larger dataset is now selected and then restrictions are done in Stata
  
  # # add restrictions to the data:
  # #  1. Only those are employed
  # #  2. Only those who are 22-64
  # #  3. No full time students
  # #  4. Has data on sector
  # #  5. Has data on wage (i.e. hours and pay for main job)
  # employed = temp$esbrd == 1
  # over21 = temp$hgage > 21
  # under65 = temp$hgage < 65
  # not_fulltimestudent = temp$edfts == 0
  # wage_data = temp$jbmhruc >= 0 & temp$wscmei >=0
  # 
  # if (i == 1) {
  #   sector_data = temp$jbmmpl > 0
  # } else if (i == 2) {
  #   sector_data = temp$jbmmplr > 0
  # } else {
  #   sector_data = temp$jbmmply > 0
  # }
  # 
  # reduced_temp <- temp[employed & over21 & under65 & not_fulltimestudent & sector_data & wage_data,]
  
  if (i == 1 ){
    longfile <- temp
  } else {
    longfile <- bind_rows(longfile, temp) # Append the data file from each wave
  }
}

# Save new data set
setwd(newdatdir)
write_dta(longfile, "base_longfile.dta")
