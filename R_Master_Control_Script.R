#devtools::install_github("DataWookie/feedeR")

#load libraries
library(feedeR)

#wait for internet
while(curl::has_internet()==FALSE){}

#update the scripts for next
message("Sending git pull request")
system("git pull")

#light the lights
system ("sh lights_on")
message("Running Aggregator")
source("R_news_aggregator.R")
