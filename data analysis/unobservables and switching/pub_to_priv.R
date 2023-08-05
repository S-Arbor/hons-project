library(haven)
library(tidyverse)
library(ggplot2)

dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(paste(dir, "../../cleaned_data/v3", sep="/"))

income <- read_dta("pub_to_priv.dta")

movers <- income[income$moved_private == 1,]

means <- movers %>%
  group_by(wave) %>%
  summarise(mean_wage_change = mean(real_wage_change))

ggplot(data=movers, aes(x=wave, y=real_wage_change_pct)) +
  geom_point()
