month_list = c("Feb" , "Mar" , "Apr" , "May" , "Jun" , "Jul" , "Aug" , "Sep" , "Oct" , "Nov" , "Dec")
for (month in month_list){
  greedy = select_covariates(approach = "greedy", mon = month)
  
  conservative = select_covariates(approach = "conservative" , mon = month)
  
}