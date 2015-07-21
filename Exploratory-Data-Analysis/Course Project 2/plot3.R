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

##Plot 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
##variable, which of these four sources have seen decreases in emissions from 1999–2008 for
##Baltimore City? Which have seen increases in emissions from 1999–2008?
##Use the ggplot2 plotting system to make a plot answer this question.
Baltimore <- subset(NEI, fips=="24510")
Baltimore_aggregate <- with(Baltimore, aggregate(Emissions, by=list(type, year), FUN=sum))
names(Baltimore_aggregate) <- c("Type", "Year", "Total_Emissions")
qplot(Year, Total_Emissions, color=Type, data=Baltimore_aggregate,
      geom="path") + ggtitle(expression("Total PM"[2.5]*" Emissions in Baltimore by Type")) +
      xlab("Year") + ylab(expression("Total PM"[2.5]*" Emissions (tons)"))

##Save png
dev.copy(device=png, file="./plot3.png", width=684, height=370)
dev.off()
