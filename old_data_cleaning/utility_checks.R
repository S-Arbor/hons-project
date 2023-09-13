rm(list = ls())

library(haven)
library(tidyverse)

data_dir <- "/home/sean/Code/honours/hons-project/cleaned_data/v3"
setwd(data_dir)

base <- read_dta("base_longfile.dta")
