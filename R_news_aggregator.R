library(feedeR)

#define any text
printthis <- function(message) {
  safe_message <- shQuote(message)
  system(paste("python anytext.py", safe_message))
}

#MAIN

printthis("The_Chimneypot_Oracle_Speaks_AGAIN!!")
printthis("Updating_the_news...Please_wait...")


# define a function that gets feeds
getfeed<-function(url)
{
  info <- feed.extract(url)
  info <- info$items$title
  return(info)
}


# define a function that gets the weather and prints to Rpi
getweather <- function() {
  a <- getfeed("https://weather-broker-cdn.api.bbci.co.uk/en/forecast/rss/3day/2643490")
  a <- sample(a, 1)
  a <- gsub(a, pattern = "°", replacement = " ")
  for(i in 1:length(a)) {
    safe_a <- shQuote(a[i])
    system(paste("python anytext.py", safe_a))
  }
}

# define a function that gets the weather and prints to Rpi
gettime <- function() {
  a <- format(Sys.time(), "%a %b %d, %Y - %H:%M")
  safe_a <- shQuote(a) # Correctly quote the entire string
  system(paste("python anytext.py", safe_a))
}



# define a function to aggregate a bunch of news feeds, randomise the order and spew them out 10 at a time

getnews <- function()
{
  a<-c(getfeed("https://feeds.bbci.co.uk/news/rss.xml"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/world/rss.xml"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/uk/rss.xml"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/business/rss.xml"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/education/rss.xml"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/health/rss.xml"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/politics/rss.xml"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/entertainment_and_arts/rss.xml"))
  a<-c(a,getfeed("https://skyandtelescope.com/astronomy-news/feed/"))
  a<-c(a,getfeed("https://skyandtelescope.com/astronomy-news/observing-news/feed/"))
  a<-c(a,getfeed("https://www.nasa.gov/news-release/feed/"))
  a<-c(a,getfeed("https://www.nasa.gov/news-release/feed/"))
  
  
  return(a)
}

todaysnews<-getnews()

printnews <- function() {
  aa <- sample(todaysnews, size = 1)
  safe_aa <- shQuote(aa[1]) # Ensure the string is safely quoted
  system(paste("python anytext.py", safe_aa))
}

printthis("Updating_the_news...Please_wait...")


b=1

j=1
mes1<-
  while(b==1)
  {
    if(j==60){
      printthis("Updating_the_news...Please_wait...")
      todaysnews<-getnews()
      j=1
    }
    j=j+1
    try(	print(j))
    try(    gettime())
    try(    getweather())
    try(    printnews())
    try(    printnews())
    try(    printnews())
    try(    gettime())
    try(    printnews())
    try(    printnews())
    try(    printnews())
    try(    gettime())
    try(    printnews())
    try(    printnews())
    try(    printnews())
      }

#test
