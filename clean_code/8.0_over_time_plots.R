library(haven)
library(tidyverse)
library(ggplot2)

Quantile = rep(c("Mean", "Q25", "Q50", "Q75"),each=4)
period = rep(1:4,4)
gap_m = c(7.12,4.69,8.65,9.79,
          13.9,13,15.7,16.6,
          10.3,8.17,13.1,14.0,
          1.67,-0.4,4.65,6.2)
gap_f = c(10.8,14.8,13.2,15,
          10.5,15.6,15.8,18,
          13.6,18.7,17.9,19.1,
          13.3,17.3,16.2,15.6)

decomp_ot = data.frame(Quantile, period, gap_m,gap_f)
decomp_ot$true_m = 100 * (exp(decomp_ot$gap_m/100) - 1)
decomp_ot$true_f = 100 * (exp(decomp_ot$gap_f/100) - 1)

men_ot <- ggplot(data=decomp_ot, aes(x=period,y=true_m,colour=Quantile)) +
  geom_line() +
  theme_bw() +
  scale_x_continuous(labels=c("1"='1-5', "2"='6-10', "3"='11-15', "4"="16-19")) +
  xlab("Wave") +
  ylab("Unexplained Differential")+
  theme(axis.text=element_text(size=18),
        axis.title=element_text(size=20,face="bold"),
        legend.text = element_text(size=18),
        legend.title = element_text(size=18))

ggsave("men_ot.pdf", men_ot,dpi=1000)

women_ot <- ggplot(data=decomp_ot, aes(x=period,y=true_f,colour=Quantile)) +
  geom_line() +
  theme_bw() +
  scale_x_continuous(labels=c("1"='1-5', "2"='6-10', "3"='11-15', "4"="16-19")) +
  xlab("Wave") +
  ylab("Unexplained Differential")+
  theme(axis.text=element_text(size=18),
        axis.title=element_text(size=20,face="bold"),
        legend.text = element_text(size=18),
        legend.title = element_text(size=18))

ggsave("women_ot.pdf", women_ot,dpi=1000)


