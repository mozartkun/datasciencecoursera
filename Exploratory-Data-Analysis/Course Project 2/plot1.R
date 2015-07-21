##Exploratory Data Analysis: Course Project 2
##http://www.epa.gov/ttn/chief/eiinformation.html

##Set environment
setwd("C:/Users/User/Desktop/Exploratory data analysis/Course Project 2/")
library(ggplot2)
library(knitr)


##Download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="./exdata-data-NEI_data.zip")
unzip(zipfile="./exdata-data-NEI_data.zip")
dateDownload <- date()

##Load and Preprocess data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Plot 1. Have total emissions from PM2.5 decreased in the United States from
##1999 to 2008? Using the base plotting system, make a plot showing the total
##PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
NEI_aggregate <- with(NEI, aggregate(Emissions, by=list(year), FUN=sum))
names(NEI_aggregate) <- c("Year", "Total_Emissions")
with(NEI_aggregate, plot(Year, Total_Emissions, type="l",
                         main=expression("Total PM"[2.5]*" Emissions in US"),
                         xlab="Year",
                         ylab=expression("Total PM"[2.5]*" Emissions (tons)")))

##Save png
dev.copy(device=png, file="./plot1.png", width=684, height=370)
dev.off()

