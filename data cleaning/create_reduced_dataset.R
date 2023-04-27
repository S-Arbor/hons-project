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
rel_origdatdir <- "../hilda_data/stata_combined"
rel_newdatdir <- "../cleaned_data/v1" # Location of writing new data files


# SECTION 1: Creating an unbalanced dataset (long-format)
doc_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
origdatdir <- paste(doc_dir, "/", rel_origdatdir, sep="")
newdatdir <- paste(doc_dir, "/", rel_newdatdir, sep="")

setwd(origdatdir)
# Could adjust for personal needs.
#var <- c("hwhmhl", "hhrhid", "hhrpid", "hhpxid", "hhresp", "hhstate", "hhsos", "ancob", "losathl", "wsce",
         #"wscei", "wscef", "wscme", "wscmei", "wscmef", "wscoe", "wscoei", "wscoef")
var <- c("jbmmply","hhrhid")

for( i in first_wave:last_wave) {
  file_list <- paste0("Combined_", letters[i], rls, "c.dta")
  temp <- read_dta(file_list)
  var_add <- paste0(letters[i], var) # Add wave letter onto the variable names
  temp <- temp %>% dplyr::select(xwaveid, any_of(var_add)) 
  # any_of() lets the program avoid selecting the variable not included in a specific wave and set NA to that variable. eg: "hwhmhl" not included in wave 1
  names(temp)[-1] <-substring(names(temp)[-1], 2) # Remove wave letter from variable names except for xwaveid
  temp$wave <- i
  if (i == first_wave ){
    longfile <- temp
  } else {
    longfile <- bind_rows(longfile, temp) # Append the data file from each wave
  }
}

# Save new data set
setwd(newdatdir)
save(longfile, file = "long-file-unbalanced.Rdata")
# write_dta(longfile, "long-file-unbalanced.dta") # Could save as a stata data file

# SECTION 2: Creating a balanced dataset (long-format)
# We can use the variable ivwptn which contains the interview pattern for each person.

# Use the master file
setwd(origdatdir)
master_file <- paste0("Master_", letters[maxwave], rls,"c.dta")
master <- read_dta(master_file)
master <- master[c("xwaveid", "ivwptn")] # Can keep more variables 

intvw_pattern <- paste(rep("X", last_wave-first_wave), collapse = "") # Create the pattern that people have been interviewed in each of the first 5 waves
master_long = master[substr(master$ivwptn, 1, last_wave-first_wave) == intvw_pattern, ] # Keep people that have been interviewed in each of the first 5 waves
final_data <- merge(master_long, longfile, by = "xwaveid", all.x = TRUE)
final_data <- final_data[order(final_data$xwaveid, final_data$wave), ] # Sort the dataset by xwaveid and wave

# Save new data set
setwd(newdatadir)
save(final_data, file = "long-file-balanced.Rdata")
# write.table(final_data, file = "long-file-balanced.txt", sep = ",", row.names = FALSE) # Can also save as a txt file

#rm(list = ls())

# wide <- spread(final_data, xwaveid, 