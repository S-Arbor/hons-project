library(haven)
library(tidyverse)
library(ggplot2)
library(svglite)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../supplementary_data/", sep="/"))

wpi_growth <- read.csv("wpi_growth.csv")

setwd(paste(dir,"../output_figures/",sep="/"))

c_pub = "#FC0E07"
c_priv = "#00AFBB"

## RAW WAGE GROWTH BY SECTOR
wpi_growth$as_date <- my(wpi_growth$Quarter)

wpi_clean <- pivot_longer(wpi_growth, cols=c("Private", "Public")) %>%
  rename("WPI_Growth" = "value","Sector"="name")

wpi_fig <- ggplot(data=wpi_clean, aes(x=as_date,y=WPI_Growth,colour=Sector)) +
  geom_line() +
  theme_bw() +
  xlab("Year") +
  ylab("Wage Growth") +
  theme(axis.text=element_text(size=18),
        axis.title=element_text(size=20,face="bold"),
        legend.text = element_text(size=18),
        legend.title = element_text(size=18)) +
  scale_color_manual(values=c(c_priv, c_pub))

ggsave("wpi_growth.svg", wpi_fig)


ggplot(data=decomp_ot, aes(x=period,y=gap_f,colour=quantiles)) +
  geom_line(show.legend = FALSE) +
  theme_bw() +
  scale_x_continuous(labels=c("1"='1-5', "2"='6-10', "3"='11-15', "4"="16-19")) +
  xlab("Wave") +
  ylab("Unexplained Differential")+
  theme(axis.text=element_text(size=18),
        axis.title=element_text(size=20,face="bold"))
