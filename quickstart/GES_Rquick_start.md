# GES 673 Quick Start with R  #
### by Richard Heimann (ref: Social Media Mining with R) ###
#### https://github.com/rheimann/UMBC/raw/master/quickstart/1770OS_02_PreFinal.pdf #### 
========================================================

Why R?

I strongly prefer using the R statistical computing environment for  data analysis. This markdown document highlights the benefits of using R, presents an introductory lesson on its use, and provides pointers towards further resources for learning the R language.

At its most basic, R is simply a calculator. You can ask it what 2 + 2 is, and it will provide you with 4 as the answer. However, R is more flexible than the calculator you used in high school. In fact, its flexibility leads it to be described as a statistical computing environment. As such, it comes with functions that assist us with data manipulation, statistics, and graphing. R can also store, handle, and perform complex mathematical operations on data as well as utilize a suite of statistics- specific functions, such as drawing samples from common probability distributions. Most simply, R is a data analysis software adoringly promoted as being made by statisticians for statisticians. The R programming language is used by data scientists, statisticians, formal scientists, physical scientists, social scientists, and others who need to make sense of data for statistical analysis, data visualization, and predictive modeling. Fortunately, with the brief guidance provided by this document, you too will be using R for your own research. R is simple to learn, even for people with no programming or statistics experience.

#### INSTALL R #### 
##### To install R, simply point your browser to http://www.r-project.org
#####  and choose a mirror near you

#### INSTALL RStudio #### 
#####  An IDE is a programming environment that offers features beyond what is
#####  found via the terminal or the command line environment
#####  RStudio (http://www.rstudio.com)


```r
# R Commander is a point and click interface to R. It is limited but does
# have a wide variety of methods from a classical aspatial sense.
install.packages("Rcmdr")
library(Rcmdr)
```




```r
# You can use R as a calculator order of operations:
# http://www.khanacademy.org/math/cc-sixth-grade-math/cc-6th-factors-and-multiples/cc-6th-order-operations/v/order-of-operations
# parentheses, exponents, multiple/division (left to right),
# addition/subtraction (left to right)
2^4 - 3
```

```
## [1] 13
```



```r
2^(4 - 3)
```

```
## [1] 2
```



```r
sqrt(16)
```

```
## [1] 4
```



```r
# Take the log of 100 with base 10
log(100, 10)
```

```
## [1] 2
```

```r

# Though not necessary, it is best practice to label arguments This avoids
# confusion when functions take many arguments
log(100, base = 10)
```

```
## [1] 2
```



```r
# To get help with a function, you can use the help function, or type a
# question mark before a term. Using double question marks broadens the
# search.  help(log) ?log ??log
```



```r
# Assignment is an important concept in R. We can assign values to an
# object, then treat that object as if it were the value it stores. An
# example should make this much more clear. Note the use of the left-facing
# arrow for assignment (<-). Though you can assign with a right arrow, or a
# single equal sign, only using the left arrow helps avoid confusion.  #
# Assign the value 3 to the object called ‘my.variable’
my.variable <- 3
# Work with the object
my.variable * 2
```

```
## [1] 6
```

```r
# Create a new variable
other.object <- my.variable + 7
other.object * 2
```

```
## [1] 20
```



```r
#### Vectors, sequences and combining vectors #### Many R operations can be
#### performed, or performed more efficiently, on vectors or matrices.
c(1, 2, 3, 4, 5)
```

```
## [1] 1 2 3 4 5
```

```r
1:4
```

```
## [1] 1 2 3 4
```

```r
5:-1
```

```
## [1]  5  4  3  2  1  0 -1
```



```r
matrix(data = c(1, 2, 3, 4), byrow = TRUE, nrow = 2)
```

```
##      [,1] [,2]
## [1,]    1    2
## [2,]    3    4
```

```r

seq(from = 1, to = 5)
```

```
## [1] 1 2 3 4 5
```

```r

seq(from = 2, to = 6, by = 2)
```

```
## [1] 2 4 6
```



```r
# R also contains several constructs that allow access to individual
# elements or subsets through indexing operations. In the case of the basic
# vector types one can access the i-th element using x[i], but there is also
# indexing of lists (which are simply collections of other data types),
# matrices, and multi-dimensional arrays (that is, matrices with more than
# two dimensions).  In addition, R has a data type called a dataframe, which
# is what many readers familiar with Stata, SPSS, or Microsoft Excel would
# think of as a data set or spreadsheet. Dataframes have column and possibly
# also row names.  R has three basic indexing operators, with syntax
# displayed by the following examples: x[i] # read the i-th element of a
# vector x[i, j] # read i-th row, j-th column element of a matrix x[[i]] #
# read the i-th element of a list x$a # read the variable named “a” in a
# dataframe named x
```



```r
# divides each number in vector by 2
c(1, 2, 3, 4, 5)/2
```

```
## [1] 0.5 1.0 1.5 2.0 2.5
```



```r
# first vector divided by second
c(1, 2, 3, 4, 5)/c(5, 4, 3, 2, 1)
```

```
## [1] 0.2 0.5 1.0 2.0 5.0
```



```r
# log base 10 of vector
log(c(1, 2.5, 5), base = 10)
```

```
## [1] 0.0000 0.3979 0.6990
```



```r
# new variable x is assigned resultant set
x <- c(1, 2, 3, 4, 5)/2
x
```

```
## [1] 0.5 1.0 1.5 2.0 2.5
```



```r
# generic function ‘summary’ on variable x
summary(x)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     0.5     1.0     1.5     1.5     2.0     2.5
```



```r
# function to find mean notice mean is also captured by the generic function
# ‘summary’
mean(x)
```

```
## [1] 1.5
```



```r
# Getting data into R is often the first step in an analysis.  R has a suite
# of functions called “read”, such as read.csv(), to help with importing
# data. Here, we assign the values read in from a csv to an object called
# ‘mydata.’
mydata <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
```



```r
# returns the first few rows of the data
head(mydata)
```

```
##   admit gre  gpa rank
## 1     0 380 3.61    3
## 2     1 660 3.67    3
## 3     1 800 4.00    1
## 4     1 640 3.19    4
## 5     0 520 2.93    4
## 6     1 760 3.00    2
```



```r
# To the initial confusion of some, several R functions behave differently
# depending on the type of object on which they act. As we saw above, the
# summary() function outputs descriptive statistics when it is given a
# vector.  When given a dataframe, it outputs summary statistics for each
# variable:
summary(mydata)
```

```
##      admit            gre           gpa            rank     
##  Min.   :0.000   Min.   :220   Min.   :2.26   Min.   :1.00  
##  1st Qu.:0.000   1st Qu.:520   1st Qu.:3.13   1st Qu.:2.00  
##  Median :0.000   Median :580   Median :3.40   Median :2.00  
##  Mean   :0.318   Mean   :588   Mean   :3.39   Mean   :2.48  
##  3rd Qu.:1.000   3rd Qu.:660   3rd Qu.:3.67   3rd Qu.:3.00  
##  Max.   :1.000   Max.   :800   Max.   :4.00   Max.   :4.00
```



```r
mydata.model <- lm(mydata$gre ~ mydata$gpa)
summary(mydata.model)
```

```
## 
## Call:
## lm(formula = mydata$gre ~ mydata$gpa)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -302.39  -62.79   -2.21   68.51  283.44 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)    192.3       47.9    4.01  7.2e-05 ***
## mydata$gpa     116.6       14.0    8.30  1.6e-15 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 107 on 398 degrees of freedom
## Multiple R-squared:  0.148,	Adjusted R-squared:  0.146 
## F-statistic: 68.9 on 1 and 398 DF,  p-value: 1.6e-15
```



```r
# Visualization is a powerful tool for analyzing data and for presenting
# results.  Many relationships and patterns that are obscured by summary
# statistics can be brought to light through visualization. Below, we show a
# potent example of this.  To begin with, let’s look at some data R comes
# with on the stopping distance of cars. This variable is contained in a
# dataset called cars, in a variable called dist. Histograms provide an
# informative way to visualize single variables. We can make a histogram
# with one line of code:
data(cars)
hist(cars$dist)
```

![plot of chunk unnamed-chunk-21](figure/unnamed-chunk-21.png) 



```r
data(anscombe)
par(mfrow = c(2, 2))
plot(anscombe$x1, anscombe$y1, xlab = "x1", ylab = "y1", main = "Anscombe 1")
abline(lm(anscombe$y1 ~ anscombe$x1))
plot(anscombe$x2, anscombe$y2, xlab = "x2", ylab = "y2", main = "Anscombe 2")
abline(lm(anscombe$y2 ~ anscombe$x2))
plot(anscombe$x3, anscombe$y3, xlab = "x3", ylab = "y3", main = "Anscombe 3")
abline(lm(anscombe$y3 ~ anscombe$x3))
plot(anscombe$x4, anscombe$y4, xlab = "x4", ylab = "y4", main = "Anscombe 4")
abline(lm(anscombe$y4 ~ anscombe$x4))
```

![plot of chunk unnamed-chunk-22](figure/unnamed-chunk-22.png) 




### Style and workflow
Statistical programmers can think of R code—like other languages—as being dysfunctional, functional but awkward, or graceful. Graceful code is clear and readable, which helps prevent errors. Here are a few tips on writing graceful R code:
* Filenames should end in .R and be meaningful.
* Variable names should be short. If necessary, use a period to delineate
multiword variable names (for example, my.variable).
* Keep every line short. R will not terminate a command until all parentheses
are closed, so feel free to wrap commands across lines for brevity.
* Use spaces before and after the assignment, after commas, and around parentheses and operators (such as +) for readability.
* Use the left arrow (<-) for assignment, never the single equals sign.

For more details on writing good R code, refer to the guide at http://google- styleguide.googlecode.com/svn/trunk/Rguide.xml. Again, though R can be used interactively from within the terminal, it is best practice to develop code within an IDE, such as RStudio, so that it can be saved, changed, and rerun. Additionally, building version controls and persistence into your code by storing it on GitHub may be important, especially if you find yourself working in a group environment. Finally, many users will find the creation of projects useful—the RStudio documentation offers useful tips on this topic.

### Additional resources
This document provides what we hope is a useful, though necessarily brief, introduction to R. There are many resources available that will help you expand your R programming skill set. What follows is a short list of our favorites:
* A First Course in Statistical Programming with R by Braun and Murdoch (2007)
* The R Cookbook by Teetor (2011)
* Quick-R: http://www.statmethods.net/

### Summary
This document has set out a case for using the R mathematical computing environment for data handling and analysis due to R's zero cost feature, flexibility, and large support community. By now, you've seen how to import, summarize, and visualize datasets as well as run and plot bivariate regression models.
