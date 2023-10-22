library(haven)
library(tidyverse)
library(ggplot2)

quantiles = rep(c("Mean", "Q25", "Q50", "Q75"),each=4)
period = rep(1:4,4)
gap_m = c(7.12,4.69,8.65,9.79,
          13.9,13,15.7,16.6,
          10.3,8.17,13.1,14.0,
          1.67,-0.4,4.65,6.2)
gap_f = c(10.8,14.8,13.2,15,
          10.5,15.6,15.8,18,
          13.6,18.7,17.9,19.1,
          13.3,17.3,16.2,15.6)

decomp_ot = data.frame(quantiles, period, gap_m,gap_f)

ggplot(data=decomp_ot, aes(x=period,y=gap_m,colour=quantiles)) +
  geom_line(show.legend = FALSE) +
  theme_bw() +
  scale_x_continuous(labels=c("1"='1-5', "2"='6-10', "3"='11-15', "4"="16-19")) +
  xlab("Wave") +
  ylab("Unexplained Differential")+
  theme(axis.text=element_text(size=18),
        axis.title=element_text(size=20,face="bold"))

ggplot(data=decomp_ot, aes(x=period,y=gap_f,colour=quantiles)) +
  geom_line(show.legend = FALSE) +
  theme_bw() +
  scale_x_continuous(labels=c("1"='1-5', "2"='6-10', "3"='11-15', "4"="16-19")) +
  xlab("Wave") +
  ylab("Unexplained Differential")+
  theme(axis.text=element_text(size=18),
        axis.title=element_text(size=20,face="bold"))
