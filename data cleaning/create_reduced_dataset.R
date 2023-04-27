# Purpose of the program:
# =======================
# This program creates one long file on a subset of variables across all HILDA waves.
#
# Based on code from the Hilda program library by Mossamet Nesa

rm(list = ls())

library(haven)
library(tidyverse)

last_wave <- 21 # Last wave to analyse
maxwave <- 21   # Update to the latest wave.
rls <- 210      # Update to the latest release.
# to set current dir can use dirname(rstudioapi::getActiveDocumentContext()$path) but varies based on whether in Rstudio
current_dir <- "/home/sean/Code/honours/hons-project/data cleaning"
rel_origdatdir <- "../hilda_data/stata_combined"
rel_newdatdir <- "../cleaned_data/v2" # Location of writing new data files


# SECTION 1: Creating an unbalanced dataset (long-format)
doc_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
origdatdir <- paste(doc_dir, "/", rel_origdatdir, sep="")
newdatdir <- paste(doc_dir, "/", rel_newdatdir, sep="")

setwd(origdatdir)
var <- c("jbmhruc", "wscmei", "jbhruc", "wscei", # income variables
         "jbmmply", "jbmmpl", "jbmmplr",         # sector
         "hgage", "ehtjb",                       # age and experience
         "hgsex", "edhigh1", "mrcurr", "helth",  # sex, education, marriage, long term health condition
         "ancob", "anbcob", "hhsgcc", "hhstate", # birth and locality
         "jbmi61", "jbmo61",                     # industry and occupation
         "aneab", "hgeab",                       # English proficiency
         "jbmsch", "jbmday",                     # shiftwork and day worked
         "jbmemz",                               # firm size
         "jbmtuea", "jbmtabs",                   # union, trade union membership
         "tcr",                                  # number of children
         "edfts", "esbrd", "esdtl",              # full time student, employed, ft/pt
         "alpd", "alsk",                         # paid annual and sick leave in last 12 months
         "jbempt"                                # tenure
        )

for( i in 1:last_wave) {
  file_list <- paste0("Combined_", letters[i], rls, "c.dta")
  temp <- read_dta(file_list)
  var_add <- paste0(letters[i], var) # Add wave letter onto the variable names
  temp <- temp %>% dplyr::select(xwaveid, any_of(var_add)) 
  # any_of() lets the program avoid selecting the variable not included in a specific wave and set NA to that variable. eg: "hwhmhl" not included in wave 1
  names(temp)[-1] <-substring(names(temp)[-1], 2) # Remove wave letter from variable names except for xwaveid
  temp$wave <- i
  if (i == 1 ){
    longfile <- temp
  } else {
    longfile <- bind_rows(longfile, temp) # Append the data file from each wave
  }
}

# Save new data set
setwd(newdatdir)
save(longfile, file = "long_reducedvariableset_data.Rdata")
# write_dta(longfile, "long-file-unbalanced.dta") # Could save as a stata data file