#### Want to do some basic analysis of job movers
#### Does the sector reported ever vary for people who didn't change jobs?
#### What does the wage profile of people look like over time

# initialise

# ctrl l to clear console
rm(list = ls())
graphics.off()

library(haven)
library(tidyverse)
library(ggplot2)
library(labelled)

# load data
dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income <- read_dta("basic_cleaned.dta")


summarise(income$pjsemp)
