# Purpose of the program:
# =======================
# This program creates one long file on a subset of variables across all HILDA waves.
# This second file is to extract variables to analyse wage growth over time
#
# Based on code from the Hilda program library by Mossamet Nesa

rm(list = ls())

library(haven)
library(tidyverse)

last_wave <- 21 # Last wave to analyse
maxwave <- 21   # Update to the latest wave.
rls <- 210      # Update to the latest release.
# to set current dir can use dirname(rstudioapi::getActiveDocumentContext()$path) but varies based on whether in Rstudio
rel_origdatdir <- "../hilda_data/stata_combined"
rel_xtradatdir <- "../supplementary_data"
rel_newdatdir <- "../cleaned_data/v3" # Location of writing new data files


# SECTION 1: Creating an unbalanced dataset (long-format)
doc_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
origdatdir <- paste(doc_dir, "/", rel_origdatdir, sep="")
xtradatdir <- paste(doc_dir, "/", rel_xtradatdir, sep="")
newdatdir <- paste(doc_dir, "/", rel_newdatdir, sep="")

# Load CPI data
setwd(xtradatdir)
aus_cpi <- read.csv("aus_cpi.csv")
aus_cpi$year <- sub("^[^-]+-", "", aus_cpi$Quarter)
annual_cpi <- aus_cpi %>%
  group_by(year) %>%
  summarise(annual_cpi = mean(CPI))


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
         "jbmsch",                               # shiftwork and day worked
         "jbmtuea", #"jbmtabs",                  # union, trade union membership (left out since non comprehensive, review later)
         "tcr",                                  # number of children
         "edfts", "esbrd", "esempst",            # full time student, employed, ft/pt, self employed / own business
         #"alpd", "alsk",                        # paid annual and sick leave in last 12 months (left out since non comprehensive)
         "jbempt", "pjsemp",                     # tenure
         "jbmwpsz", "jbmwps", #"jbmemsz",        # firm size
         "jbcasab",                              # casual
         "ajbmplej", "ajbmpgj",                  # chance to leave job
         "ajbmsall", "ajbmspay"                  # []/pay satisfaction
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
  
  # this file has no restrictions on who is included in the data
  
  if (i == 1 ){
    longfile <- temp
  } else {
    longfile <- bind_rows(longfile, temp) # Append the data file from each wave
  }
}



# Save new data set
setwd(newdatdir)
write_dta(longfile, "unrestricted_longfile.dta")
