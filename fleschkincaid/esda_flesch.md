# GES 673 ESDA with Flesch Kincaid Index using Twitter #
## Using Twitter to Analyze Linguistic Standards in the US ##
### by Richard Heimann ###
========================================================

Big social data is big data driven by a social aspect, and ultimately analyzes data that could serve directly, as or as a proxy, for other more substantive variables. The Flesch-Kincaid index (http://en.wikipedia.org/wiki/Flesch–Kincaid_readability_test), which you may all be familiar with as a consequence of using Microsoft Word, has for some time provided the readability index to documents. Flesch-Kincaid index in a manner measures linguistic standard. A sizable amount of research suggests that how we read/write/speak relates to our ability to learn. Understanding regional variation of linguistic standard over space and neighborhood structure and interaction of effects of linguistic standard is therefore a useful direction of research. 

As discussed throughout the class our first step, had this been your own analysis is to write our your research question in both theoretical and operational terms. This is important. 

The Readability Ease Index is the average sentence length weighted then subtracted from the average number of syllables per word. The output generally ranges from 0 - 100. To provide examples, the Reader's Digest magazine has a readability index of about 65, Time magazine scores about 52, an average 6th grade student (age 11) has written assignments at a readability score of 60–70, and the Harvard Law Review has a general readability score in the low 30s.
 
The highest (easiest) readability score possible is around 120 (meaning every sentence consists of only two one-syllable words). The score does not have a theoretical lower bound. It is possible to make the score as low as you want by arbitrarily including words with many syllables. This could easily happen on Twitter: A tweet where LOL (laughing out loud) is repeated to the max character limit of 140 would possess subsequent indices well below 0. Therefore laughing out loud to an arbirarily low score is possible and should be considered an error in the measurement apparatus. 

The following sentence, for example, taken as a reading passage unto itself, has a readability score of about 33. The sentence, "The Australian platypus is seemingly a hybrid of a mammal and reptilian creature" is a 24.4, as it has 26 syllables and 13 words. One particularly long sentence about sharks in chapter 64 of Moby-Dick has a readability score of -146.77. The Guardian used the Flesch-Kincaid index to track the reading level of every State of the Union address and noted how the linguist standard of the presidential address has steadily declined. http://www.theguardian.com/world/interactive/2013/feb/12/state-of-the-union-reading-level

The index is inversely related to its linguistic sophistication. A high score is easier to read or, put differently, poorly written. An example of a low score or a tweet written with high sophistication [Table 1] is as follows: "This gas situation is absolutely ridiculous.” It was written at an 11th grade level and has a mean centered value well below zero. It is parsimonious and more dense with syllables on average that other tweets. The location of the Tweet is Mahwah NJ, located about 20 miles outside of New York City (NYC).

<a href="https://www.flickr.com/photos/ronbumquist/13855743053" title="tbl1 by Richard Heimann, on Flickr"><img src="https://farm8.staticflickr.com/7157/13855743053_2cde0b741d.jpg" width="500" height="359" alt="tbl1"></a>

The tweet [Table 2] “down here in beach bout to shut this down wit & feeling the vibe s” is written at a 4th grade level and has a mean centered value well above zero. This is an example of a high score, or a Tweet written with low sophistication. It has but one non-monosyllable word. The location of the tweet is Myrtle Beach, SC.

<a href="https://www.flickr.com/photos/ronbumquist/13855742733" title="tbl2 by Richard Heimann, on Flickr"><img src="https://farm8.staticflickr.com/7224/13855742733_f60385831c.jpg" width="500" height="358" alt="tbl2"></a>

The data was collected using the R package, twitteR (random pushes from the Twitter public timeline). The temporal range of collection began on 2012-10-23 and concluded 2012-11-06 (1 temporal bin, 2 weeks). The spatial extent of the data was the US where all data collected from the step below was clipped to the US. The original sample was 110,737 observations, 418,085 words, and 1,446,494 characters without stop words (519,974 & 2,326,500 with stop words). During data processing all hashtags were removed, as well as URLs. The data was clipped (to eliminate irregular values due to idiocyrisies of Twitter and the FK Index) at the tails of the distribution (0-100) and mean centered to aid in interpretation. The final dataset was a pruned sample 47,690 observations which was aggregated into US 3-digit zip codes and US counties. 

Methods used include Local Indicator of Spatial Autocorrelation (Moran’s I) with LISA Classifications of High-High (HH), Low-Low (LL), High Low (HL), Low-High (LH) and spatial weights of k-nearest neighbor (k=40). By mean centering the data (that is, subtracting the global mean from each region), we can quickly identify deviation from the global mean. The Mid-Atlantic, Mountain, New England, and Pacific are all below the global mean (remember, writing with a higher standard), whereas East North Central, East South Central, Southeast, West North Central, and West South Central are all above (lower standard). You can also quickly see that the Pacific and the West South Central regions deviate most in their respective direction from the global mean.

<a href="https://www.flickr.com/photos/ronbumquist/13856080704" title="tbl3 by Richard Heimann, on Flickr"><img src="https://farm3.staticflickr.com/2922/13856080704_b59dd6b113.jpg" width="500" height="449" alt="tbl3"></a>

Another way of exploring [Graph 1] the data is box plots by region, with underlying scatter plots. We see much of the same information captured by the summary statistics, but the addition of the jitter allows us to get a sense of the distribution.

<a href="https://www.flickr.com/photos/ronbumquist/13856080984" title="graph1 by Richard Heimann, on Flickr"><img src="https://farm3.staticflickr.com/2838/13856080984_aecd337e82.jpg" width="500" height="255" alt="graph1"></a>

The map [1] merely shows the post-processed data after thresholding. Notice that even with just about 48,000 observations, the pattern recognition is difficult due in part to coincident points in space and perhaps supporting evidence for quantitative methods of pattern recognition and discovery.

<a href="https://www.flickr.com/photos/ronbumquist/13855707305" title="map1 by Richard Heimann, on Flickr"><img src="https://farm4.staticflickr.com/3726/13855707305_9f41b0a462.jpg" width="500" height="253" alt="map1"></a>

Using the Moran’s I Statistic for spatial autocorrelation, and Local Indicators of Spatial Autocorrelation (LISA) for classification, we can examine both spatial dependency and spatial heterogeneity. Notice the large spatial clusters representative of spatial dependency in the north and south, with smaller regimes in the northeast and west. These are high values surrounded by high values in the southwest and in the heartland. Also noticeable are the low indices surrounded by other low indices in the north, centered around Montana and on the coasts, namely the NYC Metropolitan area and San Jose/SF area. In our EDA/ESDA lectures recall we examined maps often in a two map comparison. Here we are comparing regions. The Global Moran's I could have been used in this fashion - perhaps comparing regions to other regions. But, the LISA does this in a much more localized fashion and does so with greater efficiency. 

<a href="https://www.flickr.com/photos/ronbumquist/13856080444" title="map2 by Richard Heimann, on Flickr"><img src="https://farm8.staticflickr.com/7099/13856080444_c205e2c97b.jpg" width="500" height="260" alt="map2"></a>

<a href="https://www.flickr.com/photos/ronbumquist/13856080834" title="graph2 by Richard Heimann, on Flickr"><img src="https://farm4.staticflickr.com/3709/13856080834_580419aaa6.jpg" width="500" height="121" alt="graph2"></a>


There are more localized relationships not clear from this map. Recall from lecture our discussions on smooth and rough pattern detection. Where we concluded that data was the sum of rough and smooth - or, data = rough + smooth. In addition to the smooth quality of the analysis as noted by high values surrounded by high values, and low values surrounded by low values, there are also some interesting rough qualities characteristic of spatial outliers or high values surrounded by low values and low values surrounded by high values. For example, Columbus OH, Ithaca NY, and Gassaway WV are all low values surrounded by high values -- meaning these cities write at a more sophisticated level than their neighbors and meet statistical significance.

By performing a spatial inner join (very common GIS task of finding points in polygons) with major cities -- in this case, cities with more than 300,000 people -- and the LISA classifications, we can identify large cities and their sophistication in crafting Tweets. The following are the only cities that meet that criteria. This is a practical example of the merging of traditional GIS, which has a great deal of efficacy with newer techniques to produce more poignant insight. 

El Paso, Oklahoma City, Omaha, Detroit, and Memphis all have statistically significant high values surrounded by high values (HH). NYC and San Jose are low values surrounded by low values (LL). Sacramento is a low value surrounded by otherwise high values (LH) and Wichita, Kansas City, Tulsa, and Nashville are all high flesch-kincaid indices surrounded by low flesch-kincaid indices (HL). These indices are inversely related with writing ability and linguistic standards; high values are low writing ability and vice versa. One might conclude, among other things, that NYC and San Jose write with high linguistic standards.

The LISA categories are statistically significant with a pseudo p-value < 0.05. Pseudo p-values are a computational approach to inference and prove to be a nice data reduction technique. Our original dataset of 3-digit zip codes is reduced from 862 observations to just 259, where all other observations are not statistically significant in the patterning of the kincaid index, or just 30 percent of the original dataset.

For more on this topic see my Github and Slideshare pages.
[Github:](https://github.com/rheimann/UMBC)
[Slideshare:](http://www.slideshare.net/rheimann04/big-social-data-the-spatial-turn-in-big-data)

### 1. Upon reading this material what would your research question be? Don't forget to write out the question in both theoretical and operational terms. Also, not which phase of the methodology this falls within. This is a three part question worth three points, one point for each answer. 

### [1]
### [2]
### [3]

### 2. Following the writting out of our research question in theorectical and operational terms we now consider the design (Step #2) and we chose our variables and consider thier level of measurement. The design has many important considerations including the items below. The question is, how was our data collected? Was the data collection primary or secondary collection AND what type of sample was it (random, stratified, accidental, or clustered)? This is a two part question worth two points, one point for each answer. 

[Random:](http://en.wikipedia.org/wiki/Simple_random_sampling)
[Stratified:](http://en.wikipedia.org/wiki/Stratified_sampling)
[Clustered:](http://en.wikipedia.org/wiki/Cluster_sampling)
[Accidental:](http://en.wikipedia.org/wiki/Sampling_(statistics)#Accidental_sampling)


### Define the Design:
* Will this be a primary data analysis - that is, will you collect your own data?
a. If so, will you sample? If so, how? i.e. random, stratified, or clustered.
b. What are the confounding variables, if any?
c. Was the data collected in a repeated measures or single measurement way?
d. Will the data be aggregated and if so, how? To what areal unit? Does this match the research question?
e. Will you include a quasi-experimental design?

* Will this be a secondary data analysis - that is, will the data be collected by another effort?
a. If so, what was the sample? Who collected the data? What was the source? Why was it collected?
b. Is the data a repeated measures or single measurement?
c. What is the level of aggregation, if any?
d. Will you include a quasi-experimental design?

### [4]
### [5]

## 3. We learned that the FK Index can be spoofed with tricky data/tweets. For example, a tweet where LOL (laughing out loud) is repeated to the max character limit of 140 would produce subsequent measurements well below 0. Therefore laughing out loud to an arbirarily low score is possible and should be considered an error in the measurement apparatus. In Step 4 we discuss how to clean data and create new variables. In the example above how was the error mediated in this case? What other type of errors exist (this is due to measurement? Is there another way to mediate this type of error? This is a three part question worth three points, one point for each answer. 

### [6]
### [7]
### [8]

### 4. As we have discussed in previous lectures, variables are high level abstractions and are composed of attributes - all of which need to be measured. To establish relationships between variables and among attributes researchers/practitioners must observe the variables and record observations and various attributes. The process of measuring a variable and its attributes requires a set of categories called a scale of measurement.  In this example: 

* What is the variable of interest, we might call it our dependent variable? [9]
* What is its attributes [10]
* What is its level of measurement? [11] 

### This is a three part question worth 1.5 points, .5 points for each answer. 

### 5. Given the result of this analysis what would you suggest as the next step? This is a one part question worth .5 points - this could be as little as one sentence but could require more detail. 

### [12]

### 10 total points for this lab.


```
## 
## The downloaded binary packages are in
## 	/var/folders/z8/jh4nq2n9337g6jdk6h3xk61r0000gn/T//RtmpSZNksd/downloaded_packages
```

```
## Loading required package: spdep
## Loading required package: sp
## Loading required package: Matrix
```

```
## 
## The downloaded binary packages are in
## 	/var/folders/z8/jh4nq2n9337g6jdk6h3xk61r0000gn/T//RtmpSZNksd/downloaded_packages
```

```
## Loading required package: maptools
## Checking rgeos availability: TRUE
```

```
## 
## The downloaded binary packages are in
## 	/var/folders/z8/jh4nq2n9337g6jdk6h3xk61r0000gn/T//RtmpSZNksd/downloaded_packages
```

```
## Loading required package: RColorBrewer
```

```
## 
## The downloaded binary packages are in
## 	/var/folders/z8/jh4nq2n9337g6jdk6h3xk61r0000gn/T//RtmpSZNksd/downloaded_packages
```

```
## Loading required package: classInt
```

```
## 
## The downloaded binary packages are in
## 	/var/folders/z8/jh4nq2n9337g6jdk6h3xk61r0000gn/T//RtmpSZNksd/downloaded_packages
```

```
## 
## The downloaded binary packages are in
## 	/var/folders/z8/jh4nq2n9337g6jdk6h3xk61r0000gn/T//RtmpSZNksd/downloaded_packages
```


Load data:


```r
# load county shapefile
geocnty.fk <- readShapePoly("/Users/heimannrichard/Google Drive/GIS Data/flesch_kincaid/TwitterReadingCNTYJoin.shp", 
    proj4string = CRS("+proj=longlat +datum=NAD83"))
```



```r
# load 3 digit zip shapefile
geozip.fk <- readShapePoly("/Users/heimannrichard/Google Drive/GIS Data/TwitterReading3ZIPJoin.shp", 
    proj4string = CRS("+proj=longlat +datum=NAD83"))
```



```r
# histogram MEANflesch (mean center FleschKincaid) on geocnty
hist(geocnty.fk$MEANflesch)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-41.png) 

```r
hist(geocnty.fk$MEANflecMC)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-42.png) 

```r
# histogram MEANflesch (mean center FleschKincaid) on geozip
hist(geozip.fk$MEANflesch)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-43.png) 

```r
hist(geozip.fk$MEANflecMC)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-44.png) 

```r
# notice mean centering doesn't change the distribution as thresholding# ,
# clipping or windsoring might.
```



```r
# map of FK at the county level
spplot(geocnty.fk@data$MEANflesch, at = quantile(geocnty.fk@data$MEANflesch, 
    p = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE), col.regions = brewer.pal(5, 
    "Reds"), main = "County Level Flesch Kincaid", sub = "Flesch Kincaid Index using Twitter")
```

```
## Error: unable to find an inherited method for function 'spplot' for
## signature '"numeric"'
```



```r
# map of FK at the 3-digit zip level
spplot(geozip.fk@data$MEANflesch, at = quantile(geozip.fk@data$MEANflesch, p = c(0, 
    0.25, 0.5, 0.75, 1), na.rm = TRUE), col.regions = brewer.pal(5, "Reds"), 
    main = "3 digit Zipcode Level Flesch Kincaid", sub = "Flesch Kincaid Index using Twitter")
```

```
## Error: unable to find an inherited method for function 'spplot' for
## signature '"numeric"'
```

```r

# pattern detection is difficult with data of this areal unit size and #
# spatial extent.
```



```r
# another way to map FK at the 3-digit zip level
br.palette <- colorRampPalette(c("blue", "pink"), space = "rgb")
pal <- br.palette(n = 5)
var <- geozip.fk$MEANflesch
classes_fx <- classIntervals(var, n = 5, style = "fixed", fixedBreaks = c(0, 
    10, 25, 50, 75, 100), rtimes = 1)
cols <- findColours(classes_fx, pal)

par(mar = rep(0, 4))
plot(geozip.fk, col = pal, border = NA)
legend(x = "bottom", cex = 0.7, fill = attr(cols, "palette"), bty = "n", legend = names(attr(cols, 
    "table")), title = "3 digit Zipcode Level Flesch Kincaid", ncol = 5)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 


## Pattern detection is difficult still but abit easier with zip codes due to the average size of the areal unit increasing. This increase in scale makes visual interpretation easier but may also have impact on our analysis, as discussed in lecture. The averaging or smoothing of the data tends to increase the effect or the size of the relationship akin to MAUP. Our statistics may not be invariant to this "scaling up" but we can keep that in mind for now and evaulate the difference later. 



```r
# nb.cntyfk <- poly2nb(geocnty.fk, queen=T)
nb.cntyfk <- read.gwt2nb("/Users/heimannrichard/Google Drive/GIS Data/flesch_kincaid/TwitterReadingCNTYJoinknn40.gwt", 
    region.id = geocnty.fk@data$OID)
```

```
## Warning: region.id not named OID
```

```r
summary(nb.cntyfk)
```

```
## Neighbour list object:
## Number of regions: 2244 
## Number of nonzero links: 89760 
## Percentage nonzero weights: 1.783 
## Average number of links: 40 
## Non-symmetric neighbours list
## Link number distribution:
## 
##   40 
## 2244 
## 2244 least connected regions:
## 0 1 2 3 4 6 7 8 9 10 11 13 14 15 16 17 19 20 21 22 23 24 25 26 27 28 29 30 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 116 117 118 120 121 122 123 124 125 126 129 130 131 132 134 135 136 137 138 139 140 141 143 144 145 146 148 149 150 151 154 155 156 157 158 160 162 164 165 166 168 169 170 171 172 173 174 176 178 180 181 183 184 186 187 189 190 192 193 194 195 196 198 199 200 201 202 203 204 205 206 207 209 210 211 212 213 214 216 217 218 219 220 221 222 223 224 225 226 227 228 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 248 249 250 252 260 261 263 264 265 268 272 276 277 278 280 281 286 287 289 291 293 296 301 304 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 338 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 384 385 386 387 389 391 392 394 395 396 398 399 400 401 402 403 404 406 407 408 409 410 412 413 414 415 416 417 418 419 420 422 424 425 426 427 428 429 431 432 433 435 436 437 438 440 441 442 443 444 445 447 448 449 450 451 452 453 455 456 457 459 460 461 462 464 466 468 469 470 471 472 473 474 476 477 478 479 480 481 482 485 486 487 488 489 490 491 492 494 495 498 499 500 501 503 504 505 506 508 510 511 512 513 514 516 517 518 519 520 521 522 523 524 525 526 527 529 530 531 532 533 534 535 537 538 539 540 541 543 549 551 554 555 557 560 561 562 567 568 569 574 576 577 578 580 581 582 583 586 593 595 596 598 602 603 606 607 608 609 611 612 613 614 616 617 619 620 622 624 629 630 631 634 635 637 638 639 640 641 642 644 645 646 647 648 649 650 651 652 653 655 656 657 658 659 660 661 663 664 665 666 671 673 674 675 676 681 682 683 684 685 686 687 688 690 691 692 693 695 696 697 699 700 701 703 704 705 706 707 708 709 710 711 712 713 714 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 751 753 754 757 758 759 761 762 763 764 765 766 767 768 769 770 771 772 773 774 776 777 778 779 781 783 784 785 786 792 793 794 795 798 800 801 803 804 807 809 811 812 815 817 819 820 825 828 830 834 836 838 839 843 844 847 848 849 850 852 854 856 861 863 864 865 868 870 871 872 874 876 877 880 882 883 884 885 886 887 889 890 891 892 893 896 899 900 901 903 904 906 907 908 911 913 914 915 916 918 922 924 925 931 932 935 937 941 942 943 946 948 952 958 960 963 965 966 968 970 972 973 974 976 978 981 983 984 986 990 991 992 994 995 996 997 998 999 1000 1001 1002 1003 1005 1007 1008 1009 1010 1012 1014 1015 1017 1018 1020 1021 1022 1024 1025 1026 1027 1028 1030 1031 1032 1033 1034 1035 1036 1037 1038 1039 1042 1044 1046 1047 1048 1049 1050 1051 1053 1054 1056 1059 1061 1062 1063 1064 1065 1066 1068 1069 1072 1074 1076 1077 1078 1080 1083 1084 1086 1087 1088 1090 1092 1093 1094 1095 1096 1097 1098 1099 1103 1104 1105 1106 1107 1108 1110 1111 1112 1113 1114 1115 1116 1118 1119 1120 1122 1123 1126 1127 1129 1130 1131 1132 1133 1134 1135 1136 1137 1138 1139 1140 1141 1142 1143 1144 1145 1146 1147 1148 1150 1151 1152 1153 1154 1155 1156 1157 1158 1159 1160 1161 1162 1163 1165 1166 1167 1168 1169 1170 1171 1172 1173 1175 1177 1178 1179 1180 1181 1183 1184 1185 1186 1187 1188 1190 1191 1192 1193 1194 1195 1196 1197 1198 1199 1200 1201 1202 1203 1204 1205 1206 1207 1208 1209 1210 1211 1212 1213 1214 1215 1216 1217 1218 1219 1220 1221 1222 1223 1225 1226 1227 1228 1231 1232 1234 1236 1237 1238 1239 1240 1241 1242 1243 1245 1246 1247 1249 1251 1252 1253 1254 1255 1256 1257 1258 1259 1260 1261 1262 1265 1266 1267 1269 1272 1273 1274 1275 1277 1278 1279 1280 1281 1282 1284 1286 1287 1289 1290 1291 1292 1295 1296 1298 1301 1302 1303 1304 1306 1307 1308 1309 1310 1312 1313 1314 1315 1316 1317 1318 1319 1320 1321 1322 1323 1324 1325 1329 1330 1331 1332 1334 1335 1336 1337 1338 1339 1341 1342 1343 1345 1347 1348 1351 1353 1354 1356 1357 1360 1361 1363 1364 1365 1366 1367 1370 1371 1372 1373 1375 1376 1377 1378 1379 1380 1381 1382 1383 1384 1385 1386 1388 1389 1390 1393 1395 1396 1397 1399 1400 1404 1405 1406 1407 1408 1409 1411 1412 1413 1414 1415 1416 1419 1420 1421 1422 1423 1424 1425 1426 1427 1428 1430 1432 1433 1434 1435 1436 1437 1439 1440 1441 1442 1443 1444 1445 1446 1448 1449 1450 1451 1452 1453 1455 1456 1457 1458 1459 1460 1461 1462 1464 1465 1466 1467 1468 1469 1470 1471 1472 1473 1474 1475 1476 1478 1479 1480 1481 1482 1484 1485 1486 1487 1490 1491 1492 1494 1495 1496 1499 1502 1503 1504 1506 1507 1515 1516 1519 1525 1526 1528 1529 1530 1531 1533 1535 1536 1537 1538 1539 1543 1544 1546 1549 1550 1551 1552 1553 1554 1556 1558 1560 1561 1562 1563 1564 1565 1568 1569 1571 1572 1573 1574 1575 1576 1577 1580 1583 1586 1588 1589 1590 1592 1594 1595 1600 1601 1602 1606 1609 1610 1611 1618 1620 1627 1631 1642 1649 1651 1652 1653 1661 1662 1663 1664 1665 1667 1668 1672 1673 1674 1675 1678 1679 1691 1696 1698 1706 1707 1708 1711 1715 1722 1725 1727 1728 1729 1730 1731 1733 1735 1738 1739 1740 1741 1742 1744 1745 1746 1747 1748 1750 1751 1752 1754 1756 1759 1760 1761 1762 1764 1765 1766 1767 1768 1769 1770 1771 1772 1773 1774 1775 1776 1777 1778 1779 1780 1781 1782 1783 1784 1785 1786 1787 1788 1789 1790 1791 1792 1793 1795 1796 1798 1800 1801 1802 1806 1807 1809 1810 1812 1813 1815 1816 1817 1818 1819 1820 1822 1825 1826 1827 1828 1829 1830 1831 1832 1833 1834 1835 1836 1837 1838 1839 1840 1842 1843 1844 1845 1847 1848 1849 1851 1852 1853 1854 1855 1856 1857 1858 1859 1860 1861 1862 1863 1864 1865 1866 1867 1868 1869 1870 1871 1872 1873 1875 1876 1877 1878 1879 1880 1881 1882 1883 1884 1885 1886 1888 1889 1891 1894 1896 1897 1898 1899 1900 1901 1902 1903 1904 1905 1906 1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 1919 1920 1921 1922 1923 1924 1926 1927 1928 1929 1930 1931 1932 1933 1934 1936 1937 1938 1939 1940 1941 1942 1943 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1973 1975 1977 1978 1979 1982 1983 1984 1985 1986 1987 1989 1992 1995 1996 2001 2005 2009 2011 2014 2017 2018 2023 2026 2027 2029 2030 2032 2036 2037 2038 2040 2041 2042 2043 2044 2045 2046 2047 2048 2049 2050 2051 2052 2053 2054 2055 2056 2057 2058 2059 2060 2061 2062 2063 2064 2065 2066 2067 2068 2069 2070 2071 2072 2073 2074 2075 2076 2077 2079 2080 2081 2082 2083 2084 2085 2086 2087 2088 2089 2090 2091 2092 2093 2094 2095 2097 2099 2100 2102 2103 2105 2106 2107 2108 2109 2110 2111 2112 2113 2114 2115 2116 2117 2118 2119 2120 2121 2123 2124 2125 2126 2127 2128 2129 2130 2131 2132 2133 2135 2136 2137 2138 2139 2140 2142 2144 2145 2146 2147 2148 2149 2152 2153 2154 2155 2160 2161 2164 2166 2167 2168 2169 2170 2172 2173 2174 2175 2177 2178 2179 2182 2183 2184 2186 2187 2188 2189 2190 2191 2194 2195 2197 2198 2200 2201 2202 2203 2204 2205 2207 2208 2209 2211 2212 2214 2215 2217 2219 2220 2222 2223 2224 2225 2226 2227 2228 2229 2231 2232 2235 2236 2239 2241 2242 2243 2244 2245 2246 2247 2248 2249 2250 2251 2252 2254 2255 2256 2257 2258 2259 2260 2261 2262 2263 2264 2265 2266 2267 2269 2271 2272 2273 2274 2276 2277 2278 2279 2280 2281 2282 2283 2284 2285 2286 2287 2289 2290 2291 2292 2293 2294 2295 2296 2297 2299 2300 2302 2303 2304 2305 2306 2307 2308 2309 2310 2311 2312 2313 2314 2315 2316 2317 2318 2319 2320 2321 2322 2323 2324 2325 2326 2327 2328 2329 2330 2331 2332 2333 2334 2335 2336 2337 2338 2339 2340 2341 2342 2343 2344 2345 2346 2347 2348 2349 2350 2351 2352 2353 2354 2355 2356 2357 2358 2359 2361 2364 2365 2366 2368 2372 2375 2376 2380 2382 2391 2392 2394 2396 2399 2400 2401 2404 2405 2406 2408 2409 2410 2413 2415 2417 2419 2420 2422 2426 2427 2430 2431 2433 2434 2435 2437 2438 2440 2441 2442 2443 2444 2445 2447 2448 2449 2450 2451 2452 2453 2454 2455 2456 2457 2458 2460 2461 2462 2463 2464 2465 2466 2468 2470 2471 2472 2473 2474 2475 2477 2478 2479 2481 2482 2483 2484 2485 2487 2488 2489 2490 2491 2492 2493 2496 2497 2498 2499 2500 2501 2503 2504 2505 2507 2508 2509 2510 2511 2512 2514 2515 2517 2519 2520 2521 2523 2524 2527 2528 2529 2530 2531 2532 2533 2534 2535 2538 2539 2540 2541 2542 2544 2545 2546 2547 2548 2549 2551 2552 2554 2556 2557 2559 2562 2563 2565 2566 2567 2569 2570 2573 2574 2576 2577 2579 2581 2582 2583 2584 2586 2587 2588 2590 2591 2592 2594 2595 2597 2599 2601 2602 2604 2606 2609 2610 2611 2612 2613 2614 2615 2620 2621 2622 2623 2625 2627 2628 2629 2631 2632 2633 2634 2636 2637 2640 2641 2642 2643 2644 2645 2646 2648 2649 2652 2656 2657 2659 2662 2663 2664 2666 2667 2669 2670 2672 2673 2674 2675 2676 2677 2678 2679 2680 2681 2682 2683 2685 2686 2689 2690 2692 2694 2695 2696 2697 2698 2699 2701 2703 2704 2706 2707 2708 2709 2711 2712 2716 2719 2720 2721 2722 2723 2725 2726 2728 2730 2732 2734 2735 2740 2741 2745 2746 2747 2748 2750 2752 2753 2754 2755 2756 2757 2759 2760 2761 2763 2766 2767 2768 2769 2770 2773 2774 2776 2777 2778 2780 2781 2782 2783 2785 2786 2788 2790 2792 2794 2795 2796 2797 2798 2799 2801 2802 2803 2804 2805 2806 2807 2809 2811 2812 2814 2815 2816 2817 2818 2819 2820 2821 2822 2823 2824 2825 2827 2828 2829 2830 2832 2833 2834 2835 2836 2837 2838 2840 2841 2844 2845 2846 2847 2848 2849 2850 2851 2852 2853 2854 2855 2856 2858 2859 2860 2861 2863 2864 2865 2866 2867 2868 2869 2870 2871 2872 2873 2874 2875 2876 2877 2878 2879 2880 2881 2882 2883 2884 2885 2886 2887 2888 2889 2890 2891 2893 2894 2895 2896 2899 2900 2901 2902 2903 2904 2906 2907 2908 2909 2910 2911 2912 2913 2914 2915 2916 2917 2918 2919 2920 2921 2923 2924 2925 2926 2928 2929 2930 2931 2932 2933 2934 2936 2937 2938 2939 2940 2941 2942 2943 2944 2945 2947 2948 2949 2950 2951 2952 2954 2955 2956 2957 2959 2960 2961 2962 2964 2966 2968 2969 2970 2971 2972 2977 2978 2980 2982 2983 2985 2987 2988 2989 2990 2991 2992 2993 2995 2996 3000 3002 3003 3004 3005 3007 3008 3009 3010 3011 3013 3015 3016 3017 3018 3019 3020 3021 3022 3023 3024 3025 3027 3029 3030 3031 3032 3033 3039 3040 3041 3042 3044 3045 3047 3050 3053 3054 3055 3056 3058 3059 3060 3061 3062 3063 3065 3067 3070 3073 3074 3075 3077 3078 3081 3082 3083 3086 3087 3088 3090 3091 3093 3094 3095 3097 3099 3101 3102 3104 3105 3107 3109 3110 3112 3113 3114 3116 3117 3118 3120 3121 3122 3124 3128 3129 3130 3132 3133 3134 3135 3137 3140 with 40 links
## 2244 most connected regions:
## 0 1 2 3 4 6 7 8 9 10 11 13 14 15 16 17 19 20 21 22 23 24 25 26 27 28 29 30 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 116 117 118 120 121 122 123 124 125 126 129 130 131 132 134 135 136 137 138 139 140 141 143 144 145 146 148 149 150 151 154 155 156 157 158 160 162 164 165 166 168 169 170 171 172 173 174 176 178 180 181 183 184 186 187 189 190 192 193 194 195 196 198 199 200 201 202 203 204 205 206 207 209 210 211 212 213 214 216 217 218 219 220 221 222 223 224 225 226 227 228 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 248 249 250 252 260 261 263 264 265 268 272 276 277 278 280 281 286 287 289 291 293 296 301 304 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 338 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 384 385 386 387 389 391 392 394 395 396 398 399 400 401 402 403 404 406 407 408 409 410 412 413 414 415 416 417 418 419 420 422 424 425 426 427 428 429 431 432 433 435 436 437 438 440 441 442 443 444 445 447 448 449 450 451 452 453 455 456 457 459 460 461 462 464 466 468 469 470 471 472 473 474 476 477 478 479 480 481 482 485 486 487 488 489 490 491 492 494 495 498 499 500 501 503 504 505 506 508 510 511 512 513 514 516 517 518 519 520 521 522 523 524 525 526 527 529 530 531 532 533 534 535 537 538 539 540 541 543 549 551 554 555 557 560 561 562 567 568 569 574 576 577 578 580 581 582 583 586 593 595 596 598 602 603 606 607 608 609 611 612 613 614 616 617 619 620 622 624 629 630 631 634 635 637 638 639 640 641 642 644 645 646 647 648 649 650 651 652 653 655 656 657 658 659 660 661 663 664 665 666 671 673 674 675 676 681 682 683 684 685 686 687 688 690 691 692 693 695 696 697 699 700 701 703 704 705 706 707 708 709 710 711 712 713 714 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 751 753 754 757 758 759 761 762 763 764 765 766 767 768 769 770 771 772 773 774 776 777 778 779 781 783 784 785 786 792 793 794 795 798 800 801 803 804 807 809 811 812 815 817 819 820 825 828 830 834 836 838 839 843 844 847 848 849 850 852 854 856 861 863 864 865 868 870 871 872 874 876 877 880 882 883 884 885 886 887 889 890 891 892 893 896 899 900 901 903 904 906 907 908 911 913 914 915 916 918 922 924 925 931 932 935 937 941 942 943 946 948 952 958 960 963 965 966 968 970 972 973 974 976 978 981 983 984 986 990 991 992 994 995 996 997 998 999 1000 1001 1002 1003 1005 1007 1008 1009 1010 1012 1014 1015 1017 1018 1020 1021 1022 1024 1025 1026 1027 1028 1030 1031 1032 1033 1034 1035 1036 1037 1038 1039 1042 1044 1046 1047 1048 1049 1050 1051 1053 1054 1056 1059 1061 1062 1063 1064 1065 1066 1068 1069 1072 1074 1076 1077 1078 1080 1083 1084 1086 1087 1088 1090 1092 1093 1094 1095 1096 1097 1098 1099 1103 1104 1105 1106 1107 1108 1110 1111 1112 1113 1114 1115 1116 1118 1119 1120 1122 1123 1126 1127 1129 1130 1131 1132 1133 1134 1135 1136 1137 1138 1139 1140 1141 1142 1143 1144 1145 1146 1147 1148 1150 1151 1152 1153 1154 1155 1156 1157 1158 1159 1160 1161 1162 1163 1165 1166 1167 1168 1169 1170 1171 1172 1173 1175 1177 1178 1179 1180 1181 1183 1184 1185 1186 1187 1188 1190 1191 1192 1193 1194 1195 1196 1197 1198 1199 1200 1201 1202 1203 1204 1205 1206 1207 1208 1209 1210 1211 1212 1213 1214 1215 1216 1217 1218 1219 1220 1221 1222 1223 1225 1226 1227 1228 1231 1232 1234 1236 1237 1238 1239 1240 1241 1242 1243 1245 1246 1247 1249 1251 1252 1253 1254 1255 1256 1257 1258 1259 1260 1261 1262 1265 1266 1267 1269 1272 1273 1274 1275 1277 1278 1279 1280 1281 1282 1284 1286 1287 1289 1290 1291 1292 1295 1296 1298 1301 1302 1303 1304 1306 1307 1308 1309 1310 1312 1313 1314 1315 1316 1317 1318 1319 1320 1321 1322 1323 1324 1325 1329 1330 1331 1332 1334 1335 1336 1337 1338 1339 1341 1342 1343 1345 1347 1348 1351 1353 1354 1356 1357 1360 1361 1363 1364 1365 1366 1367 1370 1371 1372 1373 1375 1376 1377 1378 1379 1380 1381 1382 1383 1384 1385 1386 1388 1389 1390 1393 1395 1396 1397 1399 1400 1404 1405 1406 1407 1408 1409 1411 1412 1413 1414 1415 1416 1419 1420 1421 1422 1423 1424 1425 1426 1427 1428 1430 1432 1433 1434 1435 1436 1437 1439 1440 1441 1442 1443 1444 1445 1446 1448 1449 1450 1451 1452 1453 1455 1456 1457 1458 1459 1460 1461 1462 1464 1465 1466 1467 1468 1469 1470 1471 1472 1473 1474 1475 1476 1478 1479 1480 1481 1482 1484 1485 1486 1487 1490 1491 1492 1494 1495 1496 1499 1502 1503 1504 1506 1507 1515 1516 1519 1525 1526 1528 1529 1530 1531 1533 1535 1536 1537 1538 1539 1543 1544 1546 1549 1550 1551 1552 1553 1554 1556 1558 1560 1561 1562 1563 1564 1565 1568 1569 1571 1572 1573 1574 1575 1576 1577 1580 1583 1586 1588 1589 1590 1592 1594 1595 1600 1601 1602 1606 1609 1610 1611 1618 1620 1627 1631 1642 1649 1651 1652 1653 1661 1662 1663 1664 1665 1667 1668 1672 1673 1674 1675 1678 1679 1691 1696 1698 1706 1707 1708 1711 1715 1722 1725 1727 1728 1729 1730 1731 1733 1735 1738 1739 1740 1741 1742 1744 1745 1746 1747 1748 1750 1751 1752 1754 1756 1759 1760 1761 1762 1764 1765 1766 1767 1768 1769 1770 1771 1772 1773 1774 1775 1776 1777 1778 1779 1780 1781 1782 1783 1784 1785 1786 1787 1788 1789 1790 1791 1792 1793 1795 1796 1798 1800 1801 1802 1806 1807 1809 1810 1812 1813 1815 1816 1817 1818 1819 1820 1822 1825 1826 1827 1828 1829 1830 1831 1832 1833 1834 1835 1836 1837 1838 1839 1840 1842 1843 1844 1845 1847 1848 1849 1851 1852 1853 1854 1855 1856 1857 1858 1859 1860 1861 1862 1863 1864 1865 1866 1867 1868 1869 1870 1871 1872 1873 1875 1876 1877 1878 1879 1880 1881 1882 1883 1884 1885 1886 1888 1889 1891 1894 1896 1897 1898 1899 1900 1901 1902 1903 1904 1905 1906 1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 1919 1920 1921 1922 1923 1924 1926 1927 1928 1929 1930 1931 1932 1933 1934 1936 1937 1938 1939 1940 1941 1942 1943 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1973 1975 1977 1978 1979 1982 1983 1984 1985 1986 1987 1989 1992 1995 1996 2001 2005 2009 2011 2014 2017 2018 2023 2026 2027 2029 2030 2032 2036 2037 2038 2040 2041 2042 2043 2044 2045 2046 2047 2048 2049 2050 2051 2052 2053 2054 2055 2056 2057 2058 2059 2060 2061 2062 2063 2064 2065 2066 2067 2068 2069 2070 2071 2072 2073 2074 2075 2076 2077 2079 2080 2081 2082 2083 2084 2085 2086 2087 2088 2089 2090 2091 2092 2093 2094 2095 2097 2099 2100 2102 2103 2105 2106 2107 2108 2109 2110 2111 2112 2113 2114 2115 2116 2117 2118 2119 2120 2121 2123 2124 2125 2126 2127 2128 2129 2130 2131 2132 2133 2135 2136 2137 2138 2139 2140 2142 2144 2145 2146 2147 2148 2149 2152 2153 2154 2155 2160 2161 2164 2166 2167 2168 2169 2170 2172 2173 2174 2175 2177 2178 2179 2182 2183 2184 2186 2187 2188 2189 2190 2191 2194 2195 2197 2198 2200 2201 2202 2203 2204 2205 2207 2208 2209 2211 2212 2214 2215 2217 2219 2220 2222 2223 2224 2225 2226 2227 2228 2229 2231 2232 2235 2236 2239 2241 2242 2243 2244 2245 2246 2247 2248 2249 2250 2251 2252 2254 2255 2256 2257 2258 2259 2260 2261 2262 2263 2264 2265 2266 2267 2269 2271 2272 2273 2274 2276 2277 2278 2279 2280 2281 2282 2283 2284 2285 2286 2287 2289 2290 2291 2292 2293 2294 2295 2296 2297 2299 2300 2302 2303 2304 2305 2306 2307 2308 2309 2310 2311 2312 2313 2314 2315 2316 2317 2318 2319 2320 2321 2322 2323 2324 2325 2326 2327 2328 2329 2330 2331 2332 2333 2334 2335 2336 2337 2338 2339 2340 2341 2342 2343 2344 2345 2346 2347 2348 2349 2350 2351 2352 2353 2354 2355 2356 2357 2358 2359 2361 2364 2365 2366 2368 2372 2375 2376 2380 2382 2391 2392 2394 2396 2399 2400 2401 2404 2405 2406 2408 2409 2410 2413 2415 2417 2419 2420 2422 2426 2427 2430 2431 2433 2434 2435 2437 2438 2440 2441 2442 2443 2444 2445 2447 2448 2449 2450 2451 2452 2453 2454 2455 2456 2457 2458 2460 2461 2462 2463 2464 2465 2466 2468 2470 2471 2472 2473 2474 2475 2477 2478 2479 2481 2482 2483 2484 2485 2487 2488 2489 2490 2491 2492 2493 2496 2497 2498 2499 2500 2501 2503 2504 2505 2507 2508 2509 2510 2511 2512 2514 2515 2517 2519 2520 2521 2523 2524 2527 2528 2529 2530 2531 2532 2533 2534 2535 2538 2539 2540 2541 2542 2544 2545 2546 2547 2548 2549 2551 2552 2554 2556 2557 2559 2562 2563 2565 2566 2567 2569 2570 2573 2574 2576 2577 2579 2581 2582 2583 2584 2586 2587 2588 2590 2591 2592 2594 2595 2597 2599 2601 2602 2604 2606 2609 2610 2611 2612 2613 2614 2615 2620 2621 2622 2623 2625 2627 2628 2629 2631 2632 2633 2634 2636 2637 2640 2641 2642 2643 2644 2645 2646 2648 2649 2652 2656 2657 2659 2662 2663 2664 2666 2667 2669 2670 2672 2673 2674 2675 2676 2677 2678 2679 2680 2681 2682 2683 2685 2686 2689 2690 2692 2694 2695 2696 2697 2698 2699 2701 2703 2704 2706 2707 2708 2709 2711 2712 2716 2719 2720 2721 2722 2723 2725 2726 2728 2730 2732 2734 2735 2740 2741 2745 2746 2747 2748 2750 2752 2753 2754 2755 2756 2757 2759 2760 2761 2763 2766 2767 2768 2769 2770 2773 2774 2776 2777 2778 2780 2781 2782 2783 2785 2786 2788 2790 2792 2794 2795 2796 2797 2798 2799 2801 2802 2803 2804 2805 2806 2807 2809 2811 2812 2814 2815 2816 2817 2818 2819 2820 2821 2822 2823 2824 2825 2827 2828 2829 2830 2832 2833 2834 2835 2836 2837 2838 2840 2841 2844 2845 2846 2847 2848 2849 2850 2851 2852 2853 2854 2855 2856 2858 2859 2860 2861 2863 2864 2865 2866 2867 2868 2869 2870 2871 2872 2873 2874 2875 2876 2877 2878 2879 2880 2881 2882 2883 2884 2885 2886 2887 2888 2889 2890 2891 2893 2894 2895 2896 2899 2900 2901 2902 2903 2904 2906 2907 2908 2909 2910 2911 2912 2913 2914 2915 2916 2917 2918 2919 2920 2921 2923 2924 2925 2926 2928 2929 2930 2931 2932 2933 2934 2936 2937 2938 2939 2940 2941 2942 2943 2944 2945 2947 2948 2949 2950 2951 2952 2954 2955 2956 2957 2959 2960 2961 2962 2964 2966 2968 2969 2970 2971 2972 2977 2978 2980 2982 2983 2985 2987 2988 2989 2990 2991 2992 2993 2995 2996 3000 3002 3003 3004 3005 3007 3008 3009 3010 3011 3013 3015 3016 3017 3018 3019 3020 3021 3022 3023 3024 3025 3027 3029 3030 3031 3032 3033 3039 3040 3041 3042 3044 3045 3047 3050 3053 3054 3055 3056 3058 3059 3060 3061 3062 3063 3065 3067 3070 3073 3074 3075 3077 3078 3081 3082 3083 3086 3087 3088 3090 3091 3093 3094 3095 3097 3099 3101 3102 3104 3105 3107 3109 3110 3112 3113 3114 3116 3117 3118 3120 3121 3122 3124 3128 3129 3130 3132 3133 3134 3135 3137 3140 with 40 links
```

```r
print(is.symmetric.nb(nb.cntyfk))
```

```
## [1] FALSE
```

```r


# nb.zipfk <- poly2nb(geozip.fk, queen=T)
nb.zipfk <- read.gwt2nb("/Users/heimannrichard/Google Drive/GIS Data/TwitterReading3ZIPJoinknn40.gwt", 
    region.id = geozip.fk@data$POLY_ID)
```

```
## Warning: region.id not named POLY_ID
```

```r
summary(nb.zipfk)
```

```
## Neighbour list object:
## Number of regions: 862 
## Number of nonzero links: 34480 
## Percentage nonzero weights: 4.64 
## Average number of links: 40 
## Non-symmetric neighbours list
## Link number distribution:
## 
##  40 
## 862 
## 862 least connected regions:
## 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 591 592 593 594 595 596 597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689 690 691 692 693 694 695 696 697 698 699 700 701 702 703 704 705 706 707 708 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757 758 759 760 761 762 763 764 765 766 767 768 769 770 771 772 773 774 775 776 777 778 779 780 781 782 783 784 785 786 787 788 789 790 791 792 793 794 795 796 797 798 799 800 801 802 803 804 805 806 807 808 809 810 811 812 813 814 815 816 817 818 819 820 821 822 823 824 825 826 827 828 829 830 831 832 833 834 835 836 837 838 839 840 841 842 843 844 845 846 847 848 849 850 851 852 853 854 855 856 857 858 859 860 861 862 with 40 links
## 862 most connected regions:
## 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 591 592 593 594 595 596 597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689 690 691 692 693 694 695 696 697 698 699 700 701 702 703 704 705 706 707 708 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757 758 759 760 761 762 763 764 765 766 767 768 769 770 771 772 773 774 775 776 777 778 779 780 781 782 783 784 785 786 787 788 789 790 791 792 793 794 795 796 797 798 799 800 801 802 803 804 805 806 807 808 809 810 811 812 813 814 815 816 817 818 819 820 821 822 823 824 825 826 827 828 829 830 831 832 833 834 835 836 837 838 839 840 841 842 843 844 845 846 847 848 849 850 851 852 853 854 855 856 857 858 859 860 861 862 with 40 links
```

```r
print(is.symmetric.nb(nb.zipfk))
```

```
## [1] FALSE
```



```r
sw.cntyfk <- nb2listw(neighbours = nb.cntyfk, style = "B", zero.policy = TRUE)
plot(geocnty.fk)
plot(sw.cntyfk, coordinates(geocnty.fk), add = T, col = "red")
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-91.png) 

```r

sw.zipfk <- nb2listw(neighbours = nb.zipfk, style = "B", zero.policy = TRUE)
plot(geozip.fk)
plot(sw.zipfk, coordinates(geozip.fk), add = T, col = "red")
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-92.png) 



```r
moran.mc(x = geocnty.fk@data$MEANflesch, listw = sw.cntyfk, nsim = 499, zero.policy = TRUE)
```

```
## 
## 	Monte-Carlo simulation of Moran's I
## 
## data:  geocnty.fk@data$MEANflesch 
## weights: sw.cntyfk  
## number of simulations + 1: 500 
## 
## statistic = 0.0085, observed rank = 481, p-value = 0.038
## alternative hypothesis: greater
```

```r

# notice the observed rank of 484 meaning that 15 simulated values were more
# extreme than the observed. What is the p-value here?

moran.mc(x = geozip.fk@data$MEANflesch, listw = sw.zipfk, nsim = 499, zero.policy = TRUE)
```

```
## 
## 	Monte-Carlo simulation of Moran's I
## 
## data:  geozip.fk@data$MEANflesch 
## weights: sw.zipfk  
## number of simulations + 1: 500 
## 
## statistic = 0.0465, observed rank = 500, p-value = 0.002
## alternative hypothesis: greater
```

```r

# notice the observed rank of 500 meaning that 0 simulated values were more
# extreme than the observed. What is the p-value here?
```


## Notice the observed rank of 500 meaning that zero simulated value was more extreme than the observed. What is the p-value here? What can you conclude about the two Moran's I between county and zip-code? 


```r
par(mar = c(4, 4, 1.5, 0.5))
moran.plot(geocnty.fk@data$MEANflesch, listw = sw.cntyfk, zero.policy = T, pch = 16, 
    col = "black", cex = 0.5, quiet = F, labels = as.character(geocnty.fk$STATE_NAME), 
    xlab = "FK Index", ylab = "FK Index (Spatial Lag)", main = "Moran Scatterplot")
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 

```
## Potentially influential observations of
## 	 lm(formula = wx ~ x) :
## 
##                dfb.1_ dfb.x dffit   cov.r   cook.d hat    
## Alabama         0.02  -0.02  0.02    1.00_*  0.00   0.00_*
## Alabama         0.01  -0.01  0.01    1.01_*  0.00   0.01_*
## Arkansas        0.08  -0.07  0.08    1.00_*  0.00   0.00_*
## Arkansas        0.22  -0.21  0.22_*  1.00    0.02   0.01_*
## Colorado       -0.02   0.01 -0.05    1.00_*  0.00   0.00  
## Colorado       -0.12   0.12 -0.12_*  1.00_*  0.01   0.01_*
## Colorado       -0.09   0.09 -0.09_*  1.01_*  0.00   0.01_*
## Colorado       -0.01   0.01 -0.05    1.00_*  0.00   0.00  
## Colorado       -0.01   0.01 -0.05    1.00_*  0.00   0.00  
## Florida         0.07  -0.06  0.07    1.01_*  0.00   0.01_*
## Florida         0.11  -0.11  0.11_*  1.01_*  0.01   0.01_*
## Georgia        -0.02   0.01 -0.05    1.00_*  0.00   0.00  
## Georgia        -0.03   0.02 -0.07    0.99_*  0.00   0.00  
## Georgia         0.09  -0.10 -0.12_*  0.99_*  0.01   0.00  
## Georgia        -0.01   0.01 -0.01    1.01_*  0.00   0.01_*
## Georgia         0.00   0.00  0.00    1.00_*  0.00   0.00  
## Georgia         0.01  -0.02 -0.05    1.00_*  0.00   0.00  
## Georgia        -0.04   0.03 -0.07    0.99_*  0.00   0.00  
## Georgia        -0.29   0.29 -0.29_*  1.00_*  0.04   0.01_*
## Georgia        -0.14   0.13 -0.14_*  1.01_*  0.01   0.01_*
## Georgia         0.01  -0.01  0.01    1.01_*  0.00   0.00_*
## Georgia        -0.02   0.01 -0.05    1.00_*  0.00   0.00  
## Georgia         0.03  -0.04 -0.07    1.00_*  0.00   0.00  
## Georgia         0.01  -0.02 -0.06    1.00_*  0.00   0.00  
## Georgia        -0.05   0.05 -0.07    0.99_*  0.00   0.00  
## Georgia        -0.09   0.08 -0.09_*  1.00    0.00   0.00  
## Georgia         0.00   0.00 -0.05    1.00_*  0.00   0.00  
## Georgia        -0.01   0.00 -0.05    1.00_*  0.00   0.00  
## Georgia        -0.13   0.13 -0.13_*  1.01_*  0.01   0.01_*
## Georgia         0.00   0.00 -0.05    1.00_*  0.00   0.00  
## Georgia         0.05  -0.05  0.05    1.00_*  0.00   0.00_*
## Georgia         0.02  -0.02  0.02    1.00_*  0.00   0.00  
## Georgia        -0.03   0.02 -0.07    0.99_*  0.00   0.00  
## Georgia        -0.12   0.11 -0.12_*  1.00_*  0.01   0.01_*
## Georgia         0.04  -0.04  0.04    1.01_*  0.00   0.01_*
## Idaho          -0.01   0.01 -0.01    1.00_*  0.00   0.00  
## Idaho          -0.06   0.06 -0.07    1.00_*  0.00   0.00_*
## Idaho           0.02  -0.03 -0.06    1.00_*  0.00   0.00  
## Illinois        0.12  -0.12  0.12_*  1.00    0.01   0.00_*
## Illinois        0.08  -0.07  0.08    1.00_*  0.00   0.00_*
## Indiana         0.11  -0.10  0.11_*  1.00    0.01   0.00_*
## Indiana         0.01  -0.01  0.01    1.00_*  0.00   0.00  
## Indiana         0.05  -0.05  0.05    1.00_*  0.00   0.00_*
## Indiana         0.12  -0.11  0.12_*  1.00    0.01   0.00_*
## Indiana         0.03  -0.02  0.05    1.00_*  0.00   0.00  
## Indiana         0.03  -0.02  0.05    1.00_*  0.00   0.00  
## Iowa           -0.01   0.01  0.01    1.00_*  0.00   0.00  
## Iowa            0.02  -0.02  0.02    1.00_*  0.00   0.00  
## Kansas          0.17  -0.16  0.17_*  1.00    0.01   0.01_*
## Kansas          0.04  -0.03  0.06    1.00_*  0.00   0.00  
## Kansas          0.10  -0.10  0.11_*  1.00_*  0.01   0.00_*
## Kansas          0.06  -0.06  0.06    1.00_*  0.00   0.00_*
## Kansas         -0.05   0.05 -0.05    1.00_*  0.00   0.00_*
## Kansas         -0.07   0.07 -0.07    1.01_*  0.00   0.01_*
## Kentucky        0.02  -0.01  0.06    0.99_*  0.00   0.00  
## Kentucky       -0.02   0.02  0.05    1.00_*  0.00   0.00  
## Kentucky       -0.09   0.10  0.11_*  1.00    0.01   0.00  
## Kentucky        0.00   0.00  0.05    1.00_*  0.00   0.00  
## Kentucky       -0.06   0.06 -0.06    1.00_*  0.00   0.00_*
## Kentucky       -0.03   0.03 -0.03    1.00_*  0.00   0.00_*
## Kentucky        0.02  -0.01  0.05    1.00_*  0.00   0.00  
## Kentucky        0.01  -0.01  0.01    1.00_*  0.00   0.00_*
## Kentucky        0.04  -0.04  0.07    0.99_*  0.00   0.00  
## Kentucky        0.03  -0.03  0.06    1.00_*  0.00   0.00  
## Louisiana       0.11  -0.11  0.11_*  1.01_*  0.01   0.01_*
## Louisiana       0.07  -0.06  0.07    1.01_*  0.00   0.01_*
## Maine           0.03  -0.03 -0.06    1.00_*  0.00   0.00  
## Maine           0.02  -0.02 -0.06    1.00_*  0.00   0.00  
## Maine           0.00  -0.01 -0.05    1.00_*  0.00   0.00  
## Maine          -0.08   0.08 -0.08    1.00    0.00   0.00_*
## Maine           0.04  -0.04 -0.07    1.00_*  0.00   0.00  
## Maine          -0.15   0.15 -0.15_*  1.01_*  0.01   0.01_*
## Maine          -0.10   0.10 -0.11_*  1.00    0.01   0.00_*
## Maryland       -0.04   0.04 -0.04    1.00_*  0.00   0.00_*
## Michigan       -0.03   0.03 -0.03    1.01_*  0.00   0.01_*
## Michigan       -0.01   0.01  0.01    1.00_*  0.00   0.00  
## Michigan       -0.02   0.02 -0.02    1.00_*  0.00   0.00_*
## Minnesota      -0.04   0.04 -0.04    1.00_*  0.00   0.00  
## Minnesota       0.04  -0.04  0.05    1.00_*  0.00   0.00  
## Minnesota      -0.01   0.01 -0.01    1.00_*  0.00   0.00_*
## Mississippi    -0.02   0.02 -0.02    1.01_*  0.00   0.00_*
## Mississippi     0.05  -0.05 -0.07    1.00_*  0.00   0.00  
## Mississippi    -0.01   0.01 -0.05    1.00_*  0.00   0.00  
## Mississippi     0.10  -0.09  0.10_*  1.00    0.01   0.00_*
## Mississippi    -0.01   0.01 -0.01    1.00_*  0.00   0.00  
## Missouri        0.08  -0.08  0.09    1.00    0.00   0.00_*
## Missouri        0.14  -0.14  0.14_*  1.00    0.01   0.00_*
## Montana        -0.21   0.21 -0.21_*  1.01_*  0.02   0.01_*
## Montana        -0.12   0.12 -0.12_*  1.01_*  0.01   0.01_*
## Montana         0.09  -0.10 -0.12_*  0.99_*  0.01   0.00  
## Montana         0.04  -0.05 -0.08    0.99_*  0.00   0.00  
## Montana        -0.11   0.11 -0.12_*  1.00_*  0.01   0.00  
## Montana        -0.04   0.03 -0.06    1.00_*  0.00   0.00  
## Montana        -0.03   0.02 -0.06    0.99_*  0.00   0.00  
## Montana        -0.11   0.10 -0.12_*  1.00_*  0.01   0.00  
## Nebraska        0.01  -0.01  0.01    1.00_*  0.00   0.00  
## Nebraska       -0.03   0.03 -0.05    1.00_*  0.00   0.00  
## Nebraska       -0.03   0.03 -0.03    1.01_*  0.00   0.01_*
## New Hampshire  -0.15   0.15 -0.16_*  1.00    0.01   0.00_*
## New Hampshire  -0.10   0.10 -0.10_*  1.01_*  0.01   0.01_*
## New Mexico      0.07  -0.06  0.07    1.01_*  0.00   0.01_*
## New York       -0.02   0.02 -0.02    1.00_*  0.00   0.00_*
## New York       -0.04   0.04 -0.04    1.00_*  0.00   0.00_*
## North Carolina -0.05   0.05 -0.05    1.00_*  0.00   0.00_*
## North Carolina  0.01  -0.01  0.05    1.00_*  0.00   0.00  
## North Carolina  0.00   0.00  0.00    1.00_*  0.00   0.00  
## North Carolina  0.00   0.01  0.05    1.00_*  0.00   0.00  
## North Carolina  0.06  -0.06  0.06    1.01_*  0.00   0.01_*
## North Carolina  0.11  -0.10  0.11_*  1.00_*  0.01   0.00_*
## North Carolina  0.02  -0.02  0.05    1.00_*  0.00   0.00  
## North Dakota   -0.02   0.02 -0.02    1.01_*  0.00   0.01_*
## North Dakota   -0.03   0.03 -0.03    1.01_*  0.00   0.01_*
## Oklahoma        0.09  -0.09  0.10_*  1.00_*  0.00   0.00_*
## Oregon          0.00   0.00  0.00    1.00_*  0.00   0.00  
## Oregon         -0.06   0.06 -0.06    1.00_*  0.00   0.00_*
## Pennsylvania    0.02  -0.02  0.02    1.00_*  0.00   0.00  
## Pennsylvania    0.00   0.00  0.00    1.00_*  0.00   0.00  
## Pennsylvania    0.00   0.00  0.00    1.00_*  0.00   0.00  
## Pennsylvania    0.03  -0.03  0.03    1.00_*  0.00   0.00_*
## South Carolina  0.07  -0.07  0.07    1.00    0.00   0.00_*
## South Carolina  0.07  -0.07  0.07    1.00_*  0.00   0.00_*
## South Carolina -0.03   0.04  0.06    1.00_*  0.00   0.00  
## South Dakota    0.12  -0.11  0.12_*  1.01_*  0.01   0.01_*
## Tennessee       0.04  -0.04  0.04    1.00_*  0.00   0.00_*
## Texas           0.03  -0.04 -0.07    1.00_*  0.00   0.00  
## Texas          -0.02   0.02 -0.02    1.02_*  0.00   0.02_*
## Texas          -0.01   0.01 -0.05    1.00_*  0.00   0.00  
## Texas           0.03  -0.03  0.03    1.00_*  0.00   0.00_*
## Texas          -0.01   0.00 -0.06    0.99_*  0.00   0.00  
## Texas          -0.02   0.01 -0.06    0.99_*  0.00   0.00  
## Texas          -0.02   0.02 -0.02    1.01_*  0.00   0.01_*
## Texas          -0.07   0.07 -0.07    1.00_*  0.00   0.00_*
## Texas           0.14  -0.14  0.14_*  1.01_*  0.01   0.01_*
## Texas           0.03  -0.03  0.03    1.00_*  0.00   0.00_*
## Texas           0.00   0.00  0.05    1.00_*  0.00   0.00  
## Texas           0.08  -0.07  0.08    1.00    0.00   0.00_*
## Texas           0.03  -0.04 -0.06    1.00_*  0.00   0.00  
## Texas           0.00  -0.01 -0.06    0.99_*  0.00   0.00  
## Texas          -0.09   0.09 -0.10_*  1.00_*  0.00   0.00_*
## Texas           0.03  -0.03  0.03    1.00_*  0.00   0.00_*
## Texas           0.00  -0.01 -0.06    0.99_*  0.00   0.00  
## Texas           0.01  -0.01  0.01    1.00_*  0.00   0.00_*
## Texas           0.05  -0.05 -0.08    0.99_*  0.00   0.00  
## Texas          -0.08   0.07 -0.08    1.01_*  0.00   0.01_*
## Utah           -0.01   0.01 -0.01    1.00_*  0.00   0.00  
## Virginia        0.04  -0.04  0.04    1.00_*  0.00   0.00  
## Virginia        0.02  -0.02  0.02    1.01_*  0.00   0.01_*
## Virginia        0.01  -0.01  0.01    1.01_*  0.00   0.00_*
## Virginia       -0.03   0.03 -0.04    1.00_*  0.00   0.00_*
## Virginia        0.01  -0.01  0.01    1.00_*  0.00   0.00_*
## Virginia        0.00   0.00  0.00    1.00_*  0.00   0.00  
## Washington      0.01  -0.01 -0.01    1.00_*  0.00   0.00  
## Washington     -0.03   0.03 -0.03    1.00_*  0.00   0.00_*
## West Virginia   0.06  -0.06  0.06    1.00_*  0.00   0.00_*
## West Virginia   0.18  -0.18  0.18_*  1.01_*  0.02   0.01_*
## Wisconsin      -0.01   0.01 -0.01    1.00_*  0.00   0.00  
## Wisconsin       0.00   0.00  0.00    1.00_*  0.00   0.00  
## Wisconsin       0.00   0.00  0.00    1.00_*  0.00   0.00_*
## Wyoming         0.04  -0.05 -0.08    0.99_*  0.00   0.00  
## Wyoming         0.03  -0.03 -0.06    1.00_*  0.00   0.00  
## Wyoming        -0.10   0.10 -0.11_*  1.00    0.01   0.00  
## Wyoming        -0.04   0.03 -0.06    0.99_*  0.00   0.00  
## Wyoming        -0.02   0.01 -0.06    0.99_*  0.00   0.00  
## Wyoming        -0.05   0.04 -0.09_*  0.99_*  0.00   0.00  
## Wyoming        -0.04   0.04 -0.07    0.99_*  0.00   0.00  
## Wyoming         0.05  -0.06 -0.10_*  0.99_*  0.00   0.00  
## Wyoming        -0.11   0.11 -0.12_*  1.00_*  0.01   0.00  
## Wyoming        -0.11   0.11 -0.11_*  1.00_*  0.01   0.01_*
```



```r
# manually make a moran plot standarize variables save to a new column
geocnty.fk@data$sFKmean <- scale(geocnty.fk@data$MEANflesch)
hist(geocnty.fk@data$sFKmean)
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-121.png) 

```r
summary(geocnty.fk@data$sFKmean)
```

```
##        V1        
##  Min.   :-6.588  
##  1st Qu.:-0.344  
##  Median : 0.066  
##  Mean   : 0.000  
##  3rd Qu.: 0.575  
##  Max.   : 1.997
```

```r
summary(geocnty.fk@data$lag_sFKmean)
```

```
## Length  Class   Mode 
##      0   NULL   NULL
```

```r
# create a lagged variable
geocnty.fk@data$lag_sFKmean <- lag.listw(sw.cntyfk, geocnty.fk@data$sFKmean)
hist(geocnty.fk@data$lag_sFKmean)
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-122.png) 



```r
# manually make a moran plot standarize variables save to a new column
geozip.fk@data$sFKmean <- scale(geozip.fk@data$MEANflesch)

# create a lagged variable
geozip.fk@data$lag_sFKmean <- lag.listw(sw.zipfk, geozip.fk@data$sFKmean)
hist(geozip.fk@data$lag_sFKmean)
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 

```r
summary(geozip.fk@data$sFKmean)
```

```
##        V1        
##  Min.   :-7.048  
##  1st Qu.:-0.349  
##  Median : 0.059  
##  Mean   : 0.000  
##  3rd Qu.: 0.474  
##  Max.   : 3.901
```

```r
summary(geozip.fk@data$lag_sFKmean)
```

```
##        V1        
##  Min.   :-39.86  
##  1st Qu.: -5.39  
##  Median :  3.03  
##  Mean   :  0.58  
##  3rd Qu.:  7.50  
##  Max.   : 19.77
```




```r
plot(x = geocnty.fk@data$sFKmean, y = geocnty.fk@data$lag_sFKmean, main = " Moran Scatterplot FK")
abline(h = 0, v = 0)
abline(lm(geocnty.fk@data$lag_sFKmean ~ geocnty.fk@data$sFKmean), lty = 3, lwd = 4, 
    col = "red")
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14.png) 

```r

# check out the outliers click on one or two and then hit escape (or click
# finish) identify(geocnty.fk$sFKmean, geocnty.fk$lag_sFKmean,
# geocnty.fk$STATE_NAME, cex = 0.8)
```



```r
plot(x = geozip.fk@data$sFKmean, y = geozip.fk@data$lag_sFKmean, main = " Moran Scatterplot FK")
abline(h = 0, v = 0)
abline(lm(geozip.fk@data$lag_sFKmean ~ geozip.fk@data$sFKmean), lty = 3, lwd = 4, 
    col = "red")
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15.png) 

```r

# check out the outliers click on one or two and then hit escape (or click
# finish) identify(geozip.fk$sFKmean, geozip.fk$lag_sFKmean,
# geozip.fk$STATE, cex = 0.8)
```


## Notice that the relationship is stronger at the zip-code level. Why do you think this is the case? Is it larger enough to alter our research question or interpretation of the results?



```r
plot(sp.correlogram(neighbours = nb.cntyfk, var = geocnty.fk@data$MEANflesch, 
    order = 6, method = "I", style = "B", zero.policy = TRUE))
```

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-161.png) 

```r

plot(sp.correlogram(neighbours = nb.zipfk, var = geozip.fk@data$MEANflesch, 
    order = 6, method = "I", style = "B", zero.policy = TRUE))
```

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-162.png) 


## What is the best interpretation of the correlogram for each - county and zip-code? Do you think an analysis for zip-code is best (hint: error bars)?


```r
local_cnty.mi <- localmoran(x = geocnty.fk@data$MEANflesch, listw = sw.cntyfk)
# p.adjust.method is appropriate for big data due to multiple hypothesis
# testing

local_zip.mi <- localmoran(x = geozip.fk@data$MEANflesch, listw = sw.zipfk)
# p.adjust.method is appropriate for big data due to multiple hypothesis
# testing
```



```r
class(local_cnty.mi)
```

```
## [1] "localmoran" "matrix"
```

```r
colnames(local_cnty.mi)
```

```
## [1] "Ii"        "E.Ii"      "Var.Ii"    "Z.Ii"      "Pr(z > 0)"
```

```r
class(local_zip.mi)
```

```
## [1] "localmoran" "matrix"
```

```r
colnames(local_zip.mi)
```

```
## [1] "Ii"        "E.Ii"      "Var.Ii"    "Z.Ii"      "Pr(z > 0)"
```

```r
# summary stats Moran's I for both county and 3-digit zip code
summary(local_cnty.mi)
```

```
##        Ii              E.Ii             Var.Ii          Z.Ii        
##  Min.   :-64.22   Min.   :-0.0178   Min.   :39.9   Min.   :-10.166  
##  1st Qu.: -1.56   1st Qu.:-0.0178   1st Qu.:39.9   1st Qu.: -0.245  
##  Median :  0.07   Median :-0.0178   Median :39.9   Median :  0.014  
##  Mean   :  0.34   Mean   :-0.0178   Mean   :39.9   Mean   :  0.057  
##  3rd Qu.:  1.99   3rd Qu.:-0.0178   3rd Qu.:39.9   3rd Qu.:  0.318  
##  Max.   : 98.81   Max.   :-0.0178   Max.   :39.9   Max.   : 15.648  
##    Pr(z > 0)    
##  Min.   :0.000  
##  1st Qu.:0.375  
##  Median :0.494  
##  Mean   :0.489  
##  3rd Qu.:0.597  
##  Max.   :1.000
```

```r
summary(local_zip.mi)
```

```
##        Ii              E.Ii             Var.Ii          Z.Ii       
##  Min.   :-61.28   Min.   :-0.0465   Min.   :39.4   Min.   :-9.756  
##  1st Qu.: -1.47   1st Qu.:-0.0465   1st Qu.:39.4   1st Qu.:-0.227  
##  Median :  0.49   Median :-0.0465   Median :39.4   Median : 0.085  
##  Mean   :  1.86   Mean   :-0.0465   Mean   :39.4   Mean   : 0.303  
##  3rd Qu.:  3.30   3rd Qu.:-0.0465   3rd Qu.:39.4   3rd Qu.: 0.534  
##  Max.   :136.79   Max.   :-0.0465   Max.   :39.4   Max.   :21.801  
##    Pr(z > 0)    
##  Min.   :0.000  
##  1st Qu.:0.297  
##  Median :0.466  
##  Mean   :0.453  
##  3rd Qu.:0.590  
##  Max.   :1.000
```


## What can you determine from five number summary of Ii for both county and zipcode? 


```r
geocnty.fk$lmi <- local_cnty.mi[, 1]
geocnty.fk$lmi
```

```
##    [1]  2.479e+00  5.046e-01 -9.621e-02 -4.781e+00  2.860e+00 -6.012e-01
##    [7] -1.082e-01 -1.863e-01  2.619e+00 -1.686e+00  5.210e-01 -1.362e+00
##   [13]  1.618e+00 -4.645e-01 -2.643e-01 -2.307e-01  4.949e-01 -1.703e+00
##   [19] -1.090e+00 -4.060e+00 -5.098e+00 -1.924e+00  2.306e+00 -1.422e+00
##   [25] -6.205e-01  2.213e+00 -6.440e-01  3.023e-01 -3.809e+00 -6.301e-01
##   [31] -2.947e-01 -1.134e+00 -5.118e-02  5.127e+00  6.934e-01  2.544e+00
##   [37]  1.170e+00 -1.634e+00 -5.414e+00 -1.537e-01  3.802e-01  2.169e+00
##   [43]  3.709e+00 -1.182e+00 -1.438e+00  3.616e+00 -8.585e-01  1.443e+00
##   [49]  5.203e-01  1.941e+01  2.678e-01 -3.727e-01 -1.132e+00  8.770e+00
##   [55] -2.633e+00 -6.711e+00 -2.802e+00  1.008e+00  1.077e-01 -9.072e+00
##   [61]  3.707e+00 -9.237e+00 -5.550e+00  6.674e+00 -2.000e-02  1.071e-01
##   [67]  6.943e-01 -3.485e-01 -1.416e+00  4.460e-02 -2.487e-02  3.351e-01
##   [73] -5.552e-01  3.951e-01  6.620e-01 -6.596e-02 -8.514e-02  3.043e-01
##   [79] -9.429e-01 -3.298e+00 -8.370e+00 -9.100e+00  1.108e+01  3.373e+00
##   [85]  2.899e+00  5.994e+00  7.817e+00  1.444e+00 -5.733e-01 -5.217e-01
##   [91]  8.102e+00  3.182e-02  5.242e-01  5.273e+00  3.154e+00 -1.161e+01
##   [97]  8.974e-01 -1.790e+00  1.790e+00  8.183e+00 -1.450e+00  1.021e+01
##  [103] -2.753e-01 -7.052e+00  1.602e+00  3.607e+00 -2.138e+00 -3.859e+00
##  [109] -1.250e+01  1.327e+01  4.985e+00 -2.161e+01  5.547e-01  5.322e+00
##  [115] -1.014e+01 -1.355e+01 -5.430e+00  4.047e+00 -5.112e+00 -3.480e-02
##  [121] -6.422e+01  9.256e-01 -1.020e+00 -1.081e-01  1.758e+00  2.409e+00
##  [127]  7.322e+00  7.873e+00 -2.491e+00  3.259e+00 -2.199e+00  1.459e+00
##  [133] -1.458e+00  2.481e+00 -1.466e-02 -2.926e+00  5.034e-02  4.013e+00
##  [139]  7.276e-02 -1.508e-01 -4.669e-02 -7.375e+00  3.790e+00  1.029e+00
##  [145]  6.857e-01 -1.225e+00 -8.759e+00  8.870e-02  9.117e-01  6.719e-01
##  [151] -3.015e+00 -2.910e-01 -3.336e+00  2.204e-01 -2.108e+00  6.550e-02
##  [157] -2.167e+00 -1.379e+00  1.468e+00 -1.623e-01  5.113e-02  2.537e-02
##  [163]  7.365e-03 -1.056e+00  3.216e-01  3.742e-01 -1.221e-01  9.926e-01
##  [169]  2.276e-01  9.112e-01 -1.873e-01 -1.507e-02  6.356e-01  2.911e-01
##  [175]  4.793e-02 -3.263e-01  1.738e-02 -1.945e+00  2.030e-01  2.825e+00
##  [181]  1.601e-01  8.827e-02  7.065e-01  1.844e+00  3.457e-01  6.028e-01
##  [187]  1.414e+00  3.240e+00 -1.985e+00  6.167e+00 -4.411e+00  8.172e+00
##  [193]  4.209e+01 -7.684e-01 -9.600e+00 -3.776e-01 -1.047e+01  3.558e+01
##  [199]  5.408e-03  4.475e+00  2.863e+00  1.925e+00 -5.191e+00 -9.142e+00
##  [205]  6.571e+00 -1.077e+01 -3.360e-01  2.497e+00 -1.732e-01 -3.279e+00
##  [211]  2.547e+01  2.971e+00 -1.938e+00  1.514e+00 -1.154e+00 -9.194e-02
##  [217]  1.286e+00 -2.306e-01  1.754e+00  6.824e-01 -5.075e+00 -4.067e-03
##  [223]  3.911e-01 -1.098e+00  2.174e+00  5.504e-01 -2.680e-01 -2.218e+00
##  [229] -8.192e-01  1.928e+00  5.753e-01  2.287e+00  2.418e+00 -8.605e-01
##  [235] -1.355e+00  7.459e-01 -1.804e+00 -1.332e+00 -2.535e+00  2.946e-01
##  [241]  7.201e-02  6.408e-01  7.385e-01 -1.680e+00  6.524e+00  1.840e+00
##  [247] -1.209e+01  3.594e+00 -3.484e-01  1.885e+00  1.151e-01 -2.025e+00
##  [253]  7.237e+00 -1.350e+00  8.349e-01 -1.208e+00 -1.314e+00  2.056e-01
##  [259]  3.595e-02 -2.064e-01  6.169e-03  1.640e+00 -3.201e-01 -3.275e+00
##  [265]  1.213e+00 -2.260e+00  1.327e-01 -5.410e-01 -5.641e+00  6.755e-01
##  [271]  8.486e-01  1.723e+00  1.225e+00  7.077e-01 -5.575e-01  1.144e+00
##  [277] -2.169e+00 -4.185e+00 -9.662e-02  2.487e-01 -1.263e-01  2.129e+00
##  [283] -2.496e+00  2.735e-01 -1.357e+01 -1.009e+00  2.436e+00 -2.780e+01
##  [289] -1.170e+00  2.044e-01 -1.051e+00  4.716e+00 -5.640e-01  3.143e+00
##  [295]  1.884e+00  7.680e+00 -3.099e+01 -1.236e+00  2.420e+00  2.900e-01
##  [301]  9.956e+00  2.874e+00 -8.585e-01 -5.268e-01  2.358e-01  5.042e+00
##  [307] -1.264e+00  6.934e-02 -2.238e+00  1.350e-01 -1.645e-01 -8.701e-01
##  [313]  2.466e+00 -2.549e+00  1.550e+00 -8.053e-01 -3.022e-01  1.490e+00
##  [319]  4.226e+00  7.164e+00  6.764e-01  7.674e-01 -1.311e+00 -2.128e+00
##  [325]  1.208e+01 -1.462e+00  1.424e+00  1.939e+00  1.437e+00 -1.018e-02
##  [331]  3.810e+00 -9.673e-01 -1.695e+00 -2.053e+00  7.333e-02 -4.355e+00
##  [337] -1.293e-01 -3.756e+00 -1.898e-01 -2.640e+00  9.872e-01  1.579e-02
##  [343] -5.400e-01  9.670e-01 -3.803e-01 -1.327e-01 -9.372e+00  1.077e+01
##  [349] -6.269e+00  9.075e+00 -9.379e-02  9.166e-01 -4.813e+00  4.482e+00
##  [355]  9.881e+01  4.922e+01 -8.684e-01 -1.894e+00 -4.943e+00 -4.069e+00
##  [361]  1.183e+01  1.057e-01 -4.394e+00  9.199e-01  1.297e-01  3.871e+00
##  [367] -1.848e+00  1.780e+00  1.053e+00 -1.236e+01 -5.470e-01 -1.968e+00
##  [373]  2.688e+00 -2.182e+00 -7.016e+00 -9.116e-01 -1.668e-02  1.567e+01
##  [379] -8.342e+00 -3.719e+00  2.723e+01 -1.031e+01  7.640e-01 -3.739e-01
##  [385]  2.975e+00 -6.483e-01  1.437e+01  1.336e+01  6.047e+00 -1.903e+00
##  [391]  1.243e+00  4.751e+01  2.925e-02 -1.058e+00 -1.382e+01 -5.445e+00
##  [397] -1.324e+01 -5.504e-02 -1.123e+00 -4.930e-02 -3.860e+00 -1.232e+01
##  [403] -2.939e+00  7.441e+00  4.087e+01 -2.853e+00 -1.629e+00 -2.972e+00
##  [409]  2.405e+00 -8.946e+00  6.134e-01 -8.576e+00  1.864e-01 -1.635e+00
##  [415]  9.222e-01 -4.025e+00 -1.103e+00  2.289e-01 -6.860e+00 -1.352e+00
##  [421]  3.980e+00 -6.423e+00  2.155e+01  2.506e+00 -2.236e-01 -8.653e+00
##  [427] -8.649e-01 -4.574e+00  9.314e+00  4.716e-01 -1.548e-01 -1.519e+00
##  [433] -4.727e-01 -8.516e+00 -5.252e+00  1.444e-02 -2.066e+00 -4.029e-01
##  [439] -1.269e+00 -3.232e-02 -1.285e+00 -6.314e+00  5.025e+00 -5.326e+00
##  [445] -7.887e-01 -2.415e-01  2.262e-01  2.778e-01  6.075e+00  3.983e+00
##  [451] -1.092e+00 -1.913e+01  2.570e+00  5.607e+00  2.707e+00  5.365e+00
##  [457]  4.639e+00  2.119e+00  9.015e+00 -7.595e-01 -3.920e+00 -1.479e+01
##  [463] -3.400e-01 -5.123e+00 -2.294e+00  6.046e-01  7.343e-02 -1.100e+00
##  [469]  4.574e+00  3.118e+00 -8.285e+00  2.917e+00 -1.386e+00  3.555e+00
##  [475]  3.461e+00  3.694e+00  1.843e-01 -3.680e+00  7.488e+00 -3.676e+00
##  [481] -3.507e+01 -1.475e+00 -1.788e-02  3.801e-01 -4.404e+00 -1.059e+00
##  [487] -1.407e-01  2.549e+00  1.466e+00 -2.043e+01  1.991e-01  1.354e-02
##  [493] -1.283e+01 -2.277e-01 -3.387e+00 -7.019e-01 -2.216e-01  1.103e+00
##  [499]  5.806e+00  1.761e-01  2.929e-03  1.789e+00 -1.129e+01  3.424e+00
##  [505] -6.413e-01  1.010e-01  2.106e+00  1.483e-01 -5.389e+00 -4.380e-03
##  [511]  1.034e+01  2.109e+00  2.798e+00  1.761e-01  2.893e+00 -1.974e+01
##  [517]  5.281e+00 -3.140e+01 -8.121e+00  6.291e+00 -2.895e+00  1.828e+00
##  [523]  1.146e+01  5.035e-02 -1.678e+00  1.730e+01 -4.467e+00  2.271e+00
##  [529]  8.135e+00  1.282e+00  1.133e+01 -2.889e+00 -8.308e-01  1.576e+00
##  [535] -2.836e-01 -8.296e-01  1.656e-01  3.156e-02  1.440e+00  7.749e+00
##  [541]  1.033e+00 -1.735e+00 -2.002e+00  7.777e-01  5.482e+00  1.472e+00
##  [547] -1.187e+01  2.075e+00  2.152e+00  7.130e+00  8.057e-01 -2.899e-01
##  [553] -1.304e+00  1.058e+01 -1.817e-01 -1.310e+00 -3.407e+01  9.092e-01
##  [559] -3.165e-01  1.340e+01  1.289e+01 -7.357e+00 -2.279e+00 -2.046e+00
##  [565]  3.209e+00 -1.276e+00  7.989e+00 -3.519e-01  2.748e-01 -5.298e-01
##  [571]  3.147e-01 -1.700e+00 -4.996e+00 -1.374e-01  1.652e+01  3.640e+00
##  [577]  2.851e+00  4.284e-01 -3.624e+00  1.369e+01  9.570e-01  4.686e-01
##  [583] -6.773e+00  5.365e-01 -1.679e+00  7.276e+00  1.043e+00  5.779e+00
##  [589]  2.788e-01  2.549e-01 -1.554e+00 -2.573e+00  1.051e+00 -1.229e+01
##  [595] -3.204e+00 -4.061e+00  1.200e+01  4.319e+00  5.052e+00  1.584e+01
##  [601] -3.617e-02  4.537e-01 -2.470e-01  2.830e+00  3.139e+00 -4.454e-01
##  [607]  8.466e+00 -4.009e-01  7.243e+00 -2.217e-01 -1.913e+00  2.416e+00
##  [613] -3.269e+00  8.272e+00  1.109e+01  3.619e-01 -1.498e+00 -5.677e+00
##  [619]  7.654e+00  1.532e+00  6.640e+00  1.190e-01  7.302e-01  1.408e+00
##  [625]  2.300e+00  1.557e+01  4.360e+00 -2.847e+00  8.834e+00 -1.806e+01
##  [631]  2.270e+00  1.577e+00 -5.069e+00 -3.578e+00 -1.766e+00  8.837e-01
##  [637]  7.865e+00  8.430e+00  3.077e+00  1.478e+00 -7.896e+00  3.956e+00
##  [643]  3.537e+00  9.016e+00  1.978e+00  1.239e+00  1.025e+01  3.003e-01
##  [649]  2.971e+00  1.003e+01 -4.898e+01  6.052e-01  2.432e+00 -3.855e+00
##  [655] -8.661e+00 -1.979e+00  4.644e+00 -5.780e+00 -1.112e+01 -2.982e+01
##  [661] -1.877e+01 -1.073e+00  7.541e+00  3.167e+00  3.057e-01 -3.051e+00
##  [667] -6.129e-01  2.487e+00  4.178e+00  5.334e+00 -1.722e+01  1.209e-01
##  [673]  8.529e+00  3.611e-01 -8.587e-01  1.672e+00 -5.917e-01 -4.195e-01
##  [679] -2.017e-01 -5.102e+00  5.897e+00  1.787e+01 -2.102e+00  3.523e+00
##  [685]  2.840e+01 -5.121e+00  1.179e+00  1.545e+00 -4.103e+00  2.055e+01
##  [691] -4.425e+00  7.865e+00 -3.538e+00 -1.225e+00  4.609e-01  6.853e-01
##  [697]  2.975e-01 -1.233e-01 -8.155e+00  1.410e+00  4.769e+00  9.347e-01
##  [703] -1.803e+00  3.572e+00  1.714e+00  3.869e+00  7.731e-01  1.092e+01
##  [709]  3.390e+01  1.028e-01  6.024e-01  1.376e+01 -3.270e+00  2.899e-01
##  [715] -8.546e+00 -7.759e-01  1.694e+00  6.215e+00 -9.075e+00  2.024e+01
##  [721]  3.289e+00  1.940e+01  1.212e+01 -4.151e-01  4.208e+00  4.139e+00
##  [727]  1.771e+00  1.204e+01  2.570e+00 -3.429e+00 -2.282e-01 -2.265e+00
##  [733]  8.936e-01  2.516e+00 -1.664e+00  2.600e-01  3.962e-01  2.831e+00
##  [739]  8.651e-01 -3.474e-01 -4.368e+00  1.629e+00 -1.579e+00  8.872e+00
##  [745] -2.164e+00  1.500e+00  2.056e+00  1.687e+00  1.057e+00 -4.099e+00
##  [751]  1.859e+01  1.535e+01  1.468e-01 -1.690e-01  2.906e-01 -1.114e+00
##  [757] -6.971e+00 -9.505e-01  9.426e-01  2.361e+00 -5.079e+00 -6.625e-01
##  [763] -1.163e+01 -5.760e+00  4.857e+00 -3.511e+00 -3.282e+00 -8.491e+00
##  [769]  3.074e+00  4.539e-01 -3.969e-01  1.823e+01  3.742e+00  4.503e-01
##  [775] -2.316e+00  4.421e-01 -4.790e-02 -5.291e-01 -2.849e+01  5.451e-01
##  [781]  2.582e+00 -5.330e-01  1.965e-01 -3.483e-01 -6.828e+00  4.186e+00
##  [787]  1.093e+00  7.766e-02 -1.701e-01  1.407e-02  6.509e+00 -1.645e+01
##  [793] -9.398e-02 -1.400e+00 -1.311e+00 -1.426e+00  5.931e-02  1.037e-01
##  [799]  1.869e+00 -4.907e+00  1.036e+00  1.263e-01 -3.412e+00 -2.326e+00
##  [805]  1.096e+00 -3.198e-01  6.552e-02  3.165e+00  1.271e+00 -1.075e+00
##  [811]  2.337e+00  5.774e-01  2.382e+00 -2.616e-01  7.967e-02  2.675e-01
##  [817] -8.762e-02 -1.469e+00  1.726e-01  1.661e-01 -1.369e+00 -5.769e-01
##  [823]  4.234e-01  2.092e+00 -8.248e-01  1.773e+00 -8.195e+00 -1.557e+00
##  [829] -1.619e+00  3.518e+00 -5.213e+00 -1.082e+01  6.183e+00 -7.341e+00
##  [835] -7.606e+00 -3.311e+00  2.729e+01 -1.343e+01  9.623e+00  5.442e+01
##  [841]  5.446e+00  3.398e+01 -4.695e+00  5.670e-01  8.806e-01  3.519e-01
##  [847] -1.165e-01 -4.291e+00 -6.603e+00  4.332e-01  9.134e-01  4.091e+00
##  [853] -1.415e+00 -1.481e+00  9.667e-01 -3.312e-01  2.587e-02 -4.584e+00
##  [859] -4.086e-02  3.708e-01 -6.156e-01  4.438e+00  1.430e+01  4.998e+00
##  [865]  3.337e+00  2.335e-01  1.859e-01  7.616e-01 -1.882e+00 -2.602e+00
##  [871]  2.145e-01 -5.751e+00  4.998e-01  3.068e+00  9.505e-01 -4.534e-01
##  [877]  2.849e-01  7.549e-01 -4.803e-01  2.566e-01 -4.730e-01 -6.098e+00
##  [883]  5.410e-01 -1.898e+00  1.646e+01  4.822e-01  6.768e+00 -8.182e-01
##  [889] -5.837e-01  9.728e-01  2.485e-01  3.630e-01  8.651e-01 -2.172e-01
##  [895]  2.031e+00 -1.227e+01 -2.668e+00 -8.374e-01  6.712e-01 -4.695e+00
##  [901]  2.084e+00  2.445e+00  6.364e-01 -4.369e-01 -2.367e+00  5.308e+00
##  [907]  3.314e-01  3.199e+00  1.987e+00 -8.951e-01 -4.466e-01 -1.855e+00
##  [913]  4.839e+00 -4.323e+00 -1.046e-01 -4.369e-01 -1.442e+00  2.065e+00
##  [919]  1.050e+00 -5.733e+00  7.312e+00 -6.225e+00 -1.970e-02  2.869e+00
##  [925] -1.445e+00 -3.735e+00 -4.772e+00 -3.673e-01  1.102e+01  9.335e+00
##  [931] -1.774e+00  1.776e+00 -3.484e-01 -5.528e+00 -2.734e-02  3.209e+00
##  [937] -1.427e-01 -1.610e+00  3.497e-02 -5.015e-01  3.001e-01  2.921e-01
##  [943] -2.191e-01  1.209e+00  2.074e+00 -1.714e+00  2.427e-01  2.128e-01
##  [949] -3.446e+00  6.818e-01 -6.053e+00  5.387e+00 -1.909e+00 -9.643e-02
##  [955] -3.978e+00  2.083e+00 -2.140e-02 -4.146e+00  3.061e+00 -2.627e+00
##  [961] -7.043e-01  3.499e-01 -3.941e-01 -7.041e-01  2.590e-01 -3.421e+00
##  [967]  9.357e-01 -1.522e+01  4.837e+00 -8.552e+00  1.178e+00  8.767e-01
##  [973] -2.420e-01 -9.949e-01 -1.283e+01 -2.131e+00  1.291e+01 -1.111e-02
##  [979] -8.566e-02  6.633e+00  1.933e+00  6.229e-03  6.231e+00  1.305e+01
##  [985] -7.862e+00 -1.006e+00 -1.044e+00 -1.220e+01  1.158e+00 -2.193e+00
##  [991]  8.637e+00  5.804e+00 -1.150e+00 -6.132e-02 -1.504e+00 -1.914e+00
##  [997]  5.410e+00 -4.785e-01  1.638e+00 -9.324e+00 -1.054e+00 -3.535e-02
## [1003] -8.553e-01  6.605e+00 -1.078e-01  3.847e-01 -6.729e+00 -4.343e+00
## [1009] -3.118e-01 -7.614e+00 -8.229e-01  1.637e+01  8.582e+00  5.256e+00
## [1015] -1.705e+01 -5.495e-01 -4.729e-02  8.670e+00  2.535e+00  3.261e-01
## [1021]  5.813e+00 -4.078e+00  2.740e+00 -6.930e-01  3.380e-01 -9.400e-01
## [1027] -1.307e+00  4.551e+00  9.206e+00  2.786e+00 -8.472e-01 -4.546e+00
## [1033] -2.580e+00 -5.348e-01  7.573e-01 -1.165e+00 -6.711e-01 -2.077e+00
## [1039] -1.555e+00  8.371e+00 -3.821e-01 -4.208e-01  2.332e+00  5.386e-01
## [1045]  2.150e+01 -2.086e-01  3.913e-01 -5.986e-01  2.705e+00 -5.049e+00
## [1051]  2.003e+00 -8.985e-02 -1.004e+01 -7.048e+00  7.741e-01 -9.698e-02
## [1057]  4.500e-01 -2.861e+01  3.976e+00  1.498e+01  2.125e-02 -2.391e+00
## [1063] -5.306e-02  2.576e+00  2.928e+00 -3.527e+00  1.837e-01  3.578e-02
## [1069]  3.545e+00 -6.207e+00  1.424e+00  5.026e+00  5.781e-01 -4.145e+00
## [1075]  4.716e+00  7.403e-01  3.452e+00  7.956e+00  6.116e+00 -1.907e+01
## [1081]  3.208e+00 -2.029e+00  4.599e+00  7.819e-01  1.114e+00 -3.034e+00
## [1087] -4.150e-02  6.232e+00  8.097e-01  9.099e+00  4.261e+00 -5.997e-01
## [1093]  6.859e+00  9.715e-01  8.264e-01  1.801e+00  7.326e+00 -1.255e+01
## [1099] -9.872e-01 -3.304e+00 -9.057e-01  1.492e+00  5.307e+00 -3.483e+00
## [1105] -1.734e+01  1.341e+00  1.011e+01  3.402e+00 -8.587e+00 -1.749e+00
## [1111] -6.616e-01 -2.403e+01  3.668e+00  4.371e+00 -3.545e+00  5.159e+00
## [1117] -4.844e+00 -1.106e+01  4.050e+00 -1.350e+00  1.329e+00  1.047e+00
## [1123]  5.965e-01  2.149e+00  1.138e+00  6.168e+00  9.786e+00  9.451e-01
## [1129]  1.550e-01 -4.110e+01 -1.050e+01  6.667e-01  3.125e-01  1.071e+01
## [1135]  5.970e-01  8.743e-03 -3.151e+00  8.680e+00  2.172e-01  1.174e-01
## [1141]  1.450e-01  2.475e+00 -1.136e-01  7.290e+01  4.490e+01 -3.628e+00
## [1147] -3.264e+01 -1.460e+01 -3.657e-01  9.977e-01  3.558e+01  4.396e+00
## [1153]  1.970e+00  1.106e+01  8.136e+00  6.117e+00  3.437e+01  3.172e-02
## [1159]  1.935e+00  2.909e+00  8.163e+00  6.673e+00 -7.953e+00 -8.433e+00
## [1165]  1.940e+00 -5.548e+00  7.869e-02 -2.066e+00  5.397e+00  1.135e+01
## [1171] -5.592e+00  3.894e-01 -3.230e+00 -8.822e-01 -2.652e+00  3.175e-02
## [1177]  5.914e+00  8.312e+00  3.492e+00  1.631e+00 -2.156e+00  2.246e-01
## [1183] -5.133e+00 -3.487e-01 -3.407e+00  1.699e+01  3.721e+00 -1.813e-01
## [1189] -9.462e+00  3.541e+00 -6.321e-01  6.476e+00  9.741e+00  7.297e-02
## [1195] -5.873e+00 -4.100e-01 -2.526e-02 -6.292e-02 -2.559e-01 -3.760e+00
## [1201] -1.312e+00 -1.948e+00 -2.743e+00  5.688e-02  3.720e-01  7.324e+00
## [1207] -8.512e-01 -3.307e+00  6.550e+00  5.099e+01  1.117e+01 -1.122e+00
## [1213]  4.791e+00 -2.394e+00 -7.117e-02  3.866e+01 -2.216e-01  1.679e+00
## [1219] -1.387e-01 -4.195e-02 -8.041e-03 -1.179e-02 -4.880e-03  2.733e-01
## [1225] -3.648e-01  2.152e-01 -8.112e-01 -4.371e-01  6.969e-01  1.720e+00
## [1231]  1.443e-01  3.097e-01 -2.013e+00  9.671e-02  3.127e+00  4.608e-01
## [1237]  1.847e+00  1.079e+00 -1.304e+00 -1.111e+00  1.367e+00 -9.067e-01
## [1243] -9.911e+00  4.501e+00  1.058e+00 -1.475e+01 -5.267e+00  8.744e-01
## [1249] -2.312e+00 -1.896e+01  1.638e+01  4.869e-01  6.963e-01  2.493e-01
## [1255] -8.015e+00 -8.421e+00 -1.645e+00  5.257e+00 -1.920e+00 -3.495e+00
## [1261] -1.058e+00  3.708e-02  1.464e+00 -4.642e+00 -4.274e+00  9.785e-01
## [1267] -1.776e-01  1.169e+00  7.585e+00  1.694e-01 -4.539e+00 -9.028e-02
## [1273]  1.101e+00 -3.402e+00 -7.057e-01 -2.033e+00 -2.276e+00 -5.628e-01
## [1279] -1.572e-01  1.756e+00 -2.689e+00  1.242e-01  9.305e-02 -7.939e+00
## [1285]  2.393e+00  1.350e+00 -1.630e+00 -5.409e-01  2.088e-01 -2.106e+00
## [1291] -8.543e-02  6.227e-01  3.975e-01 -1.214e-01  4.135e-01  4.235e-01
## [1297]  2.213e+00  4.489e-01  3.331e+00 -1.383e-01  7.716e-01 -3.658e+00
## [1303] -2.819e+00 -2.439e-01  2.849e+00  5.874e-01 -1.374e+00  6.856e-01
## [1309] -1.223e+00  6.211e-01  5.873e+00  1.469e+01  4.667e-02 -4.791e-01
## [1315]  4.294e+00 -2.189e+00 -1.202e-01  3.816e+00  2.208e-01  1.153e+00
## [1321] -5.501e+00 -1.951e+00 -4.764e+00 -3.349e-01 -1.589e+00  6.641e-01
## [1327] -1.375e+00  1.891e-01 -2.238e+00 -2.012e-01 -5.623e-01  2.701e+00
## [1333] -1.109e+00  1.362e+00 -2.496e-01 -1.982e+00  1.790e+01  6.680e-02
## [1339]  1.330e+01 -1.219e+00  1.728e-02 -1.713e+00 -2.185e+00  6.158e-01
## [1345] -5.730e-01  2.221e+00 -1.377e+00 -7.472e+00 -2.899e-01 -6.056e+00
## [1351]  8.243e-01  5.991e+00  1.170e+00 -3.458e-02  1.029e+00  1.887e+00
## [1357]  7.624e-01 -6.937e+00 -1.332e+01 -8.386e-02  5.700e+00  9.120e+00
## [1363] -3.056e+01  2.862e+00  1.529e+00 -3.951e-01 -4.371e+00  3.088e+00
## [1369] -4.829e-02  4.912e+00 -5.474e-01 -2.975e+00 -1.059e+00  2.529e-01
## [1375]  3.748e+00 -4.374e+00  2.014e+00 -2.103e-01  9.345e-01 -1.778e-01
## [1381]  3.939e+00  1.189e+00  1.824e+00  1.339e-01  3.275e+00 -1.444e+00
## [1387]  5.131e+00 -6.833e-01 -3.003e+00  2.995e+00  4.222e+00 -1.731e+01
## [1393]  2.032e+00 -1.095e+00  8.056e-02 -3.336e+00 -1.740e+00 -2.065e+00
## [1399]  2.850e-01 -5.628e+00  7.671e+00 -2.255e-01  1.161e+01  2.226e+00
## [1405]  1.294e+00 -6.430e+00  4.447e+00 -2.421e-01  1.114e+00  1.432e+01
## [1411] -9.985e+00 -2.735e+00 -1.104e+01  5.708e-02 -8.115e+00  4.500e-01
## [1417] -1.608e+00  6.782e-01 -1.409e+01 -2.913e+00  3.871e+00  1.779e+00
## [1423]  8.400e-01 -5.330e-01  4.736e-01  9.039e-03 -1.559e+00 -3.107e+00
## [1429]  1.128e+00  4.484e+00  1.123e+00  5.143e-01  2.531e+00  2.365e+00
## [1435]  1.674e+00 -1.450e+00 -1.051e+00 -1.942e+00  4.071e+00 -1.082e-01
## [1441]  2.884e+00 -1.127e+00 -9.180e-02 -1.898e+00 -3.808e+00  3.985e+00
## [1447] -5.240e-01  2.230e+00 -3.521e+00 -4.134e+00 -1.952e-01  5.223e+00
## [1453] -7.953e-01  2.415e+00  9.878e+00  3.261e+00 -1.079e+00  1.957e+00
## [1459]  2.012e+00  3.883e-01 -3.330e+00  1.107e+00 -1.586e+00  8.456e-02
## [1465]  3.429e-01 -4.982e+00  2.468e+00  8.153e-01  9.465e-01  1.536e+00
## [1471]  1.249e-02  7.097e+00  3.513e-01 -5.721e-01 -3.358e+00  2.024e+00
## [1477]  4.265e-02 -3.311e+00  2.976e-01 -6.266e+00  5.470e-01 -1.791e+00
## [1483]  9.154e-01 -5.852e-05  1.466e+00  7.508e+00 -1.444e+00  7.142e-01
## [1489]  1.167e+00 -6.151e-02  3.242e+00 -4.408e+00 -2.956e-03 -6.248e-01
## [1495] -1.717e-01 -2.158e+00 -5.857e+00  1.691e+00  5.356e-01  3.341e-01
## [1501]  1.287e+00  8.860e-01  4.689e-02  1.014e+01  2.071e+00 -2.645e+01
## [1507] -1.476e+00  1.464e+00 -3.518e+00 -3.149e-01  3.616e+00  4.031e-01
## [1513] -1.310e+01 -1.890e+00  1.675e+00  1.145e+00  4.824e+00 -1.447e+00
## [1519]  9.121e+00  1.297e+00 -5.434e-04  6.982e+00  3.325e+00 -1.520e-01
## [1525]  5.501e+00 -1.138e-01 -4.105e+00  1.699e-01  5.087e-01  7.986e+00
## [1531]  3.698e+00 -4.900e+00  3.242e+00 -2.795e+00 -1.849e+01  6.103e-02
## [1537]  8.940e-01  7.929e+00  4.386e+00  2.931e+00  2.701e+00 -2.500e+00
## [1543]  3.523e-01  6.647e+00  6.814e+00 -2.412e+00  1.265e+00  2.868e+00
## [1549]  5.284e+00 -2.131e+00  1.592e+00 -5.401e+00  6.254e+00  3.913e-01
## [1555] -1.064e+00 -7.356e+00  5.370e+00 -1.552e+00  2.302e+00  5.107e-01
## [1561] -5.869e-02 -1.962e+00  7.855e+00  2.463e+00 -8.631e+00  7.302e+00
## [1567] -1.446e+00  1.423e+00  1.991e+01  9.226e-02 -6.674e+00  4.862e-01
## [1573] -6.422e-01  3.434e+00  1.281e+00  1.144e+00  3.477e-01  3.082e+00
## [1579]  3.416e+00  5.775e+00 -6.995e-01 -2.441e-01 -1.039e+00  1.057e+00
## [1585] -1.338e-02  1.196e-02 -3.774e-01 -4.116e-01 -1.012e+00  1.048e-01
## [1591]  9.576e-01 -6.289e-01 -4.350e-02  6.923e-02  1.974e-01  2.106e-01
## [1597] -6.221e-01  1.481e+00  1.400e-01 -5.792e-02  3.698e+00  8.158e-02
## [1603] -4.972e+00  1.143e+00  1.061e-01  2.784e-01  7.516e-01 -1.919e-01
## [1609]  5.767e-01  6.875e-01  4.270e-01  7.277e-02  1.261e+00 -3.057e-01
## [1615] -3.391e-01 -1.130e+00  8.192e-01 -1.908e-01 -4.773e-01 -6.085e-02
## [1621]  6.179e-01  1.946e+00 -1.871e-01 -1.975e+00 -4.464e-01 -1.296e-01
## [1627]  1.522e-01  1.193e+00  1.577e-02  6.994e-03  1.245e+00  9.166e+00
## [1633]  5.228e-02 -5.451e-02  4.143e-01 -3.999e-01  1.572e+00  2.876e-01
## [1639]  2.189e-01  4.935e-02 -6.794e-01 -2.533e-01 -7.507e+00 -9.942e-02
## [1645]  3.867e+00  1.492e-01 -2.680e+00 -3.942e-04 -2.333e+00 -7.124e-01
## [1651] -1.745e+00 -6.676e+00 -5.493e+00  1.531e+01 -8.919e+00 -6.968e+00
## [1657]  3.651e-01  2.658e+00 -6.964e-02  3.498e-02  6.414e-01 -2.059e+01
## [1663]  8.352e-01 -1.686e+01  2.212e+00  5.002e+00 -4.225e-01 -3.557e+00
## [1669]  2.037e+00 -2.910e+00 -2.383e+00  1.613e-01 -1.157e+01  1.057e+01
## [1675] -5.386e-01 -5.612e+00  3.065e+00  7.357e-01  3.147e+00  6.144e+00
## [1681]  3.845e+00  4.239e+00 -4.389e-01 -1.961e+01  9.159e+00  1.336e+00
## [1687]  2.051e+00 -4.590e+00 -2.905e-01  1.234e+01 -2.090e+00  2.095e+00
## [1693]  2.962e+00 -1.072e-01 -7.808e-01  1.589e+01 -2.417e-01  9.162e-02
## [1699]  6.064e-01 -1.824e+01  1.542e+01 -4.176e+00  6.312e-01 -2.042e+00
## [1705] -7.793e+00 -1.766e+00  8.083e+00 -8.506e-01 -2.141e+00 -5.148e+00
## [1711]  8.944e+00  2.159e-01 -2.994e+01 -9.883e+00 -4.498e+00 -3.983e-01
## [1717]  5.212e+00 -3.584e+00  6.459e-02  6.555e+00 -4.133e-01  1.347e-01
## [1723] -1.717e+00  5.080e+00  1.934e-01  3.483e-01 -2.814e-02 -5.811e-01
## [1729]  8.656e+00 -5.731e+00  1.627e-01 -4.153e+00  3.455e+00 -2.250e+00
## [1735]  4.517e-01 -4.115e+00  1.380e+00 -2.801e+00  3.216e+00  6.309e+00
## [1741]  4.657e+00 -4.847e-01 -1.608e+00  5.680e-02  1.451e+00 -1.128e+00
## [1747]  8.144e-01 -4.990e-01 -5.615e+00 -8.631e-02 -2.955e-03  3.383e+00
## [1753] -1.374e+00 -8.764e-01  4.177e+00  2.931e+00  7.741e+00  4.828e+00
## [1759] -1.082e+01  1.420e+00  1.874e+01  1.960e-01 -4.344e+00  3.365e+00
## [1765] -2.339e-01 -3.644e-02 -2.346e+00  1.165e+00  1.716e+01 -5.382e-01
## [1771] -3.525e-01  2.932e-03 -6.501e-01 -1.007e+00  4.926e+00 -5.487e-01
## [1777]  2.112e+00 -5.593e+00  5.455e+00 -5.739e+00 -2.066e+00  1.872e-01
## [1783] -7.527e-02 -1.728e+00  4.311e-02  4.629e+00 -1.275e+00  1.421e+00
## [1789]  3.109e+00  1.040e+00 -6.620e+00 -1.387e+01  9.513e+00  1.368e+00
## [1795] -8.491e+00 -2.580e+00  1.124e+00 -3.166e+00 -2.322e+00  3.112e+00
## [1801]  2.229e+00 -2.765e+00 -1.300e+01  2.163e+01 -1.239e+00  6.225e+00
## [1807] -1.720e+01  2.791e+00  1.786e+00  1.935e+01 -4.525e-01 -1.455e+00
## [1813] -7.225e+00  4.080e+00  2.462e+00 -5.093e-02 -2.046e-01  5.473e+00
## [1819] -1.081e+00 -2.354e+00 -9.507e+00 -9.170e+00  1.302e+00  4.351e+00
## [1825]  1.719e+01  2.246e-01 -4.868e+00  4.914e+00  3.621e+00 -3.986e+00
## [1831] -5.309e+00 -5.170e-01  7.075e+00 -8.716e-02  5.509e-01 -7.523e-01
## [1837]  1.183e+00  1.323e+01 -5.613e+00 -4.615e-01  1.049e+00 -1.861e-01
## [1843]  2.532e+00 -6.292e+00  3.089e+00  2.472e+01  2.510e+00  2.627e+00
## [1849]  2.090e+00 -1.988e+00  8.734e-02  1.341e+01  5.125e+00 -6.714e+00
## [1855] -2.672e-01  8.265e-03 -1.812e+00 -4.799e-01  3.458e+00 -1.768e+00
## [1861] -3.700e+01  3.122e+00 -2.797e-01 -7.989e+00 -2.369e+00  3.510e+00
## [1867] -1.229e+00 -1.074e-01  1.061e+00 -7.446e+00  1.169e+00  7.308e+00
## [1873]  4.137e+00  1.276e+00 -1.974e+00  1.406e+01  3.670e+00 -1.216e+01
## [1879] -3.543e+00 -2.242e+01  4.476e+00 -1.343e+00  8.352e-01  1.348e+00
## [1885] -3.483e+00  9.374e-01  1.838e+00 -1.220e+01 -4.643e+00 -1.490e+01
## [1891] -1.164e+01 -2.966e+00  2.394e+00  1.041e+01  3.274e+01 -5.136e+00
## [1897]  8.239e-02  6.757e-01  1.687e+01  8.297e-01  3.081e-01 -4.616e-01
## [1903] -6.442e+00  7.546e-02 -3.253e+00  4.391e-02  1.182e+01 -2.981e+00
## [1909] -7.599e+00  4.663e+00 -1.776e+01 -5.110e+00 -2.379e+00 -6.464e+00
## [1915] -7.791e+00  8.261e-01  7.751e+00  3.334e+00  1.826e+00 -3.308e+00
## [1921]  1.407e+00 -2.822e+00 -4.691e+00 -9.460e-01  1.480e+01  6.620e-01
## [1927] -1.799e+00 -1.362e+00 -2.689e+00 -4.233e+00 -1.268e+00 -1.733e+00
## [1933]  2.297e+01 -5.033e+00 -8.716e-03 -1.604e+00  6.700e-01 -3.976e+00
## [1939] -1.743e+01 -1.093e+00 -1.531e+01 -1.186e+01 -1.400e+00  1.855e+01
## [1945]  3.862e+00  1.764e-01 -1.253e+00  9.826e+00 -1.481e+00  5.025e-02
## [1951]  2.857e+00  3.838e+00 -1.054e+01  1.032e+00  1.478e+01  1.202e+00
## [1957] -1.789e-02 -2.084e+00  4.301e-01  1.161e+00  4.468e+00 -3.433e-01
## [1963]  4.076e-02 -7.649e+00  3.060e+01  1.126e+00 -4.606e+00 -7.042e+00
## [1969] -9.998e+00  1.682e+00 -2.340e+00 -1.149e+01  1.822e+00 -1.357e+01
## [1975] -1.113e+01 -5.849e+00  5.274e-03  1.416e+00  1.314e+00 -7.229e-01
## [1981]  1.699e+00  7.281e-01  9.430e-01 -3.481e+00 -6.878e+00  2.544e+01
## [1987]  1.248e+00 -1.562e-01  5.266e+00 -1.227e+00  1.847e+01 -2.344e+00
## [1993]  3.811e+00 -3.043e+00  8.392e+00  1.864e+00 -1.420e+01 -5.208e+00
## [1999] -1.172e+01 -1.249e+00 -1.962e+01  8.454e-01 -5.511e-01 -3.625e-01
## [2005]  7.327e-02  6.237e-01  1.806e+00  3.069e+00  2.393e+00 -2.522e-02
## [2011]  2.133e+00 -6.558e-01  1.135e+00 -1.037e+01 -4.090e-01 -1.537e+00
## [2017]  6.514e+00 -3.945e+00 -7.885e-02  3.313e-01 -9.796e-01  3.393e-02
## [2023] -2.936e-01  3.382e+00  1.527e+00 -2.079e+00  6.438e+00  5.355e+00
## [2029]  2.109e+00  8.457e-01 -1.014e+01 -5.495e+00  3.526e+00  5.126e+00
## [2035]  8.164e+00  1.136e+00 -1.253e-01  6.280e-02 -8.688e-01  1.391e-01
## [2041] -2.342e+00 -9.446e+00  1.784e+00 -1.974e+00  1.970e+00  2.778e+00
## [2047]  2.074e-01  3.198e+00 -1.517e+00 -8.614e-03 -3.834e+00 -1.587e+00
## [2053]  1.297e+01  1.338e+00 -6.643e+00  3.768e-01 -1.957e+00 -2.088e+00
## [2059] -2.605e+00  1.557e-02  8.463e-01  5.959e+00  7.573e-02 -7.189e+00
## [2065]  2.624e-02  7.220e-01  4.870e-01  6.409e+00  1.935e+00  5.392e-01
## [2071]  1.282e+00  3.794e-01  1.426e+00  5.778e+00  2.472e+00  7.864e-01
## [2077]  1.087e-03 -2.814e-02 -7.344e+00  6.833e-01  4.897e+00  9.851e+00
## [2083]  6.092e-01  6.158e+00  3.272e+00 -4.644e-02 -3.343e-02 -4.586e-01
## [2089]  1.428e+00 -3.376e+00  1.471e-01  6.846e-01 -7.224e-01  1.531e+00
## [2095]  2.956e+00  6.883e+00 -1.459e-01  3.571e-01  6.380e-01  4.874e-01
## [2101]  5.061e+00  6.377e-01 -1.434e-01  1.770e+00 -8.372e+00 -2.739e-01
## [2107]  1.813e-01  1.740e-01 -1.255e-01 -3.683e+00  1.235e-02  3.655e+00
## [2113]  6.014e-01  1.659e+00  1.091e+00  3.730e-01  8.500e-01  5.460e+00
## [2119]  1.153e+00 -1.906e+00  2.311e-01 -3.026e-01 -2.317e+00 -3.518e+00
## [2125] -1.213e-01  8.436e+00 -1.344e+00  9.799e-01 -1.686e-01 -2.957e+00
## [2131] -9.648e+00  1.366e+00 -6.316e+00 -2.742e+00  6.546e+00  5.325e+00
## [2137] -2.847e+00  2.207e+00  1.203e+01  6.759e-01  3.875e-01 -4.320e+00
## [2143]  2.237e-01  5.500e+00  2.778e-01  2.103e+00 -8.165e+00 -2.612e+00
## [2149] -3.729e-02 -1.691e+01  6.874e-01  1.822e+00  3.341e-02 -3.823e+00
## [2155]  1.880e+00 -3.462e-01 -3.933e-01  3.294e-01 -3.574e-01  4.680e-01
## [2161] -1.986e+00 -1.419e-02 -1.326e-01 -5.780e-03  2.548e+00 -2.114e+00
## [2167] -7.937e-01 -5.028e+00  2.178e-01 -4.970e+01  8.205e+00 -5.762e+00
## [2173] -2.562e-01 -1.447e+00 -7.457e-01 -4.340e-01  3.516e+00  5.096e-02
## [2179]  3.957e+00 -3.744e-02  1.236e-01  2.089e+00 -6.526e-01  3.246e-01
## [2185]  1.581e+00 -7.190e+00 -3.878e+00  4.814e+00  1.672e+00  1.641e-01
## [2191] -7.295e+00  2.087e+00  2.882e+00 -1.667e+01  1.010e+00  5.227e-01
## [2197]  1.335e+00  1.416e+00 -2.569e-03 -3.882e+00  4.383e-01  1.721e+00
## [2203] -5.532e-02 -2.374e+00  1.286e+00  2.784e+00 -1.244e+00  9.714e+00
## [2209]  4.649e-01  1.919e+00  1.589e+00 -2.986e-01  3.720e+00  1.000e+00
## [2215]  2.247e-02  1.642e-01  1.824e-01 -1.388e+00 -3.828e+00 -5.557e+00
## [2221]  2.283e+00  6.665e-01 -9.468e+00 -9.419e-02  1.270e+00  1.875e+00
## [2227] -6.918e-01  8.247e-02  1.450e+00 -1.076e+01 -8.628e-01 -1.582e+01
## [2233] -1.042e+01  3.209e+01  9.751e+00 -2.000e+00  4.289e+00  1.197e+01
## [2239]  1.177e+01  2.392e+00 -1.908e+01  3.521e+01  3.941e+01 -4.848e+00
```

```r
geocnty.fk$lmi.p <- local_cnty.mi[, 5]
summary(geocnty.fk$lmi.p)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.375   0.494   0.489   0.597   1.000
```

```r
summary(geocnty.fk$lmi)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  -64.20   -1.56    0.07    0.34    1.99   98.80
```

```r
summary(geocnty.fk$lmi.p)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.375   0.494   0.489   0.597   1.000
```

```r
# do we expect the p-value range from 0 to 1?
geozip.fk$lmi <- local_zip.mi[, 1]
geozip.fk$lmi.p <- local_zip.mi[, 5]
summary(geozip.fk$lmi)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  -61.30   -1.47    0.49    1.86    3.30  137.00
```

```r
summary(geozip.fk$lmi.p)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.297   0.466   0.452   0.590   1.000
```

```r

geocnty.fk@data$lmi.p.sig <- as.factor(ifelse(local_cnty.mi[, 5] < 0.001, "Sig p<.001", 
    ifelse(local_cnty.mi[, 5] < 0.05, "Sig p<.05", "NS")))
## 
geozip.fk@data$lmi.p.sig <- as.factor(ifelse(local_zip.mi[, 5] < 0.001, "Sig p<.001", 
    ifelse(local_zip.mi[, 5] < 0.05, "Sig p<.05", "NS")))
```



```r
spplot(geocnty.fk, "lmi", at = summary(geocnty.fk$lmi), col.regions = brewer.pal(5, 
    "RdBu"), main = "Local Moran's I")
```

![plot of chunk unnamed-chunk-20](figure/unnamed-chunk-201.png) 

```r
## 
spplot(geozip.fk, "lmi", at = summary(geozip.fk$lmi), col.regions = brewer.pal(5, 
    "RdBu"), main = "Local Moran's I")
```

![plot of chunk unnamed-chunk-20](figure/unnamed-chunk-202.png) 



```r
spplot(geocnty.fk, "lmi.p.sig", col.regions = c("white", "#E6550D", "#FDAE6B"))
```

![plot of chunk unnamed-chunk-21](figure/unnamed-chunk-211.png) 

```r
## 
spplot(geozip.fk, "lmi.p.sig", col.regions = c("white", "#E6550D", "#FDAE6B"))
```

![plot of chunk unnamed-chunk-21](figure/unnamed-chunk-212.png) 



```r
# identify the moran plot quadrant for each observation
geocnty.fk@data$quad_sig <- NA
geocnty.fk@data[(geocnty.fk$sFKmean > 0 & geocnty.fk$lag_sFKmean > 0) & (local_cnty.mi[, 
    5] <= 0.05), "quad_sig"] <- 1
geocnty.fk@data[(geocnty.fk$sFKmean < 0 & geocnty.fk$lag_sFKmean > 0) & (local_cnty.mi[, 
    5] <= 0.05), "quad_sig"] <- 2
geocnty.fk@data[(geocnty.fk$sFKmean < 0 & geocnty.fk$lag_sFKmean > 0) & (local_cnty.mi[, 
    5] <= 0.05), "quad_sig"] <- 3
geocnty.fk@data[(geocnty.fk$sFKmean > 0 & geocnty.fk$lag_sFKmean < 0) & (local_cnty.mi[, 
    5] <= 0.05), "quad_sig"] <- 4
geocnty.fk@data[(local_cnty.mi[, 5] > 0.05), "quad_sig"] <- 5

summary(geocnty.fk@data$quad_sig)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    1.00    5.00    5.00    4.92    5.00    5.00      63
```

```r
hist(geocnty.fk@data$quad_sig)
```

![plot of chunk unnamed-chunk-22](figure/unnamed-chunk-221.png) 

```r
hist(geocnty.fk@data$lmi.p)
```

![plot of chunk unnamed-chunk-22](figure/unnamed-chunk-222.png) 



```r
# identify the moran plot quadrant for each observation
geozip.fk@data$quad_sig <- NA
geozip.fk@data[(geozip.fk$sFKmean > 0 & geozip.fk$lag_sFKmean > 0) & (local_zip.mi[, 
    5] <= 0.05), "quad_sig"] <- 1
geozip.fk@data[(geozip.fk$sFKmean < 0 & geozip.fk$lag_sFKmean > 0) & (local_zip.mi[, 
    5] <= 0.05), "quad_sig"] <- 2
geozip.fk@data[(geozip.fk$sFKmean < 0 & geozip.fk$lag_sFKmean > 0) & (local_zip.mi[, 
    5] <= 0.05), "quad_sig"] <- 3
geozip.fk@data[(geozip.fk$sFKmean > 0 & geozip.fk$lag_sFKmean < 0) & (local_zip.mi[, 
    5] <= 0.05), "quad_sig"] <- 4
geozip.fk@data[(local_zip.mi[, 5] > 0.05), "quad_sig"] <- 5

summary(geozip.fk@data$quad_sig)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    1.00    5.00    5.00    4.85    5.00    5.00      50
```

```r
hist(geozip.fk@data$quad_sig)
```

![plot of chunk unnamed-chunk-23](figure/unnamed-chunk-231.png) 

```r
hist(geozip.fk@data$lmi.p)
```

![plot of chunk unnamed-chunk-23](figure/unnamed-chunk-232.png) 



```r
# Set the breaks for the thematic map classes
breaks <- seq(1, 5, 1)

# Set the corresponding labels for the thematic map classes
labels <- c("high-High", "low-Low", "High-Low", "Low-High", "Not Signif.")

# see ?findInterval - This is necessary for making a map
np <- findInterval(geocnty.fk$quad_sig, breaks)

# Assign colors to each map class
colors <- c("red", "blue", "lightpink", "skyblue2", "white")
# colors[np] manually sets the color for each county
plot(geocnty.fk, col = colors[np])
mtext("Local Moran's I", cex = 1.5, side = 3, line = 1)
legend("topleft", legend = labels, fill = colors, bty = "n")
```

![plot of chunk unnamed-chunk-24](figure/unnamed-chunk-24.png) 


<a href="https://www.flickr.com/photos/ronbumquist/13858621594" title="county_lisa by Richard Heimann, on Flickr"><img src="https://farm3.staticflickr.com/2857/13858621594_34841208e5.jpg" width="500" height="231" alt="county_lisa"></a>


```r
# Set the breaks for the thematic map classes
breaks2 <- seq(1, 5, 1)

# Set the corresponding labels for the thematic map classes
labels2 <- c("high-High", "low-Low", "High-Low", "Low-High", "Not Signif.")

# see ?findInterval - This is necessary for making a map
np2 <- findInterval(geozip.fk$quad_sig, breaks2)

# Assign colors to each map class
colors2 <- c("red", "blue", "lightpink", "skyblue2", "white")
# colors[np] manually sets the color for each county
plot(geozip.fk, col = colors2[np2])
mtext("Local Moran's I", cex = 1.5, side = 20, line = 1)
legend("topleft", legend = labels, fill = colors, bty = "n")
```

![plot of chunk unnamed-chunk-25](figure/unnamed-chunk-25.png) 


<a href="https://www.flickr.com/photos/ronbumquist/13858281443" title="zipcode_lisa by Richard Heimann, on Flickr"><img src="https://farm3.staticflickr.com/2883/13858281443_251c68438b.jpg" width="500" height="229" alt="zipcode_lisa"></a>
