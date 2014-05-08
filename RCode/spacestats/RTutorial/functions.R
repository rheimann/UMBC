#############################
## Custom palette function ## 
#############################

custom.palette <- function(var,col.vec,n.color=5,choose=F,style="pretty",fixedBreaks){
	
col.ramp <- colorRampPalette(col.vec, space = "rgb")


library(classInt)

# Create palette with n color classes
pal <- col.ramp(n=n.color) 

## (1) Show options
if(choose==T){
#classes_fx <- classIntervals(var, n=n.color, style="fixed", fixedBreaks=pretty(var,min.n=3,n=n.color), rtimes = 1)
classes_pr<-classIntervals(var,n=n.color,style="pretty",rtimes=1)
classes_sd<-classIntervals(var,n=n.color,style="sd",rtimes=1)
classes_fi<-classIntervals(var,n=n.color,style="fisher",rtimes=3)
classes_eq<-classIntervals(var,n=n.color,style="equal",rtimes=1)
classes_km<-classIntervals(var,n=n.color,style="kmeans",rtimes=1)
classes_qt<-classIntervals(var,n=n.color,style="quantile",rtimes=1)
classes_hc<-classIntervals(var,n=n.color,style="hclust",rtimes=1)
classes_bc<-classIntervals(var,n=n.color,style="bclust",rtimes=1)

par(mar=c(2,2,2,1)+0.1, mfrow=c(2,4))
#plot(classes_fx, pal=pal, main="Fixed Intervals", xlab="", ylab="")
plot(classes_pr, pal=pal, main="pretty", xlab="", ylab="")
plot(classes_sd, pal=pal, main="sd", xlab="", ylab="")
plot(classes_fi, pal=pal, main="fisher (jenks)", xlab="", ylab="")
plot(classes_km, pal=pal, main="kmeans", xlab="", ylab="")
plot(classes_eq, pal=pal, main="equal", xlab="", ylab="")
plot(classes_qt, pal=pal, main="quantile", xlab="", ylab="")
plot(classes_hc, pal=pal, main="hclust", xlab="", ylab="")
plot(classes_bc, pal=pal, main="bclust", xlab="", ylab="")
}

## (2) Create cupoints
if(choose==F){
	
## Define intervals
classes<-classIntervals(var,n=n.color,style=style,rtimes=1)
if(style=="fixed"){classes <- classIntervals(var, n=n.color, style="fixed", fixedBreaks=fixedBreaks, rtimes = 1)}

## Create vector of colors
cols <- findColours(classes, pal)
return(cols)	
}
}


####################################
## round.intervals                ## 
####################################


round.intervals <- function(cols,rnd){
labs <- names(attr(cols, "table"))
labs <- gsub("[","",labs,perl=F,fixed=T)
labs <- gsub("]","",labs,perl=F,fixed=T)
labs <- gsub("(","",labs,perl=F,fixed=T)
labs <- gsub(")","",labs,perl=F,fixed=T)
labs <- strsplit(labs,",")
labs <- round(as.numeric(unlist(labs)),rnd)
nn <- length(labs)/2
labs. <- list()
for(i in 1:nn){
	labs.[[i]] <- labs[c(2*i-1,2*i)]
	labs.[[i]] <- paste("[",paste(labs.[[i]],collapse=", "),")",sep="")
}
labs.[[length(labs.)]] <- gsub(")","]",labs.[[length(labs.)]],fixed=T)
labs. <- unlist(labs.)
return(labs.)}

#############################
## sp.merge                ## 
#############################

sp.merge <- function(sp_data,tab_data,id,id_tab=id){

# Extract data.frame from map
m_data <- as.data.frame(sp_data)

# Use merge() to join new data to map data.frame
m_data <- merge(x=m_data, y=tab_data, by.x=id, by.y=id_tab, all.x=T, all.y=F)



# Make sure row order is the same
m_data <- m_data[order(order(as.data.frame(sp_data)[,id])),]

# If not same, error
if(mean(as.data.frame(sp_data)[,id]==m_data[,id])!=1){print("Error: row order/name mismatch")}

# If same, use spCbind to join merged data.frame to map
if(mean(as.data.frame(sp_data)[,id]==m_data[,id])==1){row.names(m_data) <- row.names(sp_data)
data2 <- spCbind(sp_data,m_data)

# Remove duplicate columns
data2 <- data2[,!grepl(".1",names(data2),fixed=T)]

return(data2)}

}





#####################################
#### Distance Conversion         ####
#####################################


## Function: Convert km to degrees
km2d <- function(km){
out <- (km/1.852)/60
return(out)
}
km2d(500) ## 500 km

## Function: Convert m to degrees
m2d <- function(m){
out <- (m/1852)/60
return(out)
}
m2d(500) ## 500 km

## Function: Convert degrees to km
d2km <- function(d){
out <- d*60*1.852
return(out)
}

## Function: Convert degrees to m
d2m <- function(d){
out <- d*60*1852
return(out)
}


#####################################
## Define Gibbs sampler            ##
#####################################




gibbs.generator <- function(y,x,W,psi,gibbs.burnin=burnin,gibbs.sample=nsamp,gibbs.interval=gibbs.interval){
   gather <- 1
   k <-1 
   ncov <- dim(x)[2] # X has covariates only
   c.cur <- vector("numeric",length(y))
   suff <- matrix(0,(gibbs.sample/gibbs.interval),(2+ncov))
   dimnames(suff) <- list(NULL,c("c.cur",unlist(dimnames(x)[2]),"W"))
   for (i in 1:(gibbs.burnin+gibbs.sample)){
    for (j in 1: length(c.cur)){
       eta <- (exp(psi[1]+sum(psi[(length(psi)-1)]*x[j,])+psi[length(psi)]*(W%*%c.cur)[j])) 
        phat <- eta/(1+eta)
        if(runif(1,0,1) < phat){
	   c.cur[j] <- 1
        } else {c.cur[j] <- 0}
      } 
      if (i == gather+gibbs.burnin) {  
	suff[k,1] <- sum(c.cur)
        for (m in 1:ncov){	 
	    suff[k,(m+1)] <- sum(c.cur*x[,m])
        }
	suff[k,dim(suff)[2]] <- 0.5*sum(W%*%c.cur)
	gather <- gather + gibbs.interval 
	k <- k + 1 
      } 
      cat("Gibbs sample is :",i," of ",gibbs.sample,"\n") 
   } 
   return(list(suff = suff, psi= psi, c.cur = c.cur))
}


#####################################
## Define Newton-Raphson algorithm ##
#####################################

newton.raphson2<- function(xobs, xsim, psi, start.psi = psi, maxiter = 30, eps1 = 1e-15, eps2 = 1e-08,
	look = F, do.mc.se = T, lag.max = round(nrow(xsim)^0.5))
{
	iter <- 0
	nxt <- start.psi - psi
	av <- apply(xsim, 2, mean)
	xobs <- xobs - av
	xsim <- sweep(xsim, 2, av)
	ll <- 0
	repeat {
		iter <- iter + 1
		cur <- nxt
		prob <- exp(xsim %*% cur)
		prob <- prob/sum(prob)
		E <- apply(sweep(xsim, 1, prob, "*"), 2, sum)
		vtmp <- sweep(sweep(xsim, 2, E, "-"), 1, prob^0.5, "*")
		V <- t(vtmp) %*% vtmp
		nxt <- cur + (delt <- solve(V, xobs - E))
		ll.old <- ll
		repeat {
			ll <- sum(xobs * nxt) - log(mean(exp(xsim %*% nxt)))
			if(ll > ll.old - eps1)
				break
			else nxt <- cur + (delt <- delt/2)
		}
		if(look)
			print(cur + psi)
		if((abs(ll - ll.old) < eps1) || max(abs(delt/cur)) < eps2 || (
			iter >= maxiter))
			break
	}
	loglik <- ll.old
	cur <- nxt
	if(do.mc.se) {
		prob <- as.vector(exp(xsim %*% cur))
		prob <- prob/sum(prob)
		n <- length(prob)
		z <- sweep(xsim, 2, xobs, "-") * prob * n
		R <- acf(z, lag.max = lag.max, type = "covariance", plot = F)$
			acf
		part <- apply(R[-1,  ,  ], c(2, 3), sum)
		cov.zbar <- (R[1,  ,  ] + part + t(part))/n
		mc.se <- diag(solve(V, t(solve(V, cov.zbar))))^0.5
	}
	if(do.mc.se)
		list(theta = cur + psi, se = diag(solve(V))^0.5, mc.se = mc.se, 
			psi = psi, iter = iter, loglik = loglik, E = E + av, V
			 = V, cov.zbar = cov.zbar)
	else list(theta = cur + psi, se = diag(solve(V))^0.5, psi = psi, iter
			 = iter, loglik = loglik, E = E + av, V = V)
}


########################
## Autologistic model ##
########################

## This function replicates the model introduced by Michael Ward 
## and Kristian Gleditsch, ``Location, Location, Location: An MCMC 
## Approach to Modeling the Spatial Context of War and Peace,'' 
## Political Analysis 10, n. 3 (2002).


sp.autologistic <- function(form,data,W_nb,id,burnin,nsamp,gibbs.interval){
	
y.var <- strsplit(as.character(form),"~",fixed=T)[[2]]
x.var <- strsplit(as.character(form),"~",fixed=T)[[3]]
x.var <- unlist(strsplit(x.var," + ",fixed=T))


## Create DV: more voter ID challenges than mean
y <- as.data.frame(data)[,y.var] 
y <- as.matrix(as.numeric(y))
rownames(y) <- id

## Create design matrix
x <- as.data.frame(data)[,x.var]
x <- as.matrix(x)
x <- apply(x,2,FUN=as.numeric)
rownames(x) <- id
colnames(x) <- x.var


# Create binary contiguity matrix with 475 km snap distance
W  <-  nb2mat(W_nb)
W <- matrix(W>0,nrow(data),nrow(data))
W <- apply(W,MARGIN=2,as.numeric)
rownames(W) <- id
colnames(W) <- id

## Create spatially-lagged DV
W.y <- W %*% y

# Calculate initial Pseudolikelihood Estimates.
psi <-  glm(y ~ x+ W.y, family=binomial(link=logit))$coef
c.cur <- vector("numeric",length(y))

# Calculate the observed vector of s(y)
gibsout <- gibbs.generator(y=y,x=x,W=W,psi=psi, gibbs.burnin=burnin,gibbs.sample=nsamp,gibbs.interval=gibbs.interval)

## Define sufficient statistics from observed data
tobs <- vector("numeric",length=(dim(x)[2]+2))
tobs[1] <- sum(y)
for (i in 1:dim(x)[2]){tobs[(i+1)] <- sum(x[,i]*y)}
tobs[length(tobs)] <- 0.5*sum(W%*%y)

## Run Newton-Raphson
a <- newton.raphson2(xobs=tobs,xsim=gibsout$suff,psi=psi)

## Pull theta estimates 
theta88 <- as.matrix(a$theta)

## Model Comparison
psi.full <- glm(y ~ x+ W.y, family=binomial(link=logit))

compare <- cbind(
summary(psi.full)$coefficients[,1],
summary(psi.full)$coefficients[,2],
unlist(a[1]),
unlist(a[3])
)
colnames(compare) <- c("MPL.Coef","MPL.SE","MCMC.Coef","MCMC.SE")
return(list(Summary=compare,Details=a))

}