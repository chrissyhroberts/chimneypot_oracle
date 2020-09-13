
#define any text
printthis<-function(message){system(paste("python anytext.py ",message,sep=""))}
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
getweather <-function()
{
  a<-getfeed("https://weather-broker-cdn.api.bbci.co.uk/en/forecast/rss/3day/2643490")
  a<-sample(a,1)
  a<-gsub(a,pattern = "°",replacement = " ")
  for(i in 1:length(a)){system(paste("python anytext.py '",a[1],"'",sep=""))}
}

# define a function that gets the weather and prints to Rpi
gettime <-function()
{
  a<-format(Sys.time(), "%a %b %d, %Y - %H:%M")

  system(paste("python anytext.py '",a[1],"'",sep=""))
}



# define a function to aggregate a bunch of news feeds, randomise the order and spew them out 10 at a time

getnews <- function()
{
  a<-c(getfeed("http://news.bbc.co.uk/rss/on_this_day/front_page/rss.xml"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/video_and_audio/news_front_page/rss.xml?edition=uk#"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/world/rss.xml"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/science_and_environment/rss.xml#"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/education/rss.xml"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/health/rss.xml"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/politics/rss.xml"))
  a<-c(a,getfeed("http://feeds.bbci.co.uk/news/entertainment_and_arts/rss.xml"))
  return(a)
}

todaysnews<-getnews()

printnews<-function()
{
  aa<-sample(todaysnews,size = 1)
  system(paste("python anytext.py '",aa[1],"'",sep=""))
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
    print(j)
    gettime()
    getweather()
    printnews()
    printnews()
    printnews()
    gettime()
    printnews()
    printnews()
    printnews()
    gettime()
    printnews()
    printnews()
    printnews()
      }

#test
