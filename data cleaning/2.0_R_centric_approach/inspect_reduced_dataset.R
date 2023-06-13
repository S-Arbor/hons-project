# A number of functions for reviewing the reduced dataset and cleaning it
longfile = base

summary(longfile < 0) # shows number of variables with missing information

longfile[longfile$jbmhruc < 0,] # inspect rows with missing data on a variable

# variables with the most missing data

## ehtjb (time in paid work - years) - 3572 missing
table(longfile$ehtjb[longfile$ehtjb < 0])
# reveals that the majority of these (3394) come from -7: not able to determine

## jbmi61 (industry of employment) - 1227 missing
table(longfile$jbmi61[longfile$jbmi61 < 0])
# reveals that the majority of these (1169) come from -7: not able to determine

## jbmhruc (hours per week in main job) - 361 missing
table(longfile$jbmhruc[longfile$jbmhruc < 0])
# reveals that the majority of these (259) come from -3 (don't know)

## aneab and hgeab
# non problematic, this is because they focus on a smaller population

## full inspection of missing vars
problem_vars <- c("jbmhruc", "jbhruc", "ehtjb", "mrcurr", "helth", "ancob", "hhsgcc", "jbmi61", "jbmo61", "jbmsch", "hgeab", "jbmday", "jbmtuea", "jbempt", "aneab")
for (problem_var in problem_vars) {
  print(problem_var)
  print(table(longfile[,problem_var][longfile[,problem_var]<0]))
}
