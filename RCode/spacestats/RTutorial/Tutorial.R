#########################################
#### Geographic Analysis in R        ####
#### Yuri M. Zhukov                  ####
#### 26 February 2013                ####
#########################################


## Clear the workspace
rm(list=ls())

## Install packages
setRepositories(graphics = TRUE)
install.packages("maptools")
install.packages("proj4")
install.packages("classInt")
install.packages("spdep")
install.packages("spgwr")

## Load packages
library(maptools)
library(proj4)
library(classInt)
library(spdep)
library(spgwr)

## Set working directory (if you already downloaded the files)
setwd("MyDirectory/RTutorial")
source("functions.R")




####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
##########                                ##########
##########         The Basics             ##########
##########                                ##########
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################


###############################################
#### Point Data: North Carolina voters     ####
###############################################


## Load data
voters <- read.csv("Data/Voters.csv")

## Explore data
class(voters)
dim(voters)   # 60,848 voters, 16 variables 
head(voters)

## Create matrix of coordinates
xy_voters <- voters[,c("X_NC","Y_NC")]
head(xy_voters)

## Map it
par(mar=c(4,4,.5,.5))
plot(xy_voters, pch=16, cex=.3) 
# Looks distorted... let's put it on the right projection


## Projection: NAD_1983_StatePlane_North_Carolina_FIPS_3200
proj <- CRS("+proj=lcc +lat_1=34.33333333333334 +lat_2=36.16666666666666 +lat_0=33.75 +lon_0=-79 +x_0=609601.22 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs")
# Usage
# +proj=lcc   
#             +lat_1= 1st standard parallel (where projection surface touches globe)
#             +lat_2= 2nd standard parallel
#             +lat_0= Central parallel (y axis origin)
#             +lon_0= Central meridian (x axis origin)
#             +x_0= False Easting (constant added to eliminate negative numbers)
#             +y_0= False Northing 
#             +ellps= global reference ellipsoid (GRS80, WGS84)
#             +datum= datun name (NAD83, NAD27)
#             +units= m, us_ft

## Create spatial object
sp.points <- SpatialPointsDataFrame(coords=xy_voters,data=voters, proj4string=proj)
class(sp.points)

## Bounding box of data points
bbox(sp.points)

## Plot voters
par(mar=c(3,3,0.5,0.5))
plot(sp.points, pch=16, cex=.15, axes=T,cex.axis=.8)
# Looks better

## Plot Democrats vs. Republicans
cols <- ifelse(sp.points$PARTY=="DEMOCRATIC","blue",
		ifelse(sp.points$PARTY=="REPUBLICAN","red","grey"))
par(mar=rep(0,4))
plot(sp.points,pch=16, cex=.3, axes=T, col=cols)
legend("bottomleft",legend=c("Democrat","Republican","Independent"),fill=c("blue","red","grey"),bty="n")

## Plot by race
cols <- ifelse(sp.points$RACE=="WHITE","green","purple")
par(mar=rep(0,4))
plot(sp.points,pch=16, cex=.3, axes=T, col=cols)
legend("bottomleft",legend=c("White","Non-White"),fill=c("green","purple"),bty="n")

## Save as shapefile
#writePointsShape(sp.points,"Data/Voters")

##############################################
#### Polygon Data: NC Voter Precincts     ####
##############################################

## Load shapefile
sp.poly <- readShapePoly("Data/NC_Counties")

## Explore data
class(sp.poly)
dim(sp.poly)   # 100 counties, 10 variables 
summary(sp.poly)
names(sp.poly)

## Projection: NAD_1983_StatePlane_North_Carolina_FIPS_3200
proj4string(sp.poly) <- CRS("+proj=lcc +lat_1=34.33333333333334 +lat_2=36.16666666666666 +lat_0=33.75 +lon_0=-79 +x_0=609601.22 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs")
summary(sp.poly)

## Plot basemap of counties
par(mar=c(0,0,0,0))
plot(sp.poly)


######
## Plotting Attributes
######

names(sp.poly)

## Binary (Red/Blue)
cols <- ifelse(sp.poly$OBAMA2008 > sp.poly$MCCAIN2008,"blue","red")

#pdf(paste(var.name,".pdf",sep=""),width=4,height=3)
par(mar=rep(0,4))
plot(sp.poly,col=cols,border="grey",lwd=.4)
legend(x="bottom",cex=.7,fill=c("red","blue"),bty="n",legend=c("McCain","Obama"),title="Winner (2008)",ncol=2)

## Continuous: spplot (easy, but unflexible)
br.palette <- colorRampPalette(c("red","blue"), space = "rgb")
spplot(sp.poly, zcol="OBAMA2008", col.regions=br.palette(100), main="% Obama vote (2008)")

dev.off()

## Continuous: custom palette (more flexibile)
var <- sp.poly$OBAMA2008	# Extract a variable  
cols <- custom.palette(var=var,col.vec=c("red","blue"),n.color=5)
attributes(cols)

dev.off()
par(mar=rep(0,4))
plot(sp.poly,col=cols,border=NA)
legend(x="bottom",cex=.7,fill=attr(cols,"palette"),bty="n",legend=round.intervals(cols,0),title="% Obama vote (2008)",ncol=3)

## Examine other options
custom.palette(var=var,col.vec=c("red","blue"),n.color=5,choose=T)

## Plot using quantiles
dev.off()
cols <- custom.palette(var=var,col.vec=c("red","blue"),n.color=5,style="quantile")
par(mar=rep(0,4))
plot(sp.poly,col=cols,border=NA)
legend(x="bottom",cex=.7,fill=attr(cols,"palette"),bty="n",legend=round.intervals(cols,2),title="% Obama vote (2008), quantiles",ncol=2)

## Add voters
plot(sp.points, pch=16, cex=.15, col=rgb(0,1,0,alpha=.5), add=T)
legend(x="topright",cex=.7,pch=16,col="green",bty="n",legend="Voter ID challenge in 2012",title=NA,ncol=1)
dev.off()



#########################################
#### Data Management                 ####
#########################################


## What if you have some date you'd like to merge with a map?

mat <- read.csv("Data/NC_Kerry2004_county.csv")
class(mat)
dim(mat)	# 100 rows (same as shapefile)

head(mat)
names(mat)
names(sp.poly)


## The two maps have common variable: ID
sp.poly2 <- sp.merge(sp_data=sp.poly,tab_data=mat,id="ID")
names(sp.poly2)

## Plot difference between Kerry's and Obama's vote shares
var <- sp.poly2$OBAMA2008-sp.poly2$KERRY2004
cols <- custom.palette(var=var,col.vec=c("red","blue"),n.color=5)

par(mar=c(0,0,0,0))
plot(sp.poly,col=cols,border=NA)
legend(x="bottom",cex=.7,fill=attr(cols,"palette"),bty="n",legend=round.intervals(cols,2),title="Obama 2008 - Kerry 2004 (%)",ncol=4)

## Add voters
plot(sp.points, pch=16, cex=.1, col=rgb(0,1,0,alpha=.5), add=T)
legend(x="topright",cex=.7,pch=16,col="green",bty="n",legend="Voter ID challenge in 2012",title=NA,ncol=1)
dev.off()

## Save new shapefile
# writePolyShape(sp.poly2, "NC_Counties_Merged")




##################################
#### Overlays                 ####
##################################

######
## Q: What kind of counties do the voters live in?
######

# Overlay polygon and points
ovr <- overlay(x=sp.poly2,y=sp.points)

# Bind captured data to points dataframe
x2 <- cbind(sp.points, ovr)
head(x2)

# Average Obama vote in counties where challenged voters live
summary(x2$OBAMA2008,na.rm=T)
summary(sp.poly2$OBAMA2008,na.rm=T)
# Voter ID challenges in more democratic-leaning counties 

# Average Obama gain over Kerry 
# in counties where challenged voters live
summary(x2$OBAMA2008-x2$KERRY2004,na.rm=T)

# Statewide (unweighted) Obama - Kerry average
summary(sp.poly2$OBAMA2008-sp.poly2$KERRY2004)

# Challenged voters live in counties where 
# Obama's gain over Kerry was 4% higher than the state average 


######
## Q: How many voter ID challenges per county?
######

# Number of voter ID cases per county
mat <- aggregate(rep(1,nrow(x2)),by=list(ID=x2$ID),FUN=sum)
names(mat) <- c("ID","N_VOTERID")
head(mat)

## Merge back to counties
sp.poly3 <- sp.merge(sp_data=sp.poly2,tab_data=mat,id="ID")
sp.poly3$N_VOTERID[is.na(sp.poly3$N_VOTERID)] <- 0
summary(sp.poly3)

## Plot number of voter ID chalenges by county
var <- sp.poly3$N_VOTERID
cols <- custom.palette(var=var,col.vec=c("lightgrey","black"), n.color=5,style="quantile")
par(mar=c(0,0,0,0))
plot(sp.poly,col=cols,border=NA)
legend(x="bottom",cex=.7,fill=attr(cols,"palette"),bty="n",legend=round.intervals(cols,rnd=0),title="Number of voter ID challenges (2012), quantile",ncol=2)


######
## Q: Did the demographics of challenged voters vary by county?
######

## Create dummy variables
x2$NONWHITE <- x2$RACE!="WHITE"
x2$AGE_18_25 <- x2$AGE=="Age 18 - 25"
x2$NON_NC <- x2$BIRTH_PLACE!="NC"
x2$YOUNG_NON_NC <- x2$BIRTH_PLACE!="NC"&x2$AGE=="Age 18 - 25"

## Aggregate voter attributes
mat <- aggregate(as.data.frame(x2)[,c("NONWHITE","AGE_18_25","NON_NC","YOUNG_NON_NC")],by=list(ID=x2$ID),FUN=function(x){mean(x,na.rm=T)*100})

## Merge back to counties
sp.poly4 <- sp.merge(sp_data=sp.poly3,tab_data=mat,id="ID")
sp.poly4$N_VOTERID[is.na(sp.poly4$N_VOTERID)] <- 0
summary(sp.poly4)

## Plot ethnic distribution of voter ID chalenge
var <- sp.poly4$NONWHITE
cols <- custom.palette(var=var,col.vec=c("lightgrey","black"), n.color=5,style="quantile")
par(mar=c(0,0,0,0))
plot(sp.poly,col=cols,border=NA)
legend(x="bottom",cex=.7,fill=attr(cols,"palette"),bty="n",legend=round.intervals(cols,rnd=2),title="Percent minority voter ID challenges (2012), quantile",ncol=2)


## Compare to ethnic distribution of counties
var <- sp.poly4$NONWHT_PCT
cols <- custom.palette(var=var,col.vec=c("lightgrey","black"), n.color=5,style="quantile")
par(mar=c(0,0,0,0))
plot(sp.poly,col=cols,border=NA)
legend(x="bottom",cex=.7,fill=attr(cols,"palette"),bty="n",legend=round.intervals(cols,rnd=2),title="Percent minority population (2012), quantile",ncol=2)


######
## Run quick Poisson regression
######

sp.poly3$OBAMAGAIN <- sp.poly3$OBAMA2008-sp.poly3$KERRY2004
mod <- glm(N_VOTERID~OBAMAGAIN,data=sp.poly3,family="poisson")
summary(mod)
mod <- glm(N_VOTERID~OBAMAGAIN+NONWHT_PCT+COLLEGE+VETERAN+INCMED,data=sp.poly3,family="poisson")
summary(mod)


####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
##########                                ##########
##########    Spatial autocorrelation     ##########
##########            & weights           ##########
##########                                ##########
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################




#########################################
#### Spatial Autocorrelation         ####
#########################################

## Load spdep package
library(spdep)

data <- sp.poly4

## Create matrix of polygon centroids
map_crd <- coordinates(data)

## Contiguity Neighbors
W_cont <- poly2nb(data, queen=T)
W_cont_mat <- nb2listw(W_cont, style="W", zero.policy=TRUE)

## Plot the connections
par(mar=rep(0,4))
plot(sp.poly4,lwd=.5,border="lightgrey")
plot(W_cont_mat,coords=map_crd,pch=19,cex=0.5,col="blue",add=T)

dev.off()


## Global Autocorrelation Tests: Moran's I
moran.test(data$OBAMA2008, listw=W_cont_mat, zero.policy=T)

## Global Autocorrelation Tests: Geary's C
geary.test(data$OBAMA2008, listw=W_cont_mat, zero.policy=T)

## Global Autocorrelation Tests: Join Count
data$OBAMAWIN <- as.factor(ifelse(data$OBAMA2008 > data$MCCAIN2008,1,0))
joincount.multi(data$OBAMAWIN, listw=W_cont_mat, zero.policy=T)

## Moran Scatterplot
par(mar=c(4,4,1.5,0.5))
moran.plot(data$OBAMA2008, listw=W_cont_mat, zero.policy=T, xlim=c(0,100),ylim=c(0,100), pch=16, col="black",cex=.5, quiet=F, labels=as.character(data$COUNTY_NAM),xlab="Percent for Obama", ylab="Percent for Obama (Spatial Lag)", main="Moran Scatterplot")

## Local Autocorrelation: Local Moran's I (normality assumption)
lm1 <- localmoran(data$OBAMA2008, listw=W_cont_mat, zero.policy=T)
data$lm1 <- abs(lm1[,4]) ## Extract z-scores
lm.palette <- colorRampPalette(c("white","orange", "red"), space = "rgb")
spplot(data, zcol="lm1", col.regions=lm.palette(20), main="Local Moran's I (|z| scores)", pretty=T)


#####
## Simulated Autocorrelation
#####

## Let's make some fake data
weights <- W_cont_mat
n <- length(W_cont)
uncorr_x <- rnorm(n)
rho1 <- .9
rho2 <- -.9
autocorr_x <- invIrW(weights, rho1) %*% uncorr_x
ncorr_x <- invIrW(weights, rho2) %*% uncorr_x
w.uncorr_x <- lag(weights, uncorr_x, zero.policy=T, NAOK=T)
w.autocorr_x <- lag(weights, autocorr_x, zero.policy=T, NAOK=T)
w.ncorr_x <- lag(weights, ncorr_x, zero.policy=T, NAOK=T)

####
## Uncorrelated variable
####

## Plot observed vs. lagged values
dev.off()
par(mar=c(4,4,2.5,.5))
plot(uncorr_x, w.uncorr_x, xlab="Y ~ N(0, 1)", ylab="Spatial Lag of Y", main=expression(symbol("\162") == 0),col="grey",cex=.5,xlim=c(-4,4),ylim=c(-4,4))
abline(a=0,b=1,lty="dotted")
lines(lowess(uncorr_x, w.uncorr_x), lty=2, lwd=2, col="red")
legend(x="bottomright", lty=2, lwd=2, col="red", legend="LOESS Curve", bty="n")

## Map it
var <- uncorr_x
cols <- custom.palette(var=var,col.vec=c("lightgrey","black"), n.color=5,style="quantile")
par(mar=c(0,0,0,0))
plot(sp.poly,col=cols,border=NA,main="No autocorrelation")
text(x=(bbox(sp.poly)[1,1]+bbox(sp.poly)[1,2])/2,y=bbox(sp.poly)[2,2]+(bbox(sp.poly)[2,1]+bbox(sp.poly)[2,2])/5,label="No autocorrelation",cex=1.5)

dev.off()

####
## Autocorrelated variable
####

## Plot observed vs. lagged values
par(mar=c(4,4,2.5,.5))                 
plot(autocorr_x, w.autocorr_x, xlab="Y ~ N(0, 1)", ylab="Spatial Lag of Y", main=expression(symbol("\162") == .9),col="grey",cex=.5,xlim=c(-4,4),ylim=c(-4,4))
abline(a=0,b=1,lty="dotted")
lines(lowess(autocorr_x, w.autocorr_x), lty=2, lwd=2, col="red")

## Map it
var <- autocorr_x
cols <- custom.palette(var=var,col.vec=c("lightgrey","black"), n.color=5,style="quantile")
par(mar=c(0,0,0,0))
plot(sp.poly,col=cols,border=NA)
text(x=(bbox(sp.poly)[1,1]+bbox(sp.poly)[1,2])/2,y=bbox(sp.poly)[2,2]+(bbox(sp.poly)[2,1]+bbox(sp.poly)[2,2])/5,label="Positive autocorrelation",cex=1.5)


####
## Negatively correlated variable
####

## Plot observed vs. lagged values
par(mar=c(4,4,2.5,.5))
plot(ncorr_x, w.ncorr_x, xlab="Y ~ N(0, 1)", ylab="Spatial Lag of Y", main=expression(symbol("\162") == -.9), ,xlim=c(-4,4),ylim=c(-4,4),col="grey",cex=.5)
abline(a=0,b=1,lty="dotted")
lines(lowess(ncorr_x, w.ncorr_x), lty=2, lwd=2, col="red")

## Map it
var <- ncorr_x
cols <- custom.palette(var=var,col.vec=c("lightgrey","black"), n.color=5,style="quantile")
par(mar=c(0,0,0,0))
plot(sp.poly,col=cols,border=NA)
text(x=(bbox(sp.poly)[1,1]+bbox(sp.poly)[1,2])/2,y=bbox(sp.poly)[2,2]+(bbox(sp.poly)[2,1]+bbox(sp.poly)[2,2])/5,label="Negative autocorrelation",cex=1.5)

dev.off()





#################################
#### Spatial Weights         ####
#################################

## Open world map
data(wrld_simpl)
data <- wrld_simpl
data <- data[data$POP2005>100,] ## Include only territories w/ people
data$ID <- 1:nrow(data)
IDs <- data$ID
dim(data)
names(data)

## Create matrix of polygon centroids
map_crd <- coordinates(data)


#########
## Contiguity
#########

## Contiguity Neighbors (no snap distance)
W_cont <- poly2nb(data, queen=T)
W_cont_mat <- nb2listw(W_cont, style="W", zero.policy=TRUE)

## Contiguity Neighbors (snap distance = 500km)
W_cont_s <- poly2nb(data, queen=T, snap=km2d(500))
W_cont_s_mat <- nb2listw(W_cont_s, style="W", zero.policy=TRUE)

## Plot the connections

par(mfrow=c(1,2),mar=c(0,0,1,0))
plot(data,border="grey")
plot(W_cont_mat,coords=map_crd,pch=19, cex=0.1, col="blue", add=T)
#title("Border Contiguity")
plot(data,border="grey")
plot(W_cont_s_mat,coords=map_crd,pch=19, cex=0.1, col=rgb(0,0,1,alpha=.4), add=T)
title("Contiguity + 500 km")

dev.off()



#########
## k nearest neighbors
#########

## k=1
W_knn1 <- knn2nb(knearneigh(map_crd, k=1), row.names=IDs)
W_knn1_mat <- nb2listw(W_knn1)

## k=4
W_knn4 <- knn2nb(knearneigh(map_crd, k=4), row.names=IDs)
W_knn4_mat <- nb2listw(W_knn4)

## Plot the connections
par(mfrow=c(1,2),mar=c(0,0,1,0))
plot(data,border="grey")
plot(W_knn1_mat,coords=map_crd,pch=19, cex=0.1, col="blue", add=T)
title("k=1")
plot(data,border="grey")
plot(W_knn4_mat,coords=map_crd,pch=19, cex=0.1, col="blue", add=T)
title("k=4")

dev.off()



#########
## Interpoint distance weights
#########


## Minimum Distance
dists <- unlist(nbdists(W_knn1, map_crd))
W_dist1 <- dnearneigh(map_crd, d1=0, d2=max(dists), row.names=IDs) 
W_dist1_mat <- nb2listw(W_dist1)

## Plot the connections
par(mfrow=c(1,1),mar=c(0,0,1,0))
plot(data,border="grey")
plot(W_dist1_mat,coords=map_crd,pch=19, cex=0.1, col=rgb(0,0,1,alpha=.4), add=T)
title("Minimum Distance")

dev.off()



#########
## Sphere of influence neighbors
#########

## SOI
W_del <- tri2nb(map_crd)
W_soi <- graph2nb(soi.graph(W_del, map_crd))
W_soi_mat <- nb2listw(W_soi)

## Plot the connections
par(mfrow=c(1,1),mar=c(0,0,1,0))
plot(data,border="grey")
plot(W_soi_mat,coords=map_crd,pch=19, cex=0.1, col="blue", add=T)
title("Sphere of Influence")

dev.off()





####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
##########                                ##########
##########     Spatial regression         ##########
##########                                ##########
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################



#########################################
#### Spatial Regression              ####
#########################################


data <- sp.poly4
names(data)


###############
## OLS Model ##
###############

data$MARGIN <- data$OBAMA2008-data$MCCAIN2008
mod.lm <- lm(MARGIN ~ NONWHT_PCT+COLLEGE+VETERAN+INCMED, data=data)
summary(mod.lm)


## Plot residuals
res <- mod.lm$residuals
cols <- c()
cols[res<(-10)] <- "green4"
cols[res>=(-10)&res<(-5)] <- "green1"
cols[res>=(-5)&res<5] <- "white"
cols[res<10&res>=5] <- "red1"
cols[res>=10] <- "red4"

par(mar=rep(0,4))
plot(data,col=cols, main="Residuals from OLS Model", pretty=T, border="grey")
legend(x="bottom",cex=.8,fill=c("green4","green1","white","red1","red4"),bty="n",legend=c("(, -10)","[-10, -5)","[-5, 5)","[5,10)","[10, )"),title="Residuals from OLS Model",ncol=5)

dev.off()

## Contiguity Neighbors
W_cont <- poly2nb(data, queen=T)
W_cont_mat <- nb2listw(W_cont, style="W", zero.policy=TRUE)

## Residual Autocorrelation
moran.test(res, listw=W_cont_mat, zero.policy=T)



###############
## SAR Model ##
###############


mod.sar <- lagsarlm(MARGIN ~ NONWHT_PCT+COLLEGE+VETERAN+INCMED, data = data, listw=W_cont_mat, zero.policy=T, tol.solve=1e-12)
summary(mod.sar)

## Plot residuals
res <- mod.sar$residuals
cols <- c()
cols[res<(-10)] <- "green4"
cols[res>=(-10)&res<(-5)] <- "green1"
cols[res>=(-5)&res<5] <- "white"
cols[res<10&res>=5] <- "red1"
cols[res>=10] <- "red4"

par(mar=rep(0,4))
plot(data,col=cols, border="grey")
legend(x="bottom",cex=.8,fill=c("green4","green1","white","red1","red4"),bty="n",legend=c("(, -10)","[-10, -5)","[-5, 5)","[5,10)","[10, )"),title="Residuals from SAR Model",ncol=5)

dev.off()

## Residual Autocorrelation
moran.test(res, listw=W_cont_mat, zero.policy=T)



###############
## SEM Model ##
###############


mod.sem <- errorsarlm(MARGIN ~ NONWHT_PCT+COLLEGE+VETERAN+INCMED, data = data, listw=W_cont_mat, zero.policy=T, tol.solve=1e-15)
summary(mod.sem)


## Plot residuals
res <- mod.sem$residuals
cols <- c()
cols[res<(-10)] <- "green4"
cols[res>=(-10)&res<(-5)] <- "green1"
cols[res>=(-5)&res<5] <- "white"
cols[res<10&res>=5] <- "red1"
cols[res>=10] <- "red4"

par(mar=rep(0,4))
plot(data,col=cols, border="grey")
legend(x="bottom",cex=.8,fill=c("green4","green1","white","red1","red4"),bty="n",legend=c("(, -10)","[-10, -5)","[-5, 5)","[5,10)","[10, )"),title="Residuals from SEM Model",ncol=5)

dev.off()

## Residual Autocorrelation
moran.test(res, listw=W_cont_mat, zero.policy=T)



###############
## SDM Model ##
###############


mod.sdm <- lagsarlm(MARGIN ~ NONWHT_PCT+COLLEGE+VETERAN+INCMED, data = data, listw=W_cont_mat, zero.policy=T, type="mixed", tol.solve=1e-12)
summary(mod.sdm)


## Plot residuals
res <- mod.sdm$residuals
cols <- c()
cols[res<(-10)] <- "green4"
cols[res>=(-10)&res<(-5)] <- "green1"
cols[res>=(-5)&res<5] <- "white"
cols[res<10&res>=5] <- "red1"
cols[res>=10] <- "red4"


par(mar=rep(0,4))
plot(data,col=cols, border="grey")
legend(x="bottom",cex=.8,fill=c("green4","green1","white","red1","red4"),bty="n",legend=c("(, -10)","[-10, -5)","[-5, 5)","[5,10)","[10, )"),title="Residuals from SDM Model",ncol=5)

dev.off()

## Residual Autocorrelation
moran.test(res, listw=W_cont_mat, zero.policy=T)



##########################################
## Marginal effects                     ##
##########################################


## Extract Weights 
W <- nb2mat(W_cont) 	# convert from neighbor list to matrix

# Create identify matrix
I <- matrix(0,nrow=nrow(data),ncol=nrow(data))
diag(I) <- 1

var.name <- "COLLEGE"

# Create design matrix
X0 <- cbind(as.data.frame(data)[,var.name])
X1 <- cbind(as.data.frame(data)[,var.name])
data$COUNTY_NAM[31]
X1[31] <- .5*X1[31]  ## College grad rate in Durham County falls in half

########
## SAR
########

# Extract SAR coefficients
beta.sar <- mod.sar$coefficients
rho.sar <- mod.sar$rho

# Predict
Y0 <- solve(I - rho.sar*W)%*%X0*beta.sar[names(beta.sar)==var.name]
Y1 <- solve(I - rho.sar*W)%*%X1*beta.sar[names(beta.sar)==var.name]
fd.sar <- Y1-Y0

## Plot Effects (SAR)
var <- fd.sar
cols <- custom.palette(var=var,col.vec=c("darkblue","white"), n.color=6,style="kmeans")
cols[var==0] <- "white"
par(mar=rep(0,4))
plot(data,col=cols, border="grey")
plot(data[31,],col=cols[31], border="yellow",add=T)
legend(x="bottom",cex=.8,fill=attr(cols,"palette"),bty="n",legend=round.intervals(cols,2),title="Counterfactual: Durham college population drops in half.\n Quantity of interest: Change in Obama vote margin",ncol=3)
text(x=(bbox(sp.poly)[1,1]+bbox(sp.poly)[1,2])/2,y=bbox(sp.poly)[2,2]+(bbox(sp.poly)[2,1]+bbox(sp.poly)[2,2])/5,label="SAR",cex=1.5)

########
## OLS
########

## Extract OLS coefficients
beta.lm <- mod.lm$coefficients
rho.lm <- 0

# Predict
Y0 <- solve(I - rho.lm*W)%*%X0*beta.lm[names(beta.lm)==var.name]
Y1 <- solve(I - rho.lm*W)%*%X1*beta.lm[names(beta.lm)==var.name]
fd.lm <- Y1-Y0

## Plot Effects (OLS)
var <- fd.lm
cols <- custom.palette(var=var,col.vec=c("darkblue","white"), n.color=2)
#cols[var==0] <- "white"
par(mar=rep(0,4))
plot(data,col=cols, border="grey")
plot(data[31,],col=cols[31], border="yellow",add=T)
legend(x="bottom",cex=.8,fill=attr(cols,"palette"),bty="n",legend=c(round(var[31],2),0),title="Counterfactual: Durham college population drops in half.\n Quantity of interest: Change in Obama vote margin",ncol=1)
text(x=(bbox(sp.poly)[1,1]+bbox(sp.poly)[1,2])/2,y=bbox(sp.poly)[2,2]+(bbox(sp.poly)[2,1]+bbox(sp.poly)[2,2])/5,label="OLS",cex=1.5)


#############
## Short-cut: off-the-shelf SAR predict function
#############

# Set up design matrix
X0 <- as.data.frame(mod.sar$X)
X1 <- X0
X1[31,3] <- .5*X1[31,3] # Halve Durham's college rate

# Predict
Y0 <- predict.sarlm(mod.sar,newdata=X0,listw=W_cont_mat)
Y1 <- predict.sarlm(mod.sar,newdata=X1,listw=W_cont_mat)
fd.sar <- Y1-Y0

## Plot Effects (SAR)
var <- as.data.frame(fd.sar)[,1]
cols <- custom.palette(var=var,col.vec=c("darkblue","white"), n.color=5,style="kmeans")
cols[var==0] <- "white"
par(mar=rep(0,4))
plot(data,col=cols, border="grey")
plot(data[31,],col=cols[31], border="yellow",add=T)
legend(x="bottom",cex=.8,fill=attr(cols,"palette"),bty="n",legend=round.intervals(cols,2),title="Counterfactual: Durham college population drops in half.\n Quantity of interest: Change in Obama vote margin",ncol=3)
text(x=(bbox(sp.poly)[1,1]+bbox(sp.poly)[1,2])/2,y=bbox(sp.poly)[2,2]+(bbox(sp.poly)[2,1]+bbox(sp.poly)[2,2])/5,label="SAR",cex=1.5)

# OLS
Y0 <- predict(mod.lm,newdata=X0)
Y1 <- predict(mod.lm,newdata=X1)
fd.lm <- Y1-Y0

## Plot Effects (OLS)
var <- fd.lm
cols <- custom.palette(var=var,col.vec=c("darkblue","white"), n.color=2)
#cols[var==0] <- "white"
par(mar=rep(0,4))
plot(data,col=cols, border="grey")
plot(data[31,],col=cols[31], border="yellow",add=T)
legend(x="bottom",cex=.8,fill=attr(cols,"palette"),bty="n",legend=c(round(var[31],2),0),title="Counterfactual: Durham college population drops in half.\n Quantity of interest: Change in Obama vote margin",ncol=2)
text(x=(bbox(sp.poly)[1,1]+bbox(sp.poly)[1,2])/2,y=bbox(sp.poly)[2,2]+(bbox(sp.poly)[2,1]+bbox(sp.poly)[2,2])/5,label="OLS",cex=1.5)


########################################
## Geographically weighted regression ##
########################################


## WARNING: This takes a while to run with bigger datasets
bwG <- gwr.sel(MARGIN ~ NONWHT_PCT+COLLEGE+VETERAN+INCMED, data = data, gweight=gwr.Gauss, verbose=F)
mod.gwr <- gwr(MARGIN ~ NONWHT_PCT+COLLEGE+VETERAN+INCMED, data = data, bandwidth=bwG, gweight=gwr.Gauss)
mod.gwr
summary(mod.gwr)
mod.gwr$lm

sd(mod.gwr$SDF$X.Intercept.)
sd(mod.gwr$SDF$NONWHT_PCT)
sd(mod.gwr$SDF$COLLEGE)
sd(mod.gwr$SDF$VETERAN)
sd(mod.gwr$SDF$INCMED)
names(mod.gwr$SDF)


## Coefficients
coef <- mod.gwr$SDF$COLLEGE
cols <- custom.palette(coef,c("green","white","red"),n.color=5)
par(mar=rep(0,4))
plot(data,col=cols, border="grey",pretty=T)
legend(x="bottom",cex=1,fill=attr(cols,"palette"),bty="n",legend=names(attr(cols, "table")),title="Local Coefficient Estimates (% college educated)",ncol=3)


## Residuals
res <- mod.gwr$SDF$gwr.e
cols <- c()
cols[res<(-10)] <- "green4"
cols[res>=(-10)&res<(-5)] <- "green1"
cols[res>=(-5)&res<5] <- "white"
cols[res<10&res>=5] <- "red1"
cols[res>=10] <- "red4"
par(mar=rep(0,4))
plot(data,col=cols, border="grey",pretty=T)
legend(x="bottom",cex=.8,fill=c("green4","green1","white","red1","red4"),bty="n",legend=c("(, -10)","[-10, -5)","[-5, 5)","[5,10)","[10, )"),title="Residuals from GWR Model",ncol=5)

## Residual Autocorrelation
moran.test(res, listw=W_cont_mat, zero.policy=T)

dev.off()
