library(haven)

rm(list = ls())

library(tidyverse)
library(reshape2)

setwd("/home/sean/Code/honours/hons-project/cleaned_data/v1")
load("long-file-balanced.Rdata")
load("long-file-unbalanced.Rdata")

final_data$jbmmply

final_data$public_sector <- final_data$jbmmply == 2 | final_data$jbmmply == 5
final_data$private_sector <- final_data$jbmmply == 1

sum(final_data$public_sector)
sum(final_data$private_sector)

longfile$jbmmply

longfile$public_sector <- longfile$jbmmply == 2 | longfile$jbmmply == 5
longfile$private_sector <- longfile$jbmmply == 1

sum(longfile$public_sector)
sum(longfile$private_sector)

years_in_pub_sector <- dcast(longfile[,c("xwaveid", "public_sector")], xwaveid ~ public_sector)
years_in_private_sector <- dcast(longfile[,c("xwaveid", "private_sector")], xwaveid ~ private_sector)

head(years_in_pub_sector)
head(years_in_private_sector)

all(years_in_pub_sector$xwaveid == years_in_pub_sector$xwaveid)

no_employer = years_in_pub_sector$`TRUE` == 0 & years_in_pub_sector$`FALSE` == 0
sum(no_employer)
switched_sectors = years_in_private_sector$`TRUE` > 0 & years_in_pub_sector$`TRUE` > 0
sum(switched_sectors)
length(years_in_pub_sector)
nrow(years_in_pub_sector)



years_in_pub_sector <- dcast(final_data[,c("xwaveid", "public_sector")], xwaveid ~ public_sector)
years_in_private_sector <- dcast(final_data[,c("xwaveid", "private_sector")], xwaveid ~ private_sector)

head(years_in_pub_sector)
head(years_in_private_sector)

all(years_in_pub_sector$xwaveid == years_in_pub_sector$xwaveid)

no_employer = years_in_pub_sector$`TRUE` == 0 & years_in_pub_sector$`FALSE` == 0
sum(no_employer)
switched_sectors = years_in_private_sector$`TRUE` > 0 & years_in_pub_sector$`TRUE` > 0
sum(switched_sectors)
length(years_in_pub_sector)
nrow(years_in_pub_sector)
sum(years_in_private_sector$`TRUE` > 0)
sum(years_in_pub_sector$`TRUE` > 0)
