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

##Plot 4. Across the United States, how have emissions from coal combustion-related
##sources changed from 1999–2008?
coal_select <- subset(SCC, grepl("Coal", EI.Sector)|grepl("Coal", Short.Name))
coal <- subset(NEI, SCC %in% coal_select$SCC)
coal_aggregate <- with(coal, aggregate(Emissions, by=list(year), FUN=sum))
names(coal_aggregate) <- c("Year", "Total_Emissions")
qplot(Year, Total_Emissions, data=coal_aggregate,
      geom="line") + ggtitle(expression("Total PM"[2.5]*" Emissions for Coal in US")) +
      xlab("Year") + ylab(expression("Total PM"[2.5]*" Emissions (tons)"))

##Save png
dev.copy(device=png, file="./plot4.png", width=684, height=370)
dev.off()
