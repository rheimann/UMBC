#############################
###  TWITTER SEARCH ON A PC ####
#############################

## get working directory
getwd()

## set working directory
setwd("/Users/heimannrichard/Downloads/a b")

## install packages
install.packages("twitteR")
require(twitteR)
install.packages("ROAuth")
require(ROAuth)
install.packages("RCurl")
require(RCurl)

##
## register twitter application, get credentials and search Twitter
##

# #download a cerert.pem file and save it locally (Windows Machine)
download.file(url="http://curl.haxx.se/ca/cacert.pem", 
  destfile="/Users/heimannrichard/Downloads/a b/cacert.pem")

# save api key and secret key from your application api key generation. 
my.key <- "xx"
my.secret <- "xx"

# OAuth with request, access and auth URLs and key + secret
cred <- OAuthFactory$new(consumerKey=my.key,
                         consumerSecret=my.secret,
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')

# handshake with cred
cred$handshake(cainfo="/.../cacert.pem")

#Finally, save your authentication settings:  
save(cred, file="twitter_cred.Rdata")

# test whether you have successfully authorized with twitter api
registerTwitterOAuth(cred)

# track rate limits
rate.limit <- getCurRateLimitInfo(c("lists"))

yankees <- searchTwitter("yankees", n=50, cainfo="cacert.pem") 
head(yankees)
class(yankees)
yankees[1]

yankees.df <- do.call("rbind", lapply(yankees, as.data.frame)) 
head(yankees.df)
?View
View(head(yankees.df))

write.table(yankees.df, file="/Users/heimannrichard/Documents/yankees.csv", append=TRUE, sep=",", dec=".", na="NA", row.names=FALSE)


# loop to populate with pause to automate search
# sleepTime = time to sleep 
sleepTime <- 5
# loop
for (i in 1:5){
  Sys.sleep(sleepTime)
  # Download latest n tweets for search term
  yankees.2 <- searchTwitter("yankees", n=50, cainfo="cacert.pem") 
  yankees.df2 <- do.call("rbind", lapply(yankees.2, as.data.frame)) 
  # Save tweets to file
  write.table(yankees.df2, file="/Users/heimannrichard/Documents/yankees2.csv", append=TRUE, sep=",",
              dec=".", na="NA", row.names=F)
  print(i)
}

## read files from local directory
system.time(ar <- read.delim("/Users/heimannrichard/Desktop/ca_tweets/ca_tweets.csv", header=TRUE, 
                             dec=".", stringsAsFactors=FALSE, encoding="latin1", quote = "", sep="|"))

system.time(ar1 <- read.delim("/Users/heimannrichard/Desktop/ca_tweets/ca_tweets_1.csv", header=TRUE, 
                              dec=".", stringsAsFactors=FALSE, encoding="latin1", quote = "", sep="|"))

system.time(ar2 <- read.delim("/Users/heimannrichard/Desktop/ca_tweets/ca_tweets_2.csv", header=TRUE, 
                              dec=".", stringsAsFactors=FALSE, encoding="latin1", quote = "", sep="|"))

## bind files together
ar.all <- rbind(ar, ar1, ar2)
remove(ar, ar1, ar2)
colnames(ar.all)
## clean columns names
colnames(ar.all) <- c("text", "favorited", "favcnt", "replyTOSN", "created", "truncated",  
                      "replyTOSID", "id", "replyTOUID", "statusSource", "screenName", "retweetCNT",
                      "isRetweet", "retweeted", "long", "lat")

## clean data
# stemDocument(ar.all$text, language = "english")
ar.all$text <- gsub("\"", "", ar.all$text)
ar.all$id <- gsub("\"", "", ar.all$id)
ar.all$statusSource <- gsub("\"", "", ar.all$statusSource)
ar.all$screenName <- gsub("\"", "", ar.all$screenName)

## format column classes
# ar.all[, c(3,12)] <- sapply(ar.all[, c(3,12)], as.numeric)
# ar.all[, c(15:16)] <- sapply(ar.all[, c(15:16)], as.double)
ar.all$favcnt[is.na(ar.all$favcnt)] <- 0
ar.all$retweetCNT[is.na(ar.all$retweetCNT)] <- 0
ar.all$long[is.na(ar.all$long)] <- 0
ar.all$lat[is.na(ar.all$lat)] <- 0
ar.all$text <- iconv(ar.all$text, to = "utf-8", sub="")
# ar.all$text[!is.finite(ar.all$text)] <- 0

urls <- gsub(".*(http://t.co/[[:alnum:]]+).*", "\\1", ar.all$text)

# ar.all$text <- gsub("http://","", ar.all$text)
# ar.all$text <- gsub("www.","", ar.all$text)
# ar.all$text<- gsub('[[:punct:]]', ' ', ar.all$text)  
# ar.all$text<- gsub('[[:cntrl:]]', ' ', ar.all$text)
# ar.all$text<- gsub('\\d+', ' ', ar.all$text)

dat.tm <- Corpus(VectorSource(ar.all$text))  # make a corpus
# dat.tm <- tm_map(dat.tm, as.PlainTextDocument)  
# dat.tm <- tm_map(dat.tm, tolower)    # convert all words to lowercase
# dat.tm <- tm_map(dat.tm, removeWords, words=c("RT"))
# dat.tm <- tm_map(dat.tm, stripWhitespace)	# remove extra white space

en.stopwords <- stopwords("SMART")
spanish.stopwords <- stopwords("spanish")
stnd.stopwords <- c(en.stopwords, spanish.stopwords)
length(en.stopwords)
# [1] 571
length(spanish.stopwords)
# [1] 308
length(stnd.stopwords)
# [1] 879

# the standard stopwords are useful starting points but we may want to add corpus specific words 
# the words below have been added as a consequence of exploring BB from subsequent steps
# ar.stopwords<- c(stnd.stopwords, "district", "districts", "reported", "noted", "city", "cited",   
#                  "activity", "contacts", "chicago", "dallas", "kansas", "san", "richmond", "francisco", 	
#                  "cleveland", "atlanta", "sales", "boston", "york", "philadelphia", "minneapolis", 
#                  "louis", 	"services","year", "levels", " louis")


# create a term-document matrix
dtm <- DocumentTermMatrix(dat.tm, control = list(stemming = TRUE, 
                                                 stopwords = stnd.stopwords,
                                                 minWordLength = 2, 
                                                 tolower = TRUE,
                                                 removeNumbers = TRUE, 
                                                 removePunctuation = TRUE))

dim(dtm)

#remove sparse terms
#can't do topic model using all 33k ports
sparseless<- removeSparseTerms(dtm,.9995)
dim(sparseless)
require(slam)
#cbind requires simpletripletmatrix
finaldtm<- as.simple_triplet_matrix(sparseless)
finaldtm<- cbind(row_sums(dtm)-row_sums(sparseless),finaldtm)
#new term called "sparse port" is the sum of all the omitted words
finaldtm$dimnames[[2]][1] <- "sparse port"
rowTotals <- apply(dtm , 1, sum) #Find the sum of words in each Document
dtm.new   <- dtm[rowTotals> 0]

system.time(
  topicmod <- LDA(sparseless, k=5, control=list(seed=2010))
)
topicmod

# # > dim(dtm)
# # [1] 116515  15708
# 
# idf <- dim(dtm)[1] / col_sums(dtm>0)
# cutoff <- quantile(idf,50)
# dtm[, which(idf > cutoff)]
# 
# dtm1 <- dtm[apply(dtm, 2, Compose(is.finite, all)),]
# dtm2 <- dtm1[apply(dtm1, 1, Compose(is.finite, all)),]
# dim(dtm2)

# The mean term frequency-inverse document frequency (tf-idf) over documents containing this 
# term is used to select the vocabulary. This measure allows to omit terms which have low 
# frequency as well as those occurring in many documents. We only include terms which have a 
# tf-idf value of at least 0.1 which is a bit more than the median and ensures that the very 
# frequent terms are omitted.

summary(col_sums(dtm))
# Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
# 0.00     3.00     7.00    27.45    13.00 42300.00 
summary(row_sums(dtm))
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.000   4.000   8.000   7.431  11.000  25.000 

term_tfidf <- tapply(dtm$v/row_sums(dtm)[dtm$i], dtm$j, mean) * log2(nDocs(dtm)/col_sums(dtm > 0))

# summary(term_tfidf)
# term2_tfidf <- term_tfidf[!is.na(term_tfidf)]
# summary(term2_tfidf)

# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#  0.2136  1.1730  1.4320  1.8280  1.8830 16.8300   1 

dtm <- dtm[,term_tfidf >= 1.5]
dtm <- dtm[row_sums(dtm) > 0,]
summary(col_sums(dtm))

#Find the sum of words in each Document
rowTotals <- apply(dtm , 1, sum)
#remove all docs without words
dtm.new <- dtm[rowTotals> 0]
dtm.new <- dtm[which(rowTotals > 0)]

# packageurl <- "http://cran.r-project.org/src/contrib/Archive/tm/tm_0.5-9.1.tar.gz"
# install.packages(packageurl, contriburl=NULL, type="source")


# Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
# 1.00     6.00    12.00    54.44    22.00 17480.00 

dim(dtm)
# > dim(dtm)
# [1] 95335  4396

## aid in calculating k 
numtops<- c(8, 20, 32)
numtops<- c(4, 8, 12, 16, 20, 24, 28, 32, 36, 40)
PERP <- NULL
for(i in numtops){
  mm <- LDA(dtm, k=i)
  PERP <- c(PERP, perplexity(mm))
}
plot(numtops, PERP)

mm <- LDA(dtm, k=5)

library("topicmodels")
k <- 20
SEED <- 2010
system.time(ar <- list(VEM = LDA(dtm, k = k, control = list(seed = SEED)),
                       VEM_fixed = LDA(dtm, k = k,
                                       control = list(estimate.alpha = FALSE, seed = SEED)),
                       
                       Gibbs = LDA(dtm, k = k, method = "Gibbs",
                                   control = list(seed = SEED, burnin = 1000,
                                                  thin = 100, iter = 1000)),
                       
                       CTM = CTM(dtm, k = k,
                                 control = list(seed = SEED,
                                                var = list(tol = 10^-4), em = list(tol = 10^-3)))))

# To compare the fitted models we first investigate the α values of the models fitted with 
# VEM and α estimated and with VEM and α fixed.
sapply(ar[1:2], slot, "alpha")
# VEM  VEM_fixed 
# 0.06346325 1.66666667 

# We see that if α is estimated it is set to a value much smaller than the default. 
# This indicates that in this case the Dirichlet distribution has more mass at the corners and hence, 
# documents consist only of few topics. 

# The entropy measure can also be used to indicate how the topic distributions differ for the four 
# fitting methods. We determine the mean entropy for each fitted model over the documents. The term 
# distribution for each topic as well as the predictive distribution of topics for a document can be 
# obtained with posterior(). A list with components "terms" for the term distribution over topics and 
# "topics" for the topic distributions over documents is returned.

sapply(ar, function(x)mean(apply(posterior(x)$topics, 1, function(z) - sum(z * log(z)))))

# VEM VEM_fixed     Gibbs       CTM 
# 2.360779  3.382286  3.381233  3.129112 
# 
# Higher values indicate that the topic distributions are more evenly spread over the topics.

Topic <- topics(ar[["VEM"]], 1)
Terms <- terms(ar[["VEM"]], 8)
Terms[,1:30]


# termFreq(crude[[14]], control = ctrl)
# 
# dim(dtm)
# sparse.dtm <- removeSparseTerms(dtm,.995)
# dim(sparse.dtm)
# require(slam)
# finaldtm<- as.simple_triplet_matrix(sparse.dtm)
# 
# # #topic model
# # #pick k
# require(topicmodels)
#  system.time(
#    topicmod <- LDA(finaldtm, k=12, control=list(seed=2010))
#  )
# ar.all$topics<- topics(topicmod, 1)
# topicterms<- terms(topicmod,100)
# topicbeta<- topicmod@beta
# hist(ar.all$topics)

