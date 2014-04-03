#####################
### Search Twitter###
#####################

#### Searching Twitter #### 
## https://github.com/DataTacticsCorp/helper_r/blob/master/Twitter_scraper.r  ##
## or, # https://github.com/DataTacticsCorp/helper_r/blob/master/Twitter_scraper.r ##

# To begin ingesting social media data from Twitter, you’ll need a developer account on Twitter. 
# You can start one (free of cost) at https://dev.twitter.com/apps. Once you have a Twitter account, 
# return to that page and enter your username and password. Now, simply click the Create New Application 
# button, and enter the requested information. Note that these inputs are neither important nor binding; 
# just provide a name, description, and website (even just a personal blog) in the required fields.


# Now that we have set up an application with Twitter, we need to download the R package that allows us to 
# pull tweets into our local R session. After you have downloaded the twitteR package, load it by typing 
# library(twitteR).

## get working directory
getwd()

## set working directory
setwd("Your directory")

# install twitteR
# load twitteR
install.packages("twitteR", dependencies=TRUE)
library("twitteR")


# #download a cerert.pem file and save it locally (Windows Machine)
# download.file(url="http://curl.haxx.se/ca/cacert.pem", 
#               destfile="/Users/heimannrichard/Google Drive/Spatial Analysis UMBC/RCode/cacert.pem")

# save api key and secret key from your application api key generation. 
my.key<- "XX"
my.secret<- "XX"

# OAuth with request, access and auth URLs and key + secret
cred <- OAuthFactory$new(consumerKey=my.key,
                         consumerSecret=my.secret,
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')

# handshake with cred
cred$handshake(cainfo="Your directory")

#Finally, save your authentication settings:  
save(cred, file="Your directory")

# test whether you have successfully authorized with twitter api
registerTwitterOAuth(cred)

# searching twitter using searchTwitter parameters equal what you want to search for and 
# number of tweets returned (n)
iq2 <- searchTwitter("Search", n=500) 

# track rate limits
rate.limit <- getCurRateLimitInfo(c("lists"))

# no loop
t1 <- searchTwitter("#Snowden", n=500, cainfo="C:/Projects/Text Analysis/cacert.pem", lang="en", retryOnRateLimit=1000)

# loop to populate with pause to automate search
# sleepTime = time to sleep 
sleepTime<- 10
# loop
for (i in 1:3){
  Sys.sleep(sleepTime)
  # Download latest n tweets for search term
  iq <- searchTwitter("Iraq", n=500, cainfo="cacert.pem") 
  df <- do.call("rbind", lapply(iq, as.data.frame)) 
  # Save tweets to file
  write.table(df, file="/Users/heimannrichard/Google Drive/Spatial Analysis UMBC/RCode/tweets", append=TRUE, row.names=F)
  print(i)
}


########################################################################################
####END CODE END CODE END CODE END CODE END CODE END CODE END CODE END CODE END CODE####
########################################################################################

# # convert search results to a data frame
# df <- do.call("rbind", lapply(iq, as.data.frame)) 
# # extract the usernames
# users <- unique(df$screenName)
# users <- sapply(users, as.character)
# # make a data frame for the loop to work with 
# users.df <- data.frame(users = users, 
#                        followers = "", stringsAsFactors = FALSE)


# for (i in 1:nrow(users.df)) 
# {
#   # tell the loop to skip a user if their account is protected 
#   # or some other error occurs  
#   result <- try(getUser(users.df$users[i])$followersCount, silent = TRUE);
#   if(class(result) == "try-error") next;
#   # get the number of followers for each user
#   users.df$followers[i] <- getUser(users.df$users[i])$followersCount
#   # tell the loop to pause for 60 s between iterations to 
#   # avoid exceeding the Twitter API request limit
#   print('Sleeping for 60 seconds...')
#   Sys.sleep(60); 
# }



# April 3

#####################
### Search Twitter###
#####################


## get working directory
getwd()


## set working directory
setwd("Your directory")


# install twitteR
# load twitteR
install.packages("twitteR", dependencies=TRUE)
library("twitteR")




# #download a cerert.pem file and save it locally (Windows Machine)
download.file(url="http://curl.haxx.se/ca/cacert.pem", 
  destfile="C:/Users/GIS/Documents/tweets/cacert.pem")


# save api key and secret key from your application api key generation. 
my.key<- "L3hRdhUHpmbPdpnD527EAabk2"
my.secret<- "yzE3AbGI6ngeDloG0UzjNYucc4ws63if6qcwgMcXj49DdzLcT1"


# OAuth with request, access and auth URLs and key + secret
cred <- OAuthFactory$new(consumerKey=my.key,
                         consumerSecret=my.secret,
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')


# handshake with cred
cred$handshake(cainfo="C:/Users/GIS/Documents/tweets/cacert.pem")


#Finally, save your authentication settings:  
save(cred, file="C:/Users/GIS/Documents/tweets/twitter.Rdata")


library(RCurl) 
# Set SSL certs globally
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

# test whether you have successfully authorized with twitter api
registerTwitterOAuth(cred)


# searching twitter using searchTwitter parameters equal what you want to search for and 
# number of tweets returned (n)
gis <- searchTwitter("GIS", n=500, cainfo="C:/Users/GIS/Documents/tweets/cacert.pem") 


# track rate limits
rate.limit <- getCurRateLimitInfo(c("lists"))
