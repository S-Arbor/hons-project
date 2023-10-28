library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../supplementary_data/", sep="/"))

wpi_growth <- read.csv("wpi_growth.csv")
wpi_growth$time <- 1:53

ggplot(data=wpi_growth, aes(x=time,y=Private)) +
  geom_line(show.legend = FALSE) +
  theme_bw()


ggplot(data=decomp_ot, aes(x=period,y=gap_f,colour=quantiles)) +
  geom_line(show.legend = FALSE) +
  theme_bw() +
  scale_x_continuous(labels=c("1"='1-5', "2"='6-10', "3"='11-15', "4"="16-19")) +
  xlab("Wave") +
  ylab("Unexplained Differential")+
  theme(axis.text=element_text(size=18),
        axis.title=element_text(size=20,face="bold"))
