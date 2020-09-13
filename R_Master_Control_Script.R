#devtools::install_github("DataWookie/feedeR")

#load libraries
library(feedeR)


# define a function that gets feeds
getfeed<-function(url)
  {
  info <- feed.extract(url)
  info <- info$items$title
  return(info)
  }


# define a function that gets the weather and prints to Rpi
getweather <-function()
  {
  a<-getfeed("https://weather-broker-cdn.api.bbci.co.uk/en/forecast/rss/3day/2643490")
  for(i in 1:length(a)){system(paste("python anytext.py '",a[1],"'",sep=""))}
  }

# define a function that gets the weather and prints to Rpi
gettime <-function()
{
  a<-Sys.time()
  system(paste("python anytext.py '",a[1],"'",sep=""))
}


# define a function to aggregate a bunch of news feeds, randomise the order and spew them out 10 at a time

getnews <- function()
{
a<-c(a,getfeed("http://journal.r-project.org/rss.atom"))
a <- sample(a,size = 10)
system(paste("python anytext.py '",a[1],"'",sep=""))
}

b=1
while(b==1)
{
gettime()
getweather()
getnews()
}
