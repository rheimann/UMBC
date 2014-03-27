#### INSTALL R #### 
# To install R, simply point your browser to http://www.r-project.org, 
# and choose a mirror near you. 

#### INSTALL RStudio #### 
# An IDE is a programming environment that offers features beyond what is 
# found via the terminal or the command line environment. 
# RStudio (http://www.rstudio.com)

#### Basics - Assignment and arithmetic #### 
# You can use R as a calculator
2^4-3

2^(4-3)

sqrt(16)

# Take the log of 100 with base 10
log(100, 10)

# Though not necessary, it is best practice to label arguments
# This avoids confusion when functions take many arguments
log(100, base=10)

# To get help with a function, you can use the help function, 
# or type a question mark before a term. Using double question marks 
# broadens the search.
help(log)
?log
??log

# Assignment is an important concept in R. We can assign values to an object, 
# then treat that object as if it were the value it stores. An example should 
# make this much more clear. Note the use of the left-facing arrow for 
# assignment (<-). Though you can assign with a right arrow, or a single equal sign,
# only using the left arrow helps avoid confusion.
# # Assign the value 3 to the object called ‘my.variable’
my.variable <- 3
# Work with the object
my.variable * 2
# Create a new variable
other.object <- my.variable + 7
other.object * 2

#### Vectors, sequences and combining vectors #### 
# Many R operations can be performed, or performed more 
# efficiently, on vectors or matrices. 
c(1,2,3,4,5)
1:4
5:-1

matrix(data=c(1, 2, 3, 4), byrow=TRUE, nrow=2)

seq(from=1, to=5)

seq(from=2, to=6, by=2)


# R also contains several constructs that allow access to individual elements 
# or subsets through indexing operations. In the case of the basic vector types 
# one can access the i-th element using x[i], but there is also indexing of lists 
# (which are simply collections of other data types), matrices, 
# and multi-dimensional arrays (that is, matrices with more than two dimensions). 
# In addition, R has a data type called a dataframe, which is what many readers 
# familiar with Stata, SPSS, or Microsoft Excel would think of as a data set or 
# spreadsheet. Dataframes have column and possibly also row names. 
# R has three basic indexing operators, with syntax displayed by the following 
# examples:
# x[i] # read the i-th element of a vector
# x[i, j] # read i-th row, j-th column element of a matrix
# x[[i]] # read the i-th element of a list
# x$a # read the variable named “a” in a dataframe named x

# divides each number in vector by 2
c(1,2,3,4,5) / 2  

# first vector divided by second
c(1,2,3,4,5) / c(5,4,3,2,1)

# log base 10 of vector 
log(c(1,2.5,5), base=10) 

# new variable x is assigned resultant set
x <- c(1,2,3,4,5) / 2 
x

# generic function ‘summary’ on variable x
summary(x)

# function to find mean 
# notice mean is also captured by the generic function ‘summary’
mean(x)  

# Getting data into R is often the first step in an analysis. 
# R has a suite of functions called “read”, such as read.csv(), 
# to help with importing data. Here, we assign the values read in 
# from a csv to an object called ‘mydata.’
mydata<- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")

# returns the first few rows of the data
head(mydata)  

# To the initial confusion of some, several R functions behave differently 
# depending on the type of object on which they act. As we saw above, the 
# summary() function outputs descriptive statistics when it is given a vector. 
# When given a dataframe, it outputs summary statistics for each variable:
summary(mydata)


mydata.model<- lm(mydata$gre~mydata$gpa) 
summary(mydata.model)

# Visualization is a powerful tool for analyzing data and for presenting results. 
# Many relationships and patterns that are obscured by summary statistics can be 
# brought to light through visualization. Below, we show a potent example of this. 
# To begin with, let’s look at some data R comes with on the stopping distance of 
# cars. This variable is contained in a dataset called cars, in a variable called 
# dist. Histograms provide an informative way to visualize single variables. We 
# can make a histogram with one line of code:
data(cars)
hist(cars$dist)