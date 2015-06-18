# Final Project

##0 Introduction

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a **tidy data set** as described below, 2) a **link to a Github repository** with your script for performing the analysis, and 3) a **code book** that describes the variables, the data, and any transformations or work that you performed to clean up the data called **CodeBook.md**. You should also include a **README.md** in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.  
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

##1 Setting Environment and Loading Data


```r
##Set environment
library(knitr)
library(plyr)
opts_chunk$set(echo = TRUE)
```

```r
##Download and unzip data files
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./getdata-projectfiles-UCI HAR Dataset.zip")
timeDownload <- date()
unzip("./getdata-projectfiles-UCI HAR Dataset.zip")
```
Time of downloading this data file is Thu Jun 18 18:17:46 2015.


```r
##Read test data
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testLabel <- read.table("./UCI HAR Dataset/test/Y_test.txt")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

##Read training data
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainLabel <- read.table("./UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

##Read label data
activityLabel <- read.table("./UCI HAR Dataset/activity_labels.txt")

##Read feature data: Note that rows of features equal to columns of testData/trainData
features <- read.table("./UCI HAR Dataset/features.txt")

##Rename variables of these datasets
names(testData) <- features$V2 
names(trainData) <- features$V2
names(testLabel) <- "activity"
names(trainLabel) <- "activity"
names(testSubject) <- "subject"
names(trainSubject) <- "subject"
```

##2 Data Cleaning


```r
##Q1. Merges the training and the test sets to create one data set
dataset <- rbind(testData, trainData)
```


```r
##Q2. Extracts only the measurements on the mean and standard deviation for each measurement
select <- grep("mean|std", names(dataset)) ##Select mean and std
dataset <- dataset[, select]
dataset$row <- rownames(dataset) ##Indicate row number
```


```r
##Q3. Uses descriptive activity names to name the activities in the data set
##Q4. Appropriately labels the data set with descriptive variable names
testDF <- data.frame(testLabel, testSubject) ##test data frame: activity, subject
trainDF <- data.frame(trainLabel, trainSubject) ##training data frame: activity, subject
DF <- rbind(testDF, trainDF)
DF$row <- rownames(DF)

##Merge datasets
mergeDF <- merge(DF, activityLabel, by.x="activity", by.y="V1", all=FALSE, all.x=TRUE)
mergeData <- merge(mergeDF, dataset, by.x="row", by.y="row", all=FALSE, all.x=TRUE)
mergeData$row <- as.numeric(mergeData$row)

##Sort datasets
sortMergeData <- arrange(mergeData, row)
```


```r
##Q5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
##Aggregate dataset by subject and activity
sortMergeData$V2 <- NULL
AggregateData <- aggregate(sortMergeData, list(sortMergeData$subject, sortMergeData$activity), mean)
AggregateData <- merge(AggregateData, activityLabel, by.x="activity", by.y="V1", all=FALSE, all.x=TRUE)

##Make dataset tidy
tidydata <- arrange(AggregateData, subject, activity) ##Sort the dataset
tidydata$Group.1 <- tidydata$V2; tidydata$Group.2 <- NULL; tidydata$row <- NULL; tidydata$V2 <- NULL ##Drop columns
tidydata[, c(1,2,3)] <- tidydata[, c(3,1,2)] ##Reorder variables
names(tidydata)[1:3] <- c("Subject","Activity","Name of Activity") ##Rename variables

# Write tidydata into txt file
write.table(file = "./tidydata.txt", x = tidydata, row.names = FALSE)
```
