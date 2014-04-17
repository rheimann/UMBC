
# Subsetting in R: Spring cleaning your data 
## Manchester FLS R User group April 2013
### David Springate
#### @datajujitsu
##### The .Rmd source and data for this tutorial can be found [here](https://github.com/DASpringate/tutorials)

--------------------

## Session outline

* Why use R for cleaning data?
* Subsetting operators
* Subsetting vectors
* Subsetting Dataframes
* Using subsetting to alter your data
* Building a data-cleaning script
* Problems

-------------------------

## Why not just use Excel?

Excel is _ok_, __BUT__ 

* Not scriptable
* Point and click - Has no way of tracking workflow
* Rubbish for large datasets
* Alters the data in place - No long-term undo

Most of the time doing statistics is actually spent cleaning data.

You want to be able to do this in a trackable and reproducable way!

----------------------------

## A typical R workflow

1. Do your experiment
2. Enter your data in Excel
3. Save as .csv
4. Clean data in R, update data cleaning script
5. Do some stats
6. Realise data is still really dirty
7. Go to 4

Once you have entered your original data, this remains fixed.

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


... so you can also subset by these:


```r
x[x >= 1.96]
```

```
##   n32   n33 
## 2.197 2.049
```

```r
x[x < 1]
```

```
##      n1      n2      n3      n4      n5      n6      n7      n8      n9 
##  0.5855  0.7095 -0.1093 -0.4535  0.6059 -1.8180  0.6301 -0.2762 -0.2842 
##     n10     n11     n13     n14     n15     n16     n17     n18     n20 
## -0.9193 -0.1162  0.3706  0.5202 -0.7505  0.8169 -0.8864 -0.3316  0.2987 
##     n21     n23     n24     n25     n27     n28     n29     n30     n31 
##  0.7796 -0.6443 -1.5531 -1.5977 -0.4816  0.6204  0.6121 -0.1623  0.8119 
##     n35     n36     n37     n38     n40     n42     n43     n44     n45 
##  0.2543  0.4912 -0.3241 -1.6621  0.0258 -2.3804 -1.0603  0.9371  0.8545 
##     n47     n48     n49     n50 
## -1.4131  0.5674  0.5832 -1.3068
```

```r
x[x >= 1.96 | x <= -1.96] # can be as complicated as you like
```

```
##    n32    n33    n42 
##  2.197  2.049 -2.380
```

```r
# What is this doing?
x[1:50 %% 2 == 0] # %% is the modulo operator (remainder of a division of one number by another)
```

```
##      n2      n4      n6      n8     n10     n12     n14     n16     n18 
##  0.7095 -0.4535 -1.8180 -0.2762 -0.9193  1.8173  0.5202  0.8169 -0.3316 
##     n20     n22     n24     n26     n28     n30     n32     n34     n36 
##  0.2987  1.4558 -1.5531  1.8051  0.6204 -0.1623  2.1968  1.6324  0.4912 
##     n38     n40     n42     n44     n46     n48     n50 
## -1.6621  0.0258 -2.3804  0.9371  1.4607  0.5674 -1.3068
```


Of course, each returned subset can be assigned to a new symbol:


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

The principle is the same, but it is more complicated because dataframes have 2 dimensions (rows and columns)

Now we use two subsetting expressions [first rows, then columns] separated by a comma

We will be using a version of Fisher's Iris data that I have mangled!

You can get the original data by calling `data(iris)`


```r
iris <- read.csv("~/Dropbox/tutorials/subsetting/iris_mangled.csv")
```

```
## Warning: cannot open file
## '/Users/heimannrichard/Dropbox/tutorials/subsetting/iris_mangled.csv': No
## such file or directory
```

```
## Error: cannot open the connection
```

```r
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
##  [52] 6.4 6.9 5.5 6.5 5.7 6.3 4.9 6.6 5.2 5.0 5.9 6.0 6.1 5.6 6.7 5.6 5.8
##  [69] 6.2 5.6 5.9 6.1 6.3 6.1 6.4 6.6 6.8 6.7 6.0 5.7 5.5 5.5 5.8 6.0 5.4
##  [86] 6.0 6.7 6.3 5.6 5.5 5.5 6.1 5.8 5.0 5.6 5.7 5.7 6.2 5.1 5.7 6.3 5.8
## [103] 7.1 6.3 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7 7.7
## [120] 6.0 6.9 5.6 7.7 6.3 6.7 7.2 6.2 6.1 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7
## [137] 6.3 6.4 6.0 6.9 6.7 6.9 5.8 6.8 6.7 6.7 6.3 6.5 6.2 5.9
```

```r
iris$Petal.Length
```

```
##   [1] 1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 1.5 1.6 1.4 1.1 1.2 1.5 1.3
##  [18] 1.4 1.7 1.5 1.7 1.5 1.0 1.7 1.9 1.6 1.6 1.5 1.4 1.6 1.6 1.5 1.5 1.4
##  [35] 1.5 1.2 1.3 1.4 1.3 1.5 1.3 1.3 1.3 1.6 1.9 1.4 1.6 1.4 1.5 1.4 4.7
##  [52] 4.5 4.9 4.0 4.6 4.5 4.7 3.3 4.6 3.9 3.5 4.2 4.0 4.7 3.6 4.4 4.5 4.1
##  [69] 4.5 3.9 4.8 4.0 4.9 4.7 4.3 4.4 4.8 5.0 4.5 3.5 3.8 3.7 3.9 5.1 4.5
##  [86] 4.5 4.7 4.4 4.1 4.0 4.4 4.6 4.0 3.3 4.2 4.2 4.2 4.3 3.0 4.1 6.0 5.1
## [103] 5.9 5.6 5.8 6.6 4.5 6.3 5.8 6.1 5.1 5.3 5.5 5.0 5.1 5.3 5.5 6.7 6.9
## [120] 5.0 5.7 4.9 6.7 4.9 5.7 6.0 4.8 4.9 5.6 5.8 6.1 6.4 5.6 5.1 5.6 6.1
## [137] 5.6 5.5 4.8 5.4 5.6 5.1 5.1 5.9 5.7 5.2 5.0 5.2 5.4 5.1
```


You have already learned about functions to examine your data, e.g.


```r
summary(iris)
head(iris)
names(iris)
str(iris)
View(iris)
```


Also useful for exploring your data is the pairs function

This builds a matrix of scatter plots for all pairs of variables in your data


```r
pairs(iris) 
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 


But the species factor complicates things, lets remove it:


```r
pairs(iris[,-5]) # blank before the comma selects all rows, -5 after the comma removes column #5
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 


Looking at this plot, what needs to be done?

1. Petal.Width and Petal.Breadth are perfectly correlated - remove the duplicate Petal.Breadth
2. Missing values (NA) in Sepal.Length - remove missing data rows
3. Petal lengths recorded on the wrong scale (metres rather than centimetres!) - transform back to cm
4. Big outlier in Sepal.Width - correct this typo

----------------------

## 1. Removing a column 

You can remove a whole column by assigning NULL to it:


```r
iris$petal.Breadth <- NULL
```


---------------------

## 2. Removing missing values 

You can do this using logical vectors:

Remember that you must explicitly reassign the data:


```r
iris[!is.na(iris$Sepal.Length),] # returns the correct data, but leaves the original unchanged
```

```
##     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
## 1            5.1         3.5          1.4         0.2     setosa
## 2            4.9         3.0          1.4         0.2     setosa
## 3            4.7         3.2          1.3         0.2     setosa
## 4            4.6         3.1          1.5         0.2     setosa
## 5            5.0         3.6          1.4         0.2     setosa
## 6            5.4         3.9          1.7         0.4     setosa
## 7            4.6         3.4          1.4         0.3     setosa
## 8            5.0         3.4          1.5         0.2     setosa
## 9            4.4         2.9          1.4         0.2     setosa
## 10           4.9         3.1          1.5         0.1     setosa
## 11           5.4         3.7          1.5         0.2     setosa
## 12           4.8         3.4          1.6         0.2     setosa
## 13           4.8         3.0          1.4         0.1     setosa
## 14           4.3         3.0          1.1         0.1     setosa
## 15           5.8         4.0          1.2         0.2     setosa
## 16           5.7         4.4          1.5         0.4     setosa
## 17           5.4         3.9          1.3         0.4     setosa
## 18           5.1         3.5          1.4         0.3     setosa
## 19           5.7         3.8          1.7         0.3     setosa
## 20           5.1         3.8          1.5         0.3     setosa
## 21           5.4         3.4          1.7         0.2     setosa
## 22           5.1         3.7          1.5         0.4     setosa
## 23           4.6         3.6          1.0         0.2     setosa
## 24           5.1         3.3          1.7         0.5     setosa
## 25           4.8         3.4          1.9         0.2     setosa
## 26           5.0         3.0          1.6         0.2     setosa
## 27           5.0         3.4          1.6         0.4     setosa
## 28           5.2         3.5          1.5         0.2     setosa
## 29           5.2         3.4          1.4         0.2     setosa
## 30           4.7         3.2          1.6         0.2     setosa
## 31           4.8         3.1          1.6         0.2     setosa
## 32           5.4         3.4          1.5         0.4     setosa
## 33           5.2         4.1          1.5         0.1     setosa
## 34           5.5         4.2          1.4         0.2     setosa
## 35           4.9         3.1          1.5         0.2     setosa
## 36           5.0         3.2          1.2         0.2     setosa
## 37           5.5         3.5          1.3         0.2     setosa
## 38           4.9         3.6          1.4         0.1     setosa
## 39           4.4         3.0          1.3         0.2     setosa
## 40           5.1         3.4          1.5         0.2     setosa
## 41           5.0         3.5          1.3         0.3     setosa
## 42           4.5         2.3          1.3         0.3     setosa
## 43           4.4         3.2          1.3         0.2     setosa
## 44           5.0         3.5          1.6         0.6     setosa
## 45           5.1         3.8          1.9         0.4     setosa
## 46           4.8         3.0          1.4         0.3     setosa
## 47           5.1         3.8          1.6         0.2     setosa
## 48           4.6         3.2          1.4         0.2     setosa
## 49           5.3         3.7          1.5         0.2     setosa
## 50           5.0         3.3          1.4         0.2     setosa
## 51           7.0         3.2          4.7         1.4 versicolor
## 52           6.4         3.2          4.5         1.5 versicolor
## 53           6.9         3.1          4.9         1.5 versicolor
## 54           5.5         2.3          4.0         1.3 versicolor
## 55           6.5         2.8          4.6         1.5 versicolor
## 56           5.7         2.8          4.5         1.3 versicolor
## 57           6.3         3.3          4.7         1.6 versicolor
## 58           4.9         2.4          3.3         1.0 versicolor
## 59           6.6         2.9          4.6         1.3 versicolor
## 60           5.2         2.7          3.9         1.4 versicolor
## 61           5.0         2.0          3.5         1.0 versicolor
## 62           5.9         3.0          4.2         1.5 versicolor
## 63           6.0         2.2          4.0         1.0 versicolor
## 64           6.1         2.9          4.7         1.4 versicolor
## 65           5.6         2.9          3.6         1.3 versicolor
## 66           6.7         3.1          4.4         1.4 versicolor
## 67           5.6         3.0          4.5         1.5 versicolor
## 68           5.8         2.7          4.1         1.0 versicolor
## 69           6.2         2.2          4.5         1.5 versicolor
## 70           5.6         2.5          3.9         1.1 versicolor
## 71           5.9         3.2          4.8         1.8 versicolor
## 72           6.1         2.8          4.0         1.3 versicolor
## 73           6.3         2.5          4.9         1.5 versicolor
## 74           6.1         2.8          4.7         1.2 versicolor
## 75           6.4         2.9          4.3         1.3 versicolor
## 76           6.6         3.0          4.4         1.4 versicolor
## 77           6.8         2.8          4.8         1.4 versicolor
## 78           6.7         3.0          5.0         1.7 versicolor
## 79           6.0         2.9          4.5         1.5 versicolor
## 80           5.7         2.6          3.5         1.0 versicolor
## 81           5.5         2.4          3.8         1.1 versicolor
## 82           5.5         2.4          3.7         1.0 versicolor
## 83           5.8         2.7          3.9         1.2 versicolor
## 84           6.0         2.7          5.1         1.6 versicolor
## 85           5.4         3.0          4.5         1.5 versicolor
## 86           6.0         3.4          4.5         1.6 versicolor
## 87           6.7         3.1          4.7         1.5 versicolor
## 88           6.3         2.3          4.4         1.3 versicolor
## 89           5.6         3.0          4.1         1.3 versicolor
## 90           5.5         2.5          4.0         1.3 versicolor
## 91           5.5         2.6          4.4         1.2 versicolor
## 92           6.1         3.0          4.6         1.4 versicolor
## 93           5.8         2.6          4.0         1.2 versicolor
## 94           5.0         2.3          3.3         1.0 versicolor
## 95           5.6         2.7          4.2         1.3 versicolor
## 96           5.7         3.0          4.2         1.2 versicolor
## 97           5.7         2.9          4.2         1.3 versicolor
## 98           6.2         2.9          4.3         1.3 versicolor
## 99           5.1         2.5          3.0         1.1 versicolor
## 100          5.7         2.8          4.1         1.3 versicolor
## 101          6.3         3.3          6.0         2.5  virginica
## 102          5.8         2.7          5.1         1.9  virginica
## 103          7.1         3.0          5.9         2.1  virginica
## 104          6.3         2.9          5.6         1.8  virginica
## 105          6.5         3.0          5.8         2.2  virginica
## 106          7.6         3.0          6.6         2.1  virginica
## 107          4.9         2.5          4.5         1.7  virginica
## 108          7.3         2.9          6.3         1.8  virginica
## 109          6.7         2.5          5.8         1.8  virginica
## 110          7.2         3.6          6.1         2.5  virginica
## 111          6.5         3.2          5.1         2.0  virginica
## 112          6.4         2.7          5.3         1.9  virginica
## 113          6.8         3.0          5.5         2.1  virginica
## 114          5.7         2.5          5.0         2.0  virginica
## 115          5.8         2.8          5.1         2.4  virginica
## 116          6.4         3.2          5.3         2.3  virginica
## 117          6.5         3.0          5.5         1.8  virginica
## 118          7.7         3.8          6.7         2.2  virginica
## 119          7.7         2.6          6.9         2.3  virginica
## 120          6.0         2.2          5.0         1.5  virginica
## 121          6.9         3.2          5.7         2.3  virginica
## 122          5.6         2.8          4.9         2.0  virginica
## 123          7.7         2.8          6.7         2.0  virginica
## 124          6.3         2.7          4.9         1.8  virginica
## 125          6.7         3.3          5.7         2.1  virginica
## 126          7.2         3.2          6.0         1.8  virginica
## 127          6.2         2.8          4.8         1.8  virginica
## 128          6.1         3.0          4.9         1.8  virginica
## 129          6.4         2.8          5.6         2.1  virginica
## 130          7.2         3.0          5.8         1.6  virginica
## 131          7.4         2.8          6.1         1.9  virginica
## 132          7.9         3.8          6.4         2.0  virginica
## 133          6.4         2.8          5.6         2.2  virginica
## 134          6.3         2.8          5.1         1.5  virginica
## 135          6.1         2.6          5.6         1.4  virginica
## 136          7.7         3.0          6.1         2.3  virginica
## 137          6.3         3.4          5.6         2.4  virginica
## 138          6.4         3.1          5.5         1.8  virginica
## 139          6.0         3.0          4.8         1.8  virginica
## 140          6.9         3.1          5.4         2.1  virginica
## 141          6.7         3.1          5.6         2.4  virginica
## 142          6.9         3.1          5.1         2.3  virginica
## 143          5.8         2.7          5.1         1.9  virginica
## 144          6.8         3.2          5.9         2.3  virginica
## 145          6.7         3.3          5.7         2.5  virginica
## 146          6.7         3.0          5.2         2.3  virginica
## 147          6.3         2.5          5.0         1.9  virginica
## 148          6.5         3.0          5.2         2.0  virginica
## 149          6.2         3.4          5.4         2.3  virginica
## 150          5.9         3.0          5.1         1.8  virginica
```

```r
iris$Sepal.Length # Still see NA's
```

```
##   [1] 5.1 4.9 4.7 4.6 5.0 5.4 4.6 5.0 4.4 4.9 5.4 4.8 4.8 4.3 5.8 5.7 5.4
##  [18] 5.1 5.7 5.1 5.4 5.1 4.6 5.1 4.8 5.0 5.0 5.2 5.2 4.7 4.8 5.4 5.2 5.5
##  [35] 4.9 5.0 5.5 4.9 4.4 5.1 5.0 4.5 4.4 5.0 5.1 4.8 5.1 4.6 5.3 5.0 7.0
##  [52] 6.4 6.9 5.5 6.5 5.7 6.3 4.9 6.6 5.2 5.0 5.9 6.0 6.1 5.6 6.7 5.6 5.8
##  [69] 6.2 5.6 5.9 6.1 6.3 6.1 6.4 6.6 6.8 6.7 6.0 5.7 5.5 5.5 5.8 6.0 5.4
##  [86] 6.0 6.7 6.3 5.6 5.5 5.5 6.1 5.8 5.0 5.6 5.7 5.7 6.2 5.1 5.7 6.3 5.8
## [103] 7.1 6.3 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7 7.7
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
##  [52] 6.4 6.9 5.5 6.5 5.7 6.3 4.9 6.6 5.2 5.0 5.9 6.0 6.1 5.6 6.7 5.6 5.8
##  [69] 6.2 5.6 5.9 6.1 6.3 6.1 6.4 6.6 6.8 6.7 6.0 5.7 5.5 5.5 5.8 6.0 5.4
##  [86] 6.0 6.7 6.3 5.6 5.5 5.5 6.1 5.8 5.0 5.6 5.7 5.7 6.2 5.1 5.7 6.3 5.8
## [103] 7.1 6.3 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7 7.7
## [120] 6.0 6.9 5.6 7.7 6.3 6.7 7.2 6.2 6.1 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7
## [137] 6.3 6.4 6.0 6.9 6.7 6.9 5.8 6.8 6.7 6.7 6.3 6.5 6.2 5.9
```


## 3. Transforming a whole column

Remember: Use the tab key to auto-complete variable names!

Assign the changed vector to the original column

Note that we are using vectors so no commas!


```r
# transform Petal length to cm
iris$Petal.Length[iris$Species == "versicolor"] <- iris$Petal.Length[iris$Species == "versicolor"] * 100
pairs(iris[,-5]) 
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15.png) 


------------------------------

## 4. Changing a single data point

The 6th Sepal.Width value is a large outlier...

Looking at the original data recording sheet, you might see that the digits in the 6th Sepal.Width value were transposed...

Fix this:


```r
iris$Sepal.Width[6]
```

```
## [1] 3.9
```

```r
iris$Sepal.Width[6] <- 3.9
pairs(iris[,-5]) 
```

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-16.png) 


__Your data is now cleaned and ready for analysis!__

----------------------------------

## Tip: Make a data cleaning script

It is good practice to separate out your cleaning and analysis scripts

e.g. get_data.R:


```r
iris <- read.csv("~/Dropbox/tutorials/subsetting/iris_mangled.csv")
iris$petal.Breadth <- NULL
iris <- iris[!is.na(iris$Sepal.Length),] 
iris$Petal.Length[iris$Species == "versicolor"] <- iris$Petal.Length[iris$Species == "versicolor"] * 100
iris$Sepal.Width[6] <- 3.9
```


This reads in and cleans your data, leaving the original data unchanged

Run this at the start of all of your analysis scripts:

`source("path/to/get_data.R")`

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
