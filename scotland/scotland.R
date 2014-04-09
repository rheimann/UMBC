# GES673 Lab @ UMBC by Richard Heimann
# ========================================================
#   
#   ***Introduction***
#   
# Data analysis is like an interrogation. That is, the interviewer hopes to use a series of questions in order to 
# discover information - if not the truth. The questions the interrogator asks, of course, are subjectively chosen, 
# at least initiall, but in time are selected based on question utility i.e. those questions that produce maximum yield. 
# As such, the information that one interrogator gets out of an interrogatee might be fairly different from the information 
# that another interviewer gets out of the same person. That is, the efficacy of one will be different than another based on
# experience. Exploratory /Spatial/ Data Analysis provides the data analyst the intuition to interrogate data to maximize
# information yield. This lab provides some efficient ways to gracefully handle datasets of unknown information yield. 
# The lab is an R exercise, which hopefully adds more pragmatic and systematic description of the process. 
# That said, the commands (and thus the analysis) below are not the only way of analyzing the data. 
# When you understand what the commands are doing, you might decide to take a different approach to analyzing the data - 
#   please do so, and be sure to share what you find!
#   
#   ***Dataset Background***
# 
# The datasets, for this lab relate to council areas in Scotland (roughly equivalent to counties). 
# The one which I have labeled 'main' has numbers representing the number of drug related deaths by council area,
# with most of its columns containing counts that relate to specific drugs. It also contains geographical coordinates 
# of the council areas, in latitude and longitude. The one which I have labeled 'pop' contains population numbers. 
# The rest of the datasets contain numbers relating to problems with crime, education, employment, health, and income. 
# The datasets contain proportions in them, such that values closer to 1 indicate that the council area is more troubled, 
# while values closer to 0 indicate that the council area is less troubled in that particular way.



# Loading all the datasets

setwd("/Users/heimannrichard/Google Drive/GIS Data/drugdata_scotland")

main <- read.csv("2012-drugs-related-cx.csv")
pop <- read.csv("scotland pop by ca.csv")
crime <- read.csv("most_deprived_datazones_by_council_(crime)_2012.csv")
edu <- read.csv("most_deprived_datazones_by_council_(education)_2012.csv")
emp <- read.csv("most_deprived_datazones_by_council_(employment)_2012.csv")
health <- read.csv("most_deprived_datazones_by_council_(health)_2012.csv")
income <- read.csv("most_deprived_datazones_by_council_(income)_2012.csv")

# Indexing the data

names(main)
main$Council.area
main$Council.area[1:10]
main[1:10,1]

# Merging other relevant data with the main dataset

main <- merge(main, pop[,c(2,3)], by.x="Council.area", by.y="Council.area", all.x=TRUE)
main <- merge(main, crime[,c(1,4)], by.x="Council.area", by.y="label", all.x=TRUE)
main <- merge(main, edu[,c(1,4)], by.x="Council.area", by.y="label", all.x=TRUE)
main <- merge(main, emp[,c(1,4)], by.x="Council.area", by.y="label", all.x=TRUE)
main <- merge(main, health[,c(1,4)], by.x="Council.area", by.y="label", all.x=TRUE)
main <- merge(main, income[,c(1,4)], by.x="Council.area", by.y="label", all.x=TRUE)

# Weighting the number of drug related deaths by the population of each council area

main$All.drug.related.deaths_perTenK <- (main$All.drug.related.deaths / (main$Population/10000))

# A histogram of the number of drug related deaths per 10,000 people

hist(main$All.drug.related.deaths_perTenK, col="royal blue")

# A Simple scatterplot

plot(All.drug.related.deaths_perTenK ~ prop_income, data=main)
scatter.smooth(main$All.drug.related.deaths_perTenK ~ main$prop_income, data=main)
with(main, scatter.smooth(All.drug.related.deaths_perTenK, prop_income, lpars =
                            list(col = "red", lwd = 3, lty = 3)))

# A Scatterplot matrix

pairs(~All.drug.related.deaths_perTenK + Latitude + Longitude + prop_crime + prop_education + prop_employment + prop_income + prop_health, data=main)

## put histograms on the diagonal
panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}

panel.hist(main$All.drug.related.deaths_perTenK + main$prop_crime + main$prop_education + main$prop_employment + 
             main$prop_income + main$prop_health)

colnames(main)
pairs(main[2:11], panel = panel.smooth,
      cex = 1, pch = 20, bg = "blue",
      diag.panel = panel.hist, cex.labels = 1, font.labels = 1)

# Summary stats of all the variables in the dataset

summary(main)

# Simple summary stats of one variable at a time

mean(main$All.drug.related.deaths)
median(main$All.drug.related.deaths_perTenK)

# Here we do a median split of the longitudes of the council areas, resulting in an 'east' and 'west' group

main$LongSplit <- cut(main$Longitude, breaks=quantile(main$Longitude, c(0,.5,1)), include.lowest=TRUE, right=FALSE, ordered_result=TRUE, labels=c("East", "West"))

# Let's examine the number of records that result in each group:

table(main$LongSplit)

# Now we do a median split of the latitudes of the council areas, resulting in a 'north' and 'south' group

main$LatSplit <- cut(main$Latitude, breaks=quantile(main$Latitude, c(0,.5,1)), 
                    include.lowest=TRUE, right=FALSE, ordered_result=TRUE, labels=c("South", "North"))

# Let's examine the number of records that result in each group:

table(main$LatSplit)

# Now let's summarise some of the statistics according to our north-south east-west dimensions:

install.packages("dplyr")
library(dplyr)

data_source <- collect(main)
grouping_factors <- group_by(main, LongSplit, LatSplit)
deaths_by_area <- summarise(grouping_factors, median.deathsptk = median(All.drug.related.deaths_perTenK),
                           median.crime = median(prop_crime), median.emp = median(prop_employment),
                           median.edu = median(prop_education), num.council.areas = length(All.drug.related.deaths_perTenK))

# Examine the summary table just created
View(grouping_factors)
View(deaths_by_area)

# Now we'll make some fun plots of the summary table

library(ggplot2)

qplot(LongSplit, median.deathsptk, data=deaths_by_area, facets=~LatSplit, geom="bar", stat="identity", fill="dark red",main="Median Deaths/10,000 by Area in Scotland") + theme(legend.position="none")

qplot(LongSplit, median.crime, data=deaths_by_area, facets=~LatSplit, geom="bar", stat="identity", fill="dark red",main="Median Crime Score by Area in Scotland") + theme(legend.position="none")

qplot(LongSplit, median.emp, data=deaths_by_area, facets=~LatSplit, geom="bar", stat="identity", fill="dark red",main="Median Unemployment Score by Area in Scotland") + theme(legend.position="none")

qplot(LongSplit, median.edu, data=deaths_by_area, facets=~LatSplit, geom="bar", stat="identity", fill="dark red",main="Median Education Problems Score by Area in Scotland") + theme(legend.position="none")


# ****Some Online R Resources****
#   
#   https://github.com/rheimann/UMBC
# Github is a social code repository. The link above is to where the code for this and other labs are stored. 
# 
# http://www.r-bloggers.com
# If you are interested in R this is where you will find yourself spending alot of your time. The site shares multiple blogs a day of varied topics. 
# 
# http://stackoverflow.com/questions/tagged/r 
# StackOverflow is a great site to go to for help. 
# 
# sessionInfo()


