##Developing Data Products: Course Project
##Subtitle: Which investment is better? US dollar or Gold
##https://archive.ics.uci.edu/ml/datasets/Predict+keywords+activities+in+a+online+social+media

##Data source:
##Gold price: http://data.okfn.org/data/core/gold-prices
##US Dollar rate/index: https://research.stlouisfed.org/fred2/series/DTWEXB/downloaddata

##Price charge unit:
##Gold price: US dollar per ounce
##US dollar rate/index: Relative index to Jan-1997(=100)

##Load data
#setwd("./golddollar")
library(shiny)
library(ggplot2)
library(pxR)

gold <- read.csv("./data/gold.csv", header=TRUE, na.strings=c("NA","."," ",""))
usdollar <- read.csv("./data/usdollar.csv", header=TRUE, na.strings=c("NA","."," ",""))

##Preprocess and clean
##Monthly time window: 1995-01-01 to 2014-06-01
gold$DateTime <- as.Date(gold$date, format="%Y-%m-%d")
usdollar$DateTime <- as.Date(usdollar$DATE, format="%Y-%m-%d")

gold <- gold[, c(2,3)]
usdollar <- usdollar[, c(2,3)]

names(gold) <- c("Price", "Date")
names(usdollar) <- c("Price", "Date")

gold <- gold[which((gold$Date <= as.Date("2014-06-01", format="%Y-%m-%d")) & 
                      (gold$Date >= as.Date("1995-01-01", format="%Y-%m-%d"))), ]
usdollar <- usdollar[which((usdollar$Date <= as.Date("2014-06-01", format="%Y-%m-%d")) & 
                             (usdollar$Date >= as.Date("1995-01-01", format="%Y-%m-%d"))), ]

gold$investment <- "Gold: US dollars per ounce"
usdollar$investment <- "US Dollar: Relative index to 01/1997 (=100)"

combine <- rbind(gold, usdollar)
datetime <- as.character(gold$Date)

combine <- transform(combine, investment=as.factor(investment)) ##Combine gold and usdollar

##Subset dataset: Select data between start date to end date
subsetData <- function(start, end, dataset) {
  ##Subset dataset from start date to end date
  if (dataset == "Gold") {
    subdata <- gold
  }else if (dataset == "US Dollar") {
    subdata <- usdollar
  }else if (dataset == "Combine") {
    subdata <- combine
  }else {
    stop("Please input correct argument for dataset: Gold or US Dollar")
  }
  
  startdate <- as.Date(start, format="%Y-%m-%d")
  enddate <- as.Date(end, format="%Y-%m-%d")
  
  if (startdate > enddate) {
    stop("Start date should not be later than End date!")
  }
  
  subdata <- subdata[which((subdata$Date <= enddate) & (subdata$Date >= startdate)), ]
  return(subdata)
}

##gold_subset
##usdollar_subset

##Time series line
tsplot <- function(start, end, dataset) {
  if (as.Date(start, format="%Y-%m-%d") > as.Date(end, format="%Y-%m-%d")) {
    stop("Start date should not be later than End date!")
  }
  
  subdataset <- subsetData(start, end, dataset)
  p <- ggplot(data=subdataset, aes(x=Date, y=Price, fill=investment))
  p + geom_line(aes(colour=investment, group=investment)) + 
    labs(title=paste("Performance of Gold vs US Dollar from ", start, " to ", end),
         x="Date", y="Price", fill="Investment")
}
  
##Correlation between Gold and US Dollar
tscorr <- function(start, end, dataset="Combine") {
  if (as.Date(start, format="%Y-%m-%d") > as.Date(end, format="%Y-%m-%d")) {
    stop("Start date should not be later than End date!")
  }
  
  subdataset <- subsetData(start, end, dataset="Combine")
  correlation <- with(subdataset, cor.test(Price[investment=="Gold: US dollars per ounce"], 
                                   Price[investment=="US Dollar: Relative index to 01/1997 (=100)"]))
  
  print1 <- paste("The correlation between Gold and US Dollar from ", start, " to ",
              end, " is ", as.character(round(correlation$estimate, digits=4)), ".", sep="")
  print2 <- paste("The p-value of correlation test is ", as.character(round(correlation$p.value, digits=4)), ".", sep="")
  
  if (correlation$p.value < 0.05) {
    if (correlation$estimate < 0) {
      print3 <- "The correlation between Gold and US Dollar price is significantly negative."
    }else {
      print3 <- "The correlation between Gold and US Dollar price is significantly positive."
    }
  }else {
    if (correlation$estimate < 0) {
      print3 <- "The correlation between Gold and US Dollar price is insignificantly negative."
    }else {
      print3 <- "The correlation between Gold and US Dollar price is insignificantly positive."
    }
  }
  out <- paste(print1, print2, print3, sep=" ", collapse='\n')
  return(out)
}


