---
title: "Introduction to Final Project"
output:
  html_document:
    keep_md: true
---

##Repo Guideline
This repo contains files including "README.md", "Instruction.md", "run_analysis.R", "run_analysis.Rmd", "run_analysis.md", "CodeBook.md" and "tidydata.txt".

"Instruction.md" introduces you the basic instruction of this final project, for example, what you should present and how you should do, etc.

"run_analysis.R" is R code for this final project.

"run_analysis.Rmd" and "run_analysis.md" are markdown files submitted in order to better present these results in the final project.

"CodeBook.md" describes the variables, the data, and any transformations or work that are performed to clean up the data.

"tidydata.txt" is a tidy dataset created which is required by guidelines in "Instruction.md".  

##Study design
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record in the raw dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

##Reference
Jorge L. et al. Human Activity Recognition Using Smartphones Dataset. 2012.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


