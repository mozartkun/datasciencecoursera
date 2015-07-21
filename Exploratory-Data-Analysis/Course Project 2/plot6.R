##Exploratory Data Analysis: Course Project 2
##http://www.epa.gov/ttn/chief/eiinformation.html

##Set environment
setwd("C:/Users/User/Desktop/Exploratory data analysis/Course Project 2/")
library(ggplot2)
library(plyr)
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

##Plot 5. Compare emissions from motor vehicle sources in Baltimore City with emissions
##from motor vehicle sources in Los Angeles County, California (fips == "06037").
##Which city has seen greater changes over time in motor vehicle emissions?
motor_select <- subset(NEI, type=="ON-ROAD" & (fips=="24510"|fips=="06037"))
for (i in 1:dim(motor_select)[1]) {
  if (motor_select$fips[i]=="24510") {
    motor_select$area[i] = "Baltimore"
  } else {
    motor_select$area[i] = "Los Angeles"
  }
}

motor_aggregate <- with(motor_select, aggregate(Emissions, by=list(year, area), FUN=sum))
names(motor_aggregate) <- c("Year", "Area", "Total_Emissions")

qplot(Year, Total_Emissions, color=Area, data=motor_aggregate, geom="line") +
  ggtitle(expression("Total PM"[2.5]*" Emissions for Motor Vehicle in Baltimore and LA")) +
  xlab("Year") + ylab(expression("Total PM"[2.5]*" Emissions (tons)")) +
  facet_wrap(~Area, scales="free") + theme(legend.position="none")

##Save png
dev.copy(device=png, file="./plot6.png", width=684, height=370)
dev.off()
