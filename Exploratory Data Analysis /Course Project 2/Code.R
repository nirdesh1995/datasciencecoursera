

setwd("~/datascience/datasciencecoursera/Exploratory Data Analysis /Course Project 2")


#-------------------- Data Preperation  ----------------------------------------------------------
#reading in the data 
NEI <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

#combining the two datasets 
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)

# Question 1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

aggregate_data <- with(NEI, aggregate(Emissions, by = list(year), sum))

plot(aggregate_data, type = "o", main = "Total PM2.5 Emissions", xlab = "Year", ylab = "PM2.5 Emissions", pch = 19, col = "darkblue", lty = 6)

 #Question 2: Have total emissions from PM_{2.5} decreased in the Baltimore City, Maryland from 1999 to 2008?
 #Use the base plotting system to make a plot answering this question.


#Question 3: 
#Question 4:
#Question 5