# GES 673 Cleaning your Data  #
### by Richard Heimann (ref: David Springate @datajujitsu) ###

##### The .Rmd source and data for this tutorial can be found [here](https://github.com/rheimann/UMBC/tree/master/beginners)
##### more info:http://cran.r-project.org/doc/contrib/de_Jonge+van_der_Loo-Introduction_to_data_cleaning_with_R.pdf
========================================================

--------------------

## Session outline

* Why is it important to clean data? 
* What types of errors exist? 
* How R can be used to clean your data. 
* Subsetting operators in R
* Subsetting vectors in R
* Subsetting Dataframes in R
* Using subsetting to alter your data in R
* Building a data-cleaning script in R
* Problems

-------------------------

## Why not just use ArcGIS or Excel?

Excel and ArcGIS is _ok_, __BUT__ 

* Not scriptable
* Point and click - Has no way of tracking workflow /bad for learning/bad for teaching/!
* Not very good for large datasets - recall that there are going to be social media sources that will not open in either. 
* Alters the data in place - No long-term undo

Most of the time doing statistics is actually spent cleaning data.

Research and data analysis is often about reproduction and repreatability. You want to be able to do this in a trackable and reproducable way!

----------------------------

## A typical workflow

1. Write out research question.
2. Define Design.
3. Choose variables and determine measurement.
4. Clean Data / Create New Variables.
  a. Load our data. 
  b. Visualize the data.
  c. Do some statistics (e.g. smooth, rough, point estimates, intervals, etc).
  d. Clean data in R or ArcGIS, update data cleaning script.
  e. Visualize your data. 
  f. Realize your data is still dirty and start again. 
  g. Finally save your clean data and move to subsequent steps.
5.Univariate and Multivariate Statistics (EDA/ESDA)
6. Run Initial Model
7. Diagnostics | Check assumptions 
8. Refine Model
9. Interpret Results.
10. Present results in an intuitive manner. 

R and scripting allows you to rinse and repeat much easier.

-----------------------------

## Subsetting your data

This is to select the specific sections of your dataset to be cleaned/edited/transformed

This is a crucial part of most aspects of R programing, not just cleaning data.

R is _very_ flexible! There are many different ways to do the same thing... This can cause confusion!
    
### 3 basic subsetting operators:

* `[` selects  an element or a range of elements 
* `$` selects an element by name in a dataframe / list
* `[[` selects an element by reference / subsets a list (a more advanced data type!) / strips names from vector (!). We will ignore this for now!


Subsetting is easier to understand for 1d vectors first

We will look at these before generalising to dataframes. 

Start by building a vector of random numbers:


```r
set.seed(12345) # for reproducability!
x <- rnorm(50) # 50 random numbers from a normal distribution (mean = 0, sd = 1)
names(x) <- paste0("n", 1:50) # name each element of the vector
x
```

```
##      n1      n2      n3      n4      n5      n6      n7      n8      n9 
##  0.5855  0.7095 -0.1093 -0.4535  0.6059 -1.8180  0.6301 -0.2762 -0.2842 
##     n10     n11     n12     n13     n14     n15     n16     n17     n18 
## -0.9193 -0.1162  1.8173  0.3706  0.5202 -0.7505  0.8169 -0.8864 -0.3316 
##     n19     n20     n21     n22     n23     n24     n25     n26     n27 
##  1.1207  0.2987  0.7796  1.4558 -0.6443 -1.5531 -1.5977  1.8051 -0.4816 
##     n28     n29     n30     n31     n32     n33     n34     n35     n36 
##  0.6204  0.6121 -0.1623  0.8119  2.1968  2.0492  1.6324  0.2543  0.4912 
##     n37     n38     n39     n40     n41     n42     n43     n44     n45 
## -0.3241 -1.6621  1.7677  0.0258  1.1285 -2.3804 -1.0603  0.9371  0.8545 
##     n46     n47     n48     n49     n50 
##  1.4607 -1.4131  0.5674  0.5832 -1.3068
```


### Using the `[` operator:

#### Selecting items by name:


```r
x["n1"] # single item
```

```
##     n1 
## 0.5855
```

```r
x[c("n1", "n7", "n40")] # several items using a vector of names
```

```
##     n1     n7    n40 
## 0.5855 0.6301 0.0258
```


#### Selecting by index:


```r
x[] # Blank selects everything - this will be useful later!
```

```
##      n1      n2      n3      n4      n5      n6      n7      n8      n9 
##  0.5855  0.7095 -0.1093 -0.4535  0.6059 -1.8180  0.6301 -0.2762 -0.2842 
##     n10     n11     n12     n13     n14     n15     n16     n17     n18 
## -0.9193 -0.1162  1.8173  0.3706  0.5202 -0.7505  0.8169 -0.8864 -0.3316 
##     n19     n20     n21     n22     n23     n24     n25     n26     n27 
##  1.1207  0.2987  0.7796  1.4558 -0.6443 -1.5531 -1.5977  1.8051 -0.4816 
##     n28     n29     n30     n31     n32     n33     n34     n35     n36 
##  0.6204  0.6121 -0.1623  0.8119  2.1968  2.0492  1.6324  0.2543  0.4912 
##     n37     n38     n39     n40     n41     n42     n43     n44     n45 
## -0.3241 -1.6621  1.7677  0.0258  1.1285 -2.3804 -1.0603  0.9371  0.8545 
##     n46     n47     n48     n49     n50 
##  1.4607 -1.4131  0.5674  0.5832 -1.3068
```

```r
x[42] # single item
```

```
##   n42 
## -2.38
```

```r
x[length(x)] # can use functions!
```

```
##    n50 
## -1.307
```

```r
x[10:20] # Select a range of indices:
```

```
##     n10     n11     n12     n13     n14     n15     n16     n17     n18 
## -0.9193 -0.1162  1.8173  0.3706  0.5202 -0.7505  0.8169 -0.8864 -0.3316 
##     n19     n20 
##  1.1207  0.2987
```

```r
x[c(2,4,6,8,10)] # Select by a vector of indices
```

```
##      n2      n4      n6      n8     n10 
##  0.7095 -0.4535 -1.8180 -0.2762 -0.9193
```

```r
x[-c(1:10)] # returns everything but the negative indices
```

```
##     n11     n12     n13     n14     n15     n16     n17     n18     n19 
## -0.1162  1.8173  0.3706  0.5202 -0.7505  0.8169 -0.8864 -0.3316  1.1207 
##     n20     n21     n22     n23     n24     n25     n26     n27     n28 
##  0.2987  0.7796  1.4558 -0.6443 -1.5531 -1.5977  1.8051 -0.4816  0.6204 
##     n29     n30     n31     n32     n33     n34     n35     n36     n37 
##  0.6121 -0.1623  0.8119  2.1968  2.0492  1.6324  0.2543  0.4912 -0.3241 
##     n38     n39     n40     n41     n42     n43     n44     n45     n46 
## -1.6621  1.7677  0.0258  1.1285 -2.3804 -1.0603  0.9371  0.8545  1.4607 
##     n47     n48     n49     n50 
## -1.4131  0.5674  0.5832 -1.3068
```


#### Selecting by predicate (logical vector)

Returns all elements where the corresponding logical value is TRUE

Remember week 1:


```r
# Logical operators (predicates) return TRUE/FALSE
1 == 2
```

```
## [1] FALSE
```


When applied to a numeric vector, logical operators build vectors of TRUE/FALSE values (The same length as the input vector):

e.g.


```r
x >= 1.96
```

```
##    n1    n2    n3    n4    n5    n6    n7    n8    n9   n10   n11   n12 
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##   n13   n14   n15   n16   n17   n18   n19   n20   n21   n22   n23   n24 
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##   n25   n26   n27   n28   n29   n30   n31   n32   n33   n34   n35   n36 
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE 
##   n37   n38   n39   n40   n41   n42   n43   n44   n45   n46   n47   n48 
## FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 
##   n49   n50 
## FALSE FALSE
```


### Why is 1.96 selected? Recall our discussions on what may constitute an error or outlier.
### HINT: 
<a href="http://upload.wikimedia.org/wikipedia/en/b/bf/NormalDist1.96" title="zipcode_lisa by Richard Heimann, on Flickr"><img src="http://upload.wikimedia.org/wikipedia/en/b/bf/NormalDist1.96.png" width="500" height="229" alt="zipcode_lisa"></a>

... so you can also subset by these:


```r
x[x >= 1.96]
```

```
##   n32   n33 
## 2.197 2.049
```

```r
x[x <= -1.96]
```

```
##   n42 
## -2.38
```

```r
x[x >= 1.96 | x <= -1.96] # can be as complicated as you like
```

```
##    n32    n33    n42 
##  2.197  2.049 -2.380
```


Of course, each returned subset can be assigned to a new symbol. This can be considered a feature selection of sorts. We may seek out only certain values or certain observations in our study area. In lab 1 & 2 we performed several spatial feature selections and reinforced feature selection during our reading in the Geospatial Analysis Workbook. This is easier to do in R and ArcGIS than in Geoda. 


```r
y <- x[x > 0 & x < 2]
y
```

```
##     n1     n2     n5     n7    n12    n13    n14    n16    n19    n20 
## 0.5855 0.7095 0.6059 0.6301 1.8173 0.3706 0.5202 0.8169 1.1207 0.2987 
##    n21    n22    n26    n28    n29    n31    n34    n35    n36    n39 
## 0.7796 1.4558 1.8051 0.6204 0.6121 0.8119 1.6324 0.2543 0.4912 1.7677 
##    n40    n41    n44    n45    n46    n48    n49 
## 0.0258 1.1285 0.9371 0.8545 1.4607 0.5674 0.5832
```


------------------------------------

## Subsetting data frames 

The principle is the same, but it is more complicated because dataframes have 2 dimensions (rows and columns). Dataframes are what you are used to working with in most GIS systems akin to a shapefile so this should mitigate matters. 

Now we use two subsetting expressions [first rows, then columns] separated by a comma.

We will be using a version of Fisher's Iris data that I have mangled!

You can get the original data by calling `data(iris)`


```r
# original data 
# data(iris)
# data located in the UMBC Github repo "beginners"
iris <- read.csv("/Users/heimannrichard/Documents/github/UMBC/beginners/iris_mangled.csv")
# If you make a mistake, just call this again to get you back to the start!
```


With dataframes, you can also use the $ operator to select columns:


```r
iris$Sepal.Length
```

```
##   [1] 5.1 4.9 4.7 4.6 5.0 5.4 4.6 5.0 4.4 4.9 5.4 4.8 4.8 4.3 5.8 5.7 5.4
##  [18] 5.1 5.7 5.1 5.4 5.1 4.6 5.1 4.8 5.0 5.0 5.2 5.2 4.7 4.8 5.4 5.2 5.5
##  [35] 4.9 5.0 5.5 4.9 4.4 5.1 5.0 4.5 4.4 5.0 5.1 4.8 5.1 4.6 5.3 5.0 7.0
##  [52] 6.4 6.9 5.5 6.5 5.7 6.3 4.9 6.6 5.2 5.0 5.9  NA 6.1 5.6 6.7 5.6 5.8
##  [69] 6.2 5.6 5.9 6.1 6.3 6.1 6.4 6.6 6.8 6.7 6.0 5.7 5.5 5.5 5.8 6.0 5.4
##  [86] 6.0 6.7 6.3 5.6 5.5 5.5 6.1 5.8 5.0 5.6 5.7 5.7 6.2 5.1 5.7 6.3 5.8
## [103] 7.1  NA 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7 7.7
## [120] 6.0 6.9 5.6 7.7 6.3 6.7 7.2 6.2 6.1 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7
## [137] 6.3 6.4 6.0 6.9 6.7 6.9 5.8 6.8 6.7 6.7 6.3 6.5 6.2 5.9
```

```r
iris$Petal.Length
```

```
##   [1] 1.400 1.400 1.300 1.500 1.400 1.700 1.400 1.500 1.400 1.500 1.500
##  [12] 1.600 1.400 1.100 1.200 1.500 1.300 1.400 1.700 1.500 1.700 1.500
##  [23] 1.000 1.700 1.900 1.600 1.600 1.500 1.400 1.600 1.600 1.500 1.500
##  [34] 1.400 1.500 1.200 1.300 1.400 1.300 1.500 1.300 1.300 1.300 1.600
##  [45] 1.900 1.400 1.600 1.400 1.500 1.400 0.047 0.045 0.049 0.040 0.046
##  [56] 0.045 0.047 0.033 0.046 0.039 0.035 0.042 0.040 0.047 0.036 0.044
##  [67] 0.045 0.041 0.045 0.039 0.048 0.040 0.049 0.047 0.043 0.044 0.048
##  [78] 0.050 0.045 0.035 0.038 0.037 0.039 0.051 0.045 0.045 0.047 0.044
##  [89] 0.041 0.040 0.044 0.046 0.040 0.033 0.042 0.042 0.042 0.043 0.030
## [100] 0.041 6.000 5.100 5.900 5.600 5.800 6.600 4.500 6.300 5.800 6.100
## [111] 5.100 5.300 5.500 5.000 5.100 5.300 5.500 6.700 6.900 5.000 5.700
## [122] 4.900 6.700 4.900 5.700 6.000 4.800 4.900 5.600 5.800 6.100 6.400
## [133] 5.600 5.100 5.600 6.100 5.600 5.500 4.800 5.400 5.600 5.100 5.100
## [144] 5.900 5.700 5.200 5.000 5.200 5.400 5.100
```


Just as you might do in ArcGIS or Excel you can quickly and easily explore your data to get a sense of the nature of the data. 


```r
summary(iris)
```

```
##   Sepal.Length   Sepal.Width    Petal.Length    Petal.Width 
##  Min.   :4.30   Min.   :2.00   Min.   :0.030   Min.   :0.1  
##  1st Qu.:5.10   1st Qu.:2.80   1st Qu.:0.046   1st Qu.:0.3  
##  Median :5.80   Median :3.00   Median :1.500   Median :1.3  
##  Mean   :5.84   Mean   :3.09   Mean   :2.352   Mean   :1.2  
##  3rd Qu.:6.40   3rd Qu.:3.30   3rd Qu.:5.100   3rd Qu.:1.8  
##  Max.   :7.90   Max.   :9.30   Max.   :6.900   Max.   :2.5  
##  NA's   :2                                                  
##        Species   petal.Breadth
##  setosa    :50   Min.   :0.1  
##  versicolor:50   1st Qu.:0.3  
##  virginica :50   Median :1.3  
##                  Mean   :1.2  
##                  3rd Qu.:1.8  
##                  Max.   :2.5  
## 
```

```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species petal.Breadth
## 1          5.1         3.5          1.4         0.2  setosa           0.2
## 2          4.9         3.0          1.4         0.2  setosa           0.2
## 3          4.7         3.2          1.3         0.2  setosa           0.2
## 4          4.6         3.1          1.5         0.2  setosa           0.2
## 5          5.0         3.6          1.4         0.2  setosa           0.2
## 6          5.4         9.3          1.7         0.4  setosa           0.4
```

```r
names(iris)
```

```
## [1] "Sepal.Length"  "Sepal.Width"   "Petal.Length"  "Petal.Width"  
## [5] "Species"       "petal.Breadth"
```

```r
str(iris)
```

```
## 'data.frame':	150 obs. of  6 variables:
##  $ Sepal.Length : num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
##  $ Sepal.Width  : num  3.5 3 3.2 3.1 3.6 9.3 3.4 3.4 2.9 3.1 ...
##  $ Petal.Length : num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
##  $ Petal.Width  : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
##  $ Species      : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ petal.Breadth: num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
```



```r
# view is also nice as it puts the output into a table like view. due to limitations in R markdown however this will not be executed. 
View(iris)
View(head(iris))
View(tail(iris))
```



Also useful for exploring your data is the pairs function

This builds a matrix of scatter plots for all pairs of variables in your data


```r
pairs(iris) 
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 


## What needs to be done based on this scatterplot? 

----------------------
----------------------
----------------------
----------------------

Looking at this plot, what needs to be done?

1. Species factor complicates things, lets remove it.
2. Petal.Width and Petal.Breadth are perfectly correlated - remove the duplicate Petal.Breadth
3. Missing values (NA) in Sepal.Length - remove missing data rows
4. Petal lengths recorded on the wrong scale (metres rather than centimetres!) - transform back to cm
5. Outlier in Sepal.Width - correct this error

----------------------
## 1. Species factor complicates things, lets remove it. 


```r
pairs(iris[,-5]) # blank before the comma selects all rows, -5 after the comma removes column #5
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 


----------------------

## 2. Petal.Width and Petal.Breadth are perfectly correlated - remove the duplicate Petal.Breadth -- Removing a column 

You can remove a whole column by assigning NULL to it:


```r
dim(iris)
```

```
## [1] 150   6
```

```r
iris$petal.Breadth <- NULL
dim(iris)
```

```
## [1] 150   5
```


---------------------

## 3. Missing values (NA) in Sepal.Length -- remove missing data rows -- Removing missing values 

You can do this using logical vectors:

Remember that you must explicitly reassign the data (iris <- iris[...])

## What kind of deletion is this called? 


```r
dim(iris)
```

```
## [1] 150   5
```

```r
iris[!is.na(iris$Sepal.Length),] # returns the correct data, but leaves the original unchanged
```

```
##     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
## 1            5.1         3.5        1.400         0.2     setosa
## 2            4.9         3.0        1.400         0.2     setosa
## 3            4.7         3.2        1.300         0.2     setosa
## 4            4.6         3.1        1.500         0.2     setosa
## 5            5.0         3.6        1.400         0.2     setosa
## 6            5.4         9.3        1.700         0.4     setosa
## 7            4.6         3.4        1.400         0.3     setosa
## 8            5.0         3.4        1.500         0.2     setosa
## 9            4.4         2.9        1.400         0.2     setosa
## 10           4.9         3.1        1.500         0.1     setosa
## 11           5.4         3.7        1.500         0.2     setosa
## 12           4.8         3.4        1.600         0.2     setosa
## 13           4.8         3.0        1.400         0.1     setosa
## 14           4.3         3.0        1.100         0.1     setosa
## 15           5.8         4.0        1.200         0.2     setosa
## 16           5.7         4.4        1.500         0.4     setosa
## 17           5.4         3.9        1.300         0.4     setosa
## 18           5.1         3.5        1.400         0.3     setosa
## 19           5.7         3.8        1.700         0.3     setosa
## 20           5.1         3.8        1.500         0.3     setosa
## 21           5.4         3.4        1.700         0.2     setosa
## 22           5.1         3.7        1.500         0.4     setosa
## 23           4.6         3.6        1.000         0.2     setosa
## 24           5.1         3.3        1.700         0.5     setosa
## 25           4.8         3.4        1.900         0.2     setosa
## 26           5.0         3.0        1.600         0.2     setosa
## 27           5.0         3.4        1.600         0.4     setosa
## 28           5.2         3.5        1.500         0.2     setosa
## 29           5.2         3.4        1.400         0.2     setosa
## 30           4.7         3.2        1.600         0.2     setosa
## 31           4.8         3.1        1.600         0.2     setosa
## 32           5.4         3.4        1.500         0.4     setosa
## 33           5.2         4.1        1.500         0.1     setosa
## 34           5.5         4.2        1.400         0.2     setosa
## 35           4.9         3.1        1.500         0.2     setosa
## 36           5.0         3.2        1.200         0.2     setosa
## 37           5.5         3.5        1.300         0.2     setosa
## 38           4.9         3.6        1.400         0.1     setosa
## 39           4.4         3.0        1.300         0.2     setosa
## 40           5.1         3.4        1.500         0.2     setosa
## 41           5.0         3.5        1.300         0.3     setosa
## 42           4.5         2.3        1.300         0.3     setosa
## 43           4.4         3.2        1.300         0.2     setosa
## 44           5.0         3.5        1.600         0.6     setosa
## 45           5.1         3.8        1.900         0.4     setosa
## 46           4.8         3.0        1.400         0.3     setosa
## 47           5.1         3.8        1.600         0.2     setosa
## 48           4.6         3.2        1.400         0.2     setosa
## 49           5.3         3.7        1.500         0.2     setosa
## 50           5.0         3.3        1.400         0.2     setosa
## 51           7.0         3.2        0.047         1.4 versicolor
## 52           6.4         3.2        0.045         1.5 versicolor
## 53           6.9         3.1        0.049         1.5 versicolor
## 54           5.5         2.3        0.040         1.3 versicolor
## 55           6.5         2.8        0.046         1.5 versicolor
## 56           5.7         2.8        0.045         1.3 versicolor
## 57           6.3         3.3        0.047         1.6 versicolor
## 58           4.9         2.4        0.033         1.0 versicolor
## 59           6.6         2.9        0.046         1.3 versicolor
## 60           5.2         2.7        0.039         1.4 versicolor
## 61           5.0         2.0        0.035         1.0 versicolor
## 62           5.9         3.0        0.042         1.5 versicolor
## 64           6.1         2.9        0.047         1.4 versicolor
## 65           5.6         2.9        0.036         1.3 versicolor
## 66           6.7         3.1        0.044         1.4 versicolor
## 67           5.6         3.0        0.045         1.5 versicolor
## 68           5.8         2.7        0.041         1.0 versicolor
## 69           6.2         2.2        0.045         1.5 versicolor
## 70           5.6         2.5        0.039         1.1 versicolor
## 71           5.9         3.2        0.048         1.8 versicolor
## 72           6.1         2.8        0.040         1.3 versicolor
## 73           6.3         2.5        0.049         1.5 versicolor
## 74           6.1         2.8        0.047         1.2 versicolor
## 75           6.4         2.9        0.043         1.3 versicolor
## 76           6.6         3.0        0.044         1.4 versicolor
## 77           6.8         2.8        0.048         1.4 versicolor
## 78           6.7         3.0        0.050         1.7 versicolor
## 79           6.0         2.9        0.045         1.5 versicolor
## 80           5.7         2.6        0.035         1.0 versicolor
## 81           5.5         2.4        0.038         1.1 versicolor
## 82           5.5         2.4        0.037         1.0 versicolor
## 83           5.8         2.7        0.039         1.2 versicolor
## 84           6.0         2.7        0.051         1.6 versicolor
## 85           5.4         3.0        0.045         1.5 versicolor
## 86           6.0         3.4        0.045         1.6 versicolor
## 87           6.7         3.1        0.047         1.5 versicolor
## 88           6.3         2.3        0.044         1.3 versicolor
## 89           5.6         3.0        0.041         1.3 versicolor
## 90           5.5         2.5        0.040         1.3 versicolor
## 91           5.5         2.6        0.044         1.2 versicolor
## 92           6.1         3.0        0.046         1.4 versicolor
## 93           5.8         2.6        0.040         1.2 versicolor
## 94           5.0         2.3        0.033         1.0 versicolor
## 95           5.6         2.7        0.042         1.3 versicolor
## 96           5.7         3.0        0.042         1.2 versicolor
## 97           5.7         2.9        0.042         1.3 versicolor
## 98           6.2         2.9        0.043         1.3 versicolor
## 99           5.1         2.5        0.030         1.1 versicolor
## 100          5.7         2.8        0.041         1.3 versicolor
## 101          6.3         3.3        6.000         2.5  virginica
## 102          5.8         2.7        5.100         1.9  virginica
## 103          7.1         3.0        5.900         2.1  virginica
## 105          6.5         3.0        5.800         2.2  virginica
## 106          7.6         3.0        6.600         2.1  virginica
## 107          4.9         2.5        4.500         1.7  virginica
## 108          7.3         2.9        6.300         1.8  virginica
## 109          6.7         2.5        5.800         1.8  virginica
## 110          7.2         3.6        6.100         2.5  virginica
## 111          6.5         3.2        5.100         2.0  virginica
## 112          6.4         2.7        5.300         1.9  virginica
## 113          6.8         3.0        5.500         2.1  virginica
## 114          5.7         2.5        5.000         2.0  virginica
## 115          5.8         2.8        5.100         2.4  virginica
## 116          6.4         3.2        5.300         2.3  virginica
## 117          6.5         3.0        5.500         1.8  virginica
## 118          7.7         3.8        6.700         2.2  virginica
## 119          7.7         2.6        6.900         2.3  virginica
## 120          6.0         2.2        5.000         1.5  virginica
## 121          6.9         3.2        5.700         2.3  virginica
## 122          5.6         2.8        4.900         2.0  virginica
## 123          7.7         2.8        6.700         2.0  virginica
## 124          6.3         2.7        4.900         1.8  virginica
## 125          6.7         3.3        5.700         2.1  virginica
## 126          7.2         3.2        6.000         1.8  virginica
## 127          6.2         2.8        4.800         1.8  virginica
## 128          6.1         3.0        4.900         1.8  virginica
## 129          6.4         2.8        5.600         2.1  virginica
## 130          7.2         3.0        5.800         1.6  virginica
## 131          7.4         2.8        6.100         1.9  virginica
## 132          7.9         3.8        6.400         2.0  virginica
## 133          6.4         2.8        5.600         2.2  virginica
## 134          6.3         2.8        5.100         1.5  virginica
## 135          6.1         2.6        5.600         1.4  virginica
## 136          7.7         3.0        6.100         2.3  virginica
## 137          6.3         3.4        5.600         2.4  virginica
## 138          6.4         3.1        5.500         1.8  virginica
## 139          6.0         3.0        4.800         1.8  virginica
## 140          6.9         3.1        5.400         2.1  virginica
## 141          6.7         3.1        5.600         2.4  virginica
## 142          6.9         3.1        5.100         2.3  virginica
## 143          5.8         2.7        5.100         1.9  virginica
## 144          6.8         3.2        5.900         2.3  virginica
## 145          6.7         3.3        5.700         2.5  virginica
## 146          6.7         3.0        5.200         2.3  virginica
## 147          6.3         2.5        5.000         1.9  virginica
## 148          6.5         3.0        5.200         2.0  virginica
## 149          6.2         3.4        5.400         2.3  virginica
## 150          5.9         3.0        5.100         1.8  virginica
```

```r
iris$Sepal.Length # Still see NA's
```

```
##   [1] 5.1 4.9 4.7 4.6 5.0 5.4 4.6 5.0 4.4 4.9 5.4 4.8 4.8 4.3 5.8 5.7 5.4
##  [18] 5.1 5.7 5.1 5.4 5.1 4.6 5.1 4.8 5.0 5.0 5.2 5.2 4.7 4.8 5.4 5.2 5.5
##  [35] 4.9 5.0 5.5 4.9 4.4 5.1 5.0 4.5 4.4 5.0 5.1 4.8 5.1 4.6 5.3 5.0 7.0
##  [52] 6.4 6.9 5.5 6.5 5.7 6.3 4.9 6.6 5.2 5.0 5.9  NA 6.1 5.6 6.7 5.6 5.8
##  [69] 6.2 5.6 5.9 6.1 6.3 6.1 6.4 6.6 6.8 6.7 6.0 5.7 5.5 5.5 5.8 6.0 5.4
##  [86] 6.0 6.7 6.3 5.6 5.5 5.5 6.1 5.8 5.0 5.6 5.7 5.7 6.2 5.1 5.7 6.3 5.8
## [103] 7.1  NA 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7 7.7
## [120] 6.0 6.9 5.6 7.7 6.3 6.7 7.2 6.2 6.1 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7
## [137] 6.3 6.4 6.0 6.9 6.7 6.9 5.8 6.8 6.7 6.7 6.3 6.5 6.2 5.9
```

```r

iris <- iris[!is.na(iris$Sepal.Length),] # reassigns the altered data back to iris
# iris <- iris[complete.cases(iris$Sepal.Length),] # also works
iris$Sepal.Length # no missing data now
```

```
##   [1] 5.1 4.9 4.7 4.6 5.0 5.4 4.6 5.0 4.4 4.9 5.4 4.8 4.8 4.3 5.8 5.7 5.4
##  [18] 5.1 5.7 5.1 5.4 5.1 4.6 5.1 4.8 5.0 5.0 5.2 5.2 4.7 4.8 5.4 5.2 5.5
##  [35] 4.9 5.0 5.5 4.9 4.4 5.1 5.0 4.5 4.4 5.0 5.1 4.8 5.1 4.6 5.3 5.0 7.0
##  [52] 6.4 6.9 5.5 6.5 5.7 6.3 4.9 6.6 5.2 5.0 5.9 6.1 5.6 6.7 5.6 5.8 6.2
##  [69] 5.6 5.9 6.1 6.3 6.1 6.4 6.6 6.8 6.7 6.0 5.7 5.5 5.5 5.8 6.0 5.4 6.0
##  [86] 6.7 6.3 5.6 5.5 5.5 6.1 5.8 5.0 5.6 5.7 5.7 6.2 5.1 5.7 6.3 5.8 7.1
## [103] 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7 7.7 6.0 6.9
## [120] 5.6 7.7 6.3 6.7 7.2 6.2 6.1 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7 6.3 6.4
## [137] 6.0 6.9 6.7 6.9 5.8 6.8 6.7 6.7 6.3 6.5 6.2 5.9
```

```r
dim(iris)
```

```
## [1] 148   5
```


## 4. Petal lengths recorded on the wrong scale (metres rather than centimetres!) - transform back to cm -- Transforming a whole column

Remember: Use the tab key to auto-complete variable names!

Assign the changed vector to the original column

Note that we are using vectors so no commas!


```r
# transform Petal length to cm
iris$Petal.Length[iris$Species == "versicolor"] <- iris$Petal.Length[iris$Species == "versicolor"] * 100
pairs(iris[,-5]) 
```

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-16.png) 


Geoda Variable Calculation
<a href="https://www.flickr.com/photos/ronbumquist/13913888343" title="geoda_calc by Richard Heimann, on Flickr"><img src="https://farm8.staticflickr.com/7332/13913888343_64aee26693.jpg" width="500" height="235" alt="geoda_calc"></a>

Arcgis Field Calculator
<a href="https://www.flickr.com/photos/ronbumquist/13890718296" title="arcgis_field calculator by Richard Heimann, on Flickr"><img src="https://farm3.staticflickr.com/2821/13890718296_8331e566d9.jpg" width="296" height="282" alt="arcgis_field calculator"></a>


------------------------------

## 5. Outlier in Sepal.Width - correct this error -- Changing a single data point

The 6th Sepal.Width value is a large outlier...

Looking at the original data recording sheet, you might see that the digits in the 6th Sepal.Width value were transposed...

Fix this:


```r
# max returns the max value in this case for Sepal.Width
max(iris$Sepal.Width)
```

```
## [1] 9.3
```

```r
iris$Sepal.Width[6]
```

```
## [1] 9.3
```

```r
iris$Sepal.Width[6] <- 3.9
pairs(iris[,-5]) 
```

![plot of chunk unnamed-chunk-17](figure/unnamed-chunk-17.png) 

```r
iris$Sepal.Width[6]
```

```
## [1] 3.9
```

```r
# FIXED!! 
```


__Your data is now cleaned and ready for analysis!__

----------------------------------

## Tip: Make a data cleaning script

1. If using R - it is good practice to separate out your cleaning and analysis scripts. 
2. It is good practice to save your object and save to a new CSV. 
3. If using ArcGIS to save a copy of your data to preserve integrity. 

e.g. get_data.R:


```r
iris <- read.csv("~/Dropbox/tutorials/subsetting/iris_mangled.csv")
iris$petal.Breadth <- NULL
iris <- iris[!is.na(iris$Sepal.Length),] 
iris$Petal.Length[iris$Species == "versicolor"] <- iris$Petal.Length[iris$Species == "versicolor"] * 100
iris$Sepal.Width[6] <- 3.9
```


---------------------

# PROBLEMS

Have a go at the following to test your understanding:

## 1. What do the following commands do?

You may need to search the help file and run the code within the brackets separately to work them out

### 1a.


```r
iris1 <- iris[sample(nrow(iris), replace = TRUE),] 
```


### 1b.


```r
iris2 <- iris[order(iris$Species, iris$Sepal.Width),]
```


### 1c. 


```r
mynames <- names(iris)[c(1:2, 5)]
iris3 <- iris[, mynames]
```


### 1d. 


```r
iris3$Long.Petals <- "no"
iris3$Long.Petals[iris3$Petal.Length >= median(iris3$Petal.Length)]  <- "yes"
```


## 2. Write commands to do the following tasks:

### 2a. 

_Create a dataset, `iris4`, with all data for species setosa with petals longer than 3 cm_

### 2b. 

_Create a vector, `z`, of setosa Sepal widths_

### 2c. 

_Create a dataset, `iris5`, where all continuous variables are log transformed_

note the `cbind()` and `log()` functions could be handy!
