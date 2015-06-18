#Final Project
##run_analysis.R

##Set environment
##setwd("C:/Users/User/Desktop/Getting and Cleaning data/")
library(plyr)

##Read table
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./getdata-projectfiles-UCI HAR Dataset.zip")
timeDownload <- date()
unzip("./getdata-projectfiles-UCI HAR Dataset.zip")

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

##Q1. Merges the training and the test sets to create one data set
dataset <- rbind(testData, trainData)

##Q2. Extracts only the measurements on the mean and standard deviation for each measurement
select <- grep("mean|std", names(dataset)) ##Select mean and std
dataset <- dataset[, select]
dataset$row <- rownames(dataset) ##Indicate row number

##Q3. Uses descriptive activity names to name the activities in the data set
##Q4. Appropriately labels the data set with descriptive variable names
testDF <- data.frame(testLabel, testSubject) ##test data frame: activity, subject
trainDF <- data.frame(trainLabel, trainSubject) ##training data frame: activity, subject
DF <- rbind(testDF, trainDF)
DF$row <- rownames(DF)
mergeDF <- merge(DF, activityLabel, by.x="activity", by.y="V1", all=FALSE, all.x=TRUE)
mergeData <- merge(mergeDF, dataset, by.x="row", by.y="row", all=FALSE, all.x=TRUE)
mergeData$row <- as.numeric(mergeData$row)
sortMergeData <- arrange(mergeData, row)

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

