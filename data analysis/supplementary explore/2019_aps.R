# File is to analyze the APS 2019 data
# Key here: https://data.gov.au/data/dataset/362c21fb-fc80-4ee8-b906-c70f1c8d063a/resource/1e9b1100-405b-4468-9196-99d0dd663d90/download/2019-aps-employee-census-questionnaire.pdf

aps <- read.csv("~/Documents/github repos/hons-project/supplementary_data/2019-aps-employee-census-dataset.csv")

view(aps)

## Relevant questions:
# 7 - classification level
# 8 - total length of service (APS)
# 10 - employment category
# 11 - fulltime?
# 21 - highest qualification completed
# 24 - current job
### d - fairly renumerated
table(aps$q24d)
table(aps$q24d, aps$q7.)
table(aps$q24d, aps$q24i)
table(aps$q24i)
### e - nonmonetary (leave, flex work, bene)
### f - stability
### i - overall satisfaction
# 36 - skills gaps in workgroup?
# 37 - what skills
# 45 - have you applied for job outside APS
table(aps$q45.1)
# 46 - do you want to stay
# 47 - primary reason for wanting to leave
table(aps$q47)
# 54 - what attracted you to work in the APS
table(aps$q54.1)
# 104 corruption
# 111