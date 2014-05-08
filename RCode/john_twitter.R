#####################
### Search Twitter###
#####################

## get working directory
getwd()

## set working directory
setwd("C:/Users/Big N Dumb/Documents")

# install twitteR
# load twitteR
library(RCurl) 
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
install.packages("twitteR", dependencies=TRUE)
library("twitteR")


# download a cerert.pem file and save it locally (Windows Machine)
download.file(url="http://curl.haxx.se/ca/cacert.pem", 
     destfile="C:/Users/Big N Dumb/Documents/cacert.pem")

# save api key and secret key from your application api key generation. 
my.key<- "Qf6mwppQZlVDokan5xwNXMWlI"
my.secret<- "X6k6HdtrNmu5dpDIVCSHrEZCJVohpht3H70SqbIg72guWZJopi"

# OAuth with request, access and auth URLs and key + secret
cred <- OAuthFactory$new(consumerKey=my.key,
                         consumerSecret=my.secret,
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')

# handshake with cred
cred$handshake(cainfo="C:/Users/Big N Dumb/Documents")

#Finally, save your authentication settings:  
save(cred, file="C:/Users/Big N Dumb/Documents")

# test whether you have successfully authorized with twitter api
registerTwitterOAuth(cred)

# searching twitter using searchTwitter parameters equal what you want to search for and 
# number of tweets returned (n)
iq2 <- searchTwitter("UMBC", n=500) 

# track rate limits
rate.limit <- getCurRateLimitInfo(c("lists"))

# loop to populate with pause to automate search
# sleepTime = time to sleep 
sleepTime<- 10
# loop
for (i in 1:3){
  Sys.sleep(sleepTime)
  # Download latest n tweets for search term
  umbc <- searchTwitter("UMBC", n=500, cainfo="cacert.pem") 
  umbc.df <- do.call("rbind", lapply(umbc, as.data.frame)) 
  # Save tweets to file
  write.table(umbc.df, file="C:/Users/Big N Dumb/Documents", append=TRUE, row.names=F)
  print(i)
}