---
title: "CodeBook for Final Project"
output:
  html_document:
    keep_md: true
---

##Raw Data
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record in the raw dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

##Clean Data Procedure
When cleaning these raw data, I load test data, training data, and activity label data into R, and first merge the training and the test sets to create one data set.   
I give the variable name **Activity** in activity data and **Subject** in subject data, and then rename all variables in the merged data using labels shown in the activity label data.   
I extract only the measurements on the mean and standard deviation for each measurement item using regular expression method by matching words "mean" and "std".   
I use descriptive activity names to name the activities in the data set and appropriately label the data set with descriptive variable names.   
And finally I create a second, independent tidy data set with the average of each variable for each activity and each subject using aggregate function. I aggregate all measurement items by mean for each activity and each subject, and write this data out, just as shown in **tidydata.txt** submitted in the repo.  
The final **tidydata.txt** includes 82 variables. The first three are subject number, activity number and name of activities. The following 79 are focal measurement items.
