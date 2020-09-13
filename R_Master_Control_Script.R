#devtools::install_github("DataWookie/feedeR")

#load libraries
library(feedeR)

getfeed<-function(url)
  {
  info <- feed.extract(url)
  info <- info$items$title
  return(info)
  }

a<-getfeed("http://journal.r-project.org/rss.atom")
a<-c(a,getfeed("http://journal.r-project.org/rss.atom"))


system(paste("python anytext.pl '",a[1],"'",sep=""))
