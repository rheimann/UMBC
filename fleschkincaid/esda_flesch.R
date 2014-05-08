#### ESDA Example Fletch Kincaid #### 

install.packages("spdep", dependencies=TRUE)
require(spdep)
require(maptools)

geo.fk <- readShapePoly("/Users/heimannrichard/Google Drive/GIS Data/flesch_kincaid/TwitterReadingCNTYJoin.shp", 
                        proj4string=CRS('+proj=longlat +datum=NAD83'))
# colnames(geo.fk)
# pairs.default(geo.fk)
# scatter.smooth(geo.fk$MEANflecMC, geo.fk$AGE_18_21)

hist(geo.fk$MEANflesch)
hist(geo.fk$MEANflecMC)

install.packages("RColorBrewer")
require(RColorBrewer)

## Create blue-red-state palette
br.palette <- colorRampPalette(c("blue", "red"), space = "rgb")
br.palette(5)

# spplot, easy but not very flexible option. 
spplot(geo.fk, "MEANflesch", at=quantile(geo.fk$MEANflesch, edge.col = "white",
  sp=c(0,.25, .5, .75, 1), na.rm=TRUE), col.regions=br.palette(100), main="Cloropleth", sub="flesch-kincaid")
dev.off()

plot(geo.fk,col=cols,border=NA)
legend(x="bottom",cex=.7,fill=attr(cols,"palette"), bty="n",legend=names(attr(cols, "table")),
       title="Flesch Kincaid Reading Index (Twitter, 2013)",ncol=5)

## Plot binary mean center (Red/Blue)
data.fk <- geo.fk
cols <- ifelse(data.fk$MEANflecMC > 0,"red","blue")

par(mar=rep(0,4))
plot(geo.fk,col=cols,border=NA)
legend(x="bottom",cex=.7,fill=c("red","blue"),bty="n",legend=c("Losers","Winners"), 
       title="Winners and Losers - The Flesch Kincaid Reading Index (Twitter, 2013)",ncol=2)

dev.off()

## Create matrix of polygon centroids
map_crd <- coordinates(geo.fk)

## Contiguity Neighbors
# B is the basic binary coding, 
# W is row standardised (sums over all links to n),
# C is globally standardised (sums over all links to n), 
# U is equal to C divided by the number of neighbours (sums over all links to unity), 
# S is the variance-stabilizing coding scheme proposed by Tiefelsdorf et al. 1999, p. 167-168 (sums over all links to n).

nb.fk <- poly2nb(geo.fk, queen=T)
nb_30nn <- knn2nb(knearneigh(cbind(geo.fk$MEANlong, geo.fk$MEANlat), k=30, zero.policy=TRUE))
# W_cont_el <- poly2nb(geo.fk, queen=T)
geo.fk_queen <- nb2listw(W_cont_el, style="W", zero.policy=TRUE)
fk.30nn <- nb2listw(neighbours=nb_30nn, style="W", zero.policy=TRUE)

## Plot the connections

par(mar=rep(0,4))
plot(nb_30nn, coords=map_crd, pch=19, cex=0.1, col="red")

summary(nb.fk)
summary(nb_30nn)

# Moran's I statistic
moran.mc(x=geo.fk$MEANflesch, listw=fk.30nn, nsim=999, zero.policy=TRUE)

# correlogram
plot(sp.correlogram(neighbours=nb.fk, var=geo.fk$MEANflesch, order=4, method="I", style="W", zero.policy=TRUE))

# local Moran's I analysis - LISA
local.mi <- localmoran(x=geo.fk$MEANflesch, listw=fk.30nn, alternative="two.sided", p.adjust.method="fdr", zero.policy=TRUE)

class(local.mi)
colnames(local.mi)
summary(local.mi)

# Moran's I statistic (Ii) or column 5 [,1]
geo.fk$lmi <- local.mi[,1]
# Moran's I p-value (Pr) or column 5 [,5]
geo.fk$lmi.p <- local.mi[,5]
# Moran's I z-value (Z.Ii) or column 4 [,4]
geo.fk$lmi.z <- local.mi[,4]
hist(geo.fk$lmi.z)

geo.fk$lmi.p.sig <- as.factor(ifelse(local.mi[,5]<.001, "Sig p<.001", ifelse(local.mi[,5]<.05,"Sig p<.05", "NS" )))

geo.fk$lmi.svalue <- as.factor(ifelse(local.mi[,4]< -2, "Z SCORE < 2", ifelse(local.mi[,4]< 2,"Z SCORE > 2", "Z SCORE 2 < X >2" )))
geo.fk$lmi.svalue

spplot(geo.fk, "lmi", at=summary(geo.fk$lmi), col.regions=brewer.pal(5, "RdBu"), main="Local Moran's I")

spplot(geo.fk, "lmi.svalue", col.regions=c("white", "#E6550D","#FDAE6B"))

GES 673 ESDA with Flesch Kincaid Index using Twitter
========================================================
  
  Big social data is driven by a social aspect, and ultimately analyzes data that could serve directly, as or as a proxy, for other more substantive variables. The Flesch-Kincaid index, which you may all be familiar with as a consequence of using Microsoft Word, has for some time provided the readability index to documents. Flesch-Kincaid index in a manner measures linguistic standard. A sizable amount of research suggests that how we read/write/speak relates to our ability to learn. Understanding variation of space and neighborhood structure of linguistic standard is there a useful direction of research. 


```{r}
#### ESDA Example Flesch Kincaid Index using Twitter #### 
# install.packages("spdep", dependencies=TRUE)
require(spdep)
# install.packages("maptools", repos="http://cran.us.r-project.org")
require(maptools)
# install.packages("RColorBrewer")
require(RColorBrewer)
```

Load data:
  
  ```{r}
# load county shapefile 
geocnty.fk <- readShapePoly("/Users/heimannrichard/Google Drive/GIS Data/flesch_kincaid/TwitterReadingCNTYJoin.shp", 
                            proj4string=CRS('+proj=longlat +datum=NAD83'))
```

```{r}
# load 3 digit zip shapefile 
geozip.fk <- readShapePoly("/Users/heimannrichard/Google Drive/GIS Data/TwitterReading3ZIPJoin.shp", 
                           proj4string=CRS('+proj=longlat +datum=NAD83'))
```

```{r}
# histogram MEANflesch (mean center FleschKincaid) on geocnty
hist(geocnty.fk$MEANflesch)
hist(geocnty.fk$MEANflecMC)
# histogram MEANflesch (mean center FleschKincaid) on geozip
hist(geozip.fk$MEANflesch)
hist(geozip.fk$MEANflecMC)
```

```{r, fig.height=12, fig.width=14}
# map of FK at the county level
spplot(geocnty.fk, "MEANflesch", at=quantile(geocnty.fk$MEANflesch, 
                                             p=c(0,.25, .5, .75, 1), na.rm=TRUE), 
       col.regions=brewer.pal(5, "Reds"), 
       main="County Level Flesch Kincaid", sub="Flesch Kincaid Index using Twitter")
```

```{r, fig.height=12, fig.width=14}
# map of FK at the 3-digit zip level
spplot(geozip.fk, "MEANflesch", at=quantile(geozip.fk$MEANflesch, 
                                            p=c(0,.25, .5, .75, 1), na.rm=TRUE), 
       col.regions=brewer.pal(5, "Reds"), 
       main="3 digit Zipcode Level Flesch Kincaid", sub="Flesch Kincaid Index using Twitter")

# Create blue-state red-state palette
br.palette <- colorRampPalette(c("blue", "pink"), space = "rgb")
pal <- br.palette(n=5)
var <- geozip.fk$MEANflesch
classes_fx <- classIntervals(var, n=5, style="fixed", fixedBreaks=c(0, 10, 25, 50, 75, 100), rtimes = 1)
cols <- findColours(classes_fx, pal)

par(mar=rep(0,4))
plot(geozip.fk,col=pal,border=NA)
legend(x="bottom", cex=.7, fill=attr(cols,"palette"), bty="n",legend=names(attr(cols, "table")),
       title="FK Index using Twitter", ncol=5)
```

```{r}
nb.cntyfk <- poly2nb(geocnty.fk, queen=T)
summary(nb.cntyfk)

nb.zipfk <- poly2nb(geozip.fk, queen=T)
summary(nb.zipfk)
```

```{r}
sw.cntyfk <- nb2listw(neighbours=nb.cntyfk, style="B", zero.policy=TRUE)
plot(geocnty.fk)
plot(sw.cntyfk, coordinates(geocnty.fk), add=T, col="red")

sw.zipfk <- nb2listw(neighbours=nb.zipfk, style="B", zero.policy=TRUE)
plot(geozip.fk)
plot(sw.zipfk, coordinates(geo.fk), add=T, col="red")
```

```{r, fig.height=12, fig.width=14}
moran.mc(x=geocnty.fk$MEANflesch, listw=sw.cntyfk, nsim=499, zero.policy=TRUE)

moran.mc(x=geozip.fk$MEANflesch, listw=sw.zipfk, nsim=499, zero.policy=TRUE)
```

```{r, fig.height=12, fig.width=14}
plot(sp.correlogram(neighbours=nb.cntyfk, var=geocnty.fk$MEANflesch, 
                    order=6, method="I", style="B", zero.policy=TRUE))

plot(sp.correlogram(neighbours=nb.zipfk, var=geozip.fk$MEANflesch, 
                    order=6, method="I", style="B", zero.policy=TRUE))
```

```{r}
local_cnty.mi <- localmoran(x=geocnty.fk$MEANflesch, listw=sw.cntyfk, alternative="two.sided", p.adjust.method="fdr", 
                            zero.policy=TRUE)

local_zip.mi <- localmoran(x=geozip.fk$MEANflesch, listw=sw.zipfk, alternative="two.sided", p.adjust.method="fdr", 
                           zero.policy=TRUE)
```

```{r}
class(local_cnty.mi)
colnames(local_cnty.mi)
class(local_zip.mi)
colnames(local_zip.mi)

summary(local_cnty.mi)
summary(local_zip.mi)
```

```{r}
geocnty.fk$lmi <- local_cnty.mi[,1]
geocnty.fk$lmi.p <- local_cnty.mi[,5]
##
geozip.fk$lmi <- local_zip.mi[,1]
geozip.fk$lmi.p <- local_zip.mi[,5]

geocnty.fk$lmi.p.sig <- as.factor(ifelse(local_cnty.mi[,5]<.001, "Sig p<.001", ifelse(local_cnty.mi[,5]<.05,"Sig p<.05", "NS" )))
##
geozip.fk$lmi.p.sig <- as.factor(ifelse(local_zip.mi[,5]<.001, "Sig p<.001", ifelse(local_zip.mi[,5]<.05,"Sig p<.05", "NS" )))
```

```{r, fig.height=12, fig.width=14}
spplot(geocnty.fk, "lmi", at=summary(geocnty.fk$lmi), col.regions=brewer.pal(5, "RdBu"), main="Local Moran's I")
##
spplot(geozip.fk, "lmi", at=summary(geozip.fk$lmi), col.regions=brewer.pal(5, "RdBu"), main="Local Moran's I")
```

```{r, fig.height=12, fig.width=14}
spplot(geocnty.fk, "lmi.p.sig", col.regions=c("white", "#E6550D","#FDAE6B"))
##
spplot(geozip.fk, "lmi.p.sig", col.regions=c("white", "#E6550D","#FDAE6B"))
```


