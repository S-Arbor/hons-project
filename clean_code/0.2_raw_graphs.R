library(haven)
library(tidyverse)
library(ggplot2)
library(svglite)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../cleaned_data/v4", sep="/"))

income <- read_dta("basic_cleaned.dta")
income$Sector <- "Public"
income$Sector[income$sector_private == 1] <- "Private"

c_pub = "#FC0E07"
c_priv = "#00AFBB"

setwd(paste(dir,"../output_figures/raw_diff",sep="/"))

men_raw <- ggplot(income[income$sex_male == 1,], aes(x=log_real_wage, colour=Sector)) +
  geom_density() +
  scale_color_manual(values=c(c_priv, c_pub)) +
  theme_bw() +
  xlim(1.8,5.0) +
  theme(axis.text=element_text(size=18),
        axis.title=element_text(size=20,face="bold"),
        legend.text = element_text(size=18),
        legend.title = element_text(size=18)) +
  xlab("Ln Wage")

women_raw <- ggplot(income[income$sex_female == 1,], aes(x=log_real_wage, colour=Sector)) +
  geom_density() +
  scale_color_manual(values=c(c_priv, c_pub)) +
  theme_bw() +
  xlim(1.8,5.0) +
  theme(axis.text=element_text(size=18),
        axis.title=element_text(size=20,face="bold"),
        legend.text = element_text(size=18),
        legend.title = element_text(size=18)) +
  xlab("Ln Wage")

# Smaller text
men_raw <- ggplot(income[income$sex_male == 1,], aes(x=log_real_wage, colour=Sector)) +
  geom_density() +
  scale_color_manual(values=c(c_priv, c_pub)) +
  theme_bw() +
  xlim(1.8,5.0) +
  theme(axis.text=element_text(size=14),
        axis.title=element_text(size=16,face="bold"),
        legend.text = element_text(size=14),
        legend.title = element_text(size=14)) +
  xlab("Ln Wage")

women_raw <- ggplot(income[income$sex_female == 1,], aes(x=log_real_wage, colour=Sector)) +
  geom_density() +
  scale_color_manual(values=c(c_priv, c_pub)) +
  theme_bw() +
  xlim(1.8,5.0) +
  theme(axis.text=element_text(size=14),
        axis.title=element_text(size=16,face="bold"),
        legend.text = element_text(size=14),
        legend.title = element_text(size=14)) +
  xlab("Ln Wage")


ggsave("raw_women.pdf", women_raw,dpi=1000)
ggsave("raw_men.pdf", men_raw, dpi=1000)


ggsave("raw_men.svg", height=150,width=350, plot=men_raw,units="mm")
ggsave("raw_women.svg", height=150,width=350, plot=women_raw,units="mm")

