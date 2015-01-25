# Coursera Getting and Cleaning Data Course Project
# Michael Choudhury
# 2015-01-25

# run_Analysis.R File:Script Objective

# This script will do the following on the UCI HAR Dataset downloaded at this URL: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# A. Merge the training and the test sets to create one data set
# B. Extract only the measurements on the mean and standard deviation for each measurement 
# C. Use descriptive activity names to name the activities in the data set
# D. Appropriately label the data set with descriptive activity names
# E. Create a second, independent tidy data set with the average of each variable for each activity and each subject 

#######################################################################

# Produce a tidy dataset as a text file after downloading and processing the zip file [UCI HAR Dataset] provided
# The data set consists of information captured by the Samsung Galaxy S smartphone
# Display the averages of all means and standrd deviations of variables by activity and subject
# Provide a Codebook describing the data, variables, and transformations
# Provide a README file explaining the workings of the scripts

#######################################################################

## Set working directory
## Create data directory for Samsung dataset
## Download dataset
## Unzip file

setwd("C:/MJC/Coursera/Getting and Cleaning Data/getAndCleanDataProject")
if(!file.exists("./samsungData")){dir.create("./samsungData")}
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "getdata-projectfiles-UCI-HAR-Dataset.zip"
download.file(fileUrl, destfile=paste("samsungData", destfile, sep="/"))
unzip(paste("samsungData", destfile, sep="/"), exdir="samsungData")
samsungData_dir <- setdiff(dir("samsungData"), destfile)

## Read in labels
labels <- read.table(paste("samsungData", samsungData_dir, "activity_labels.txt", sep="/"), 
                     col.names=c("labelID","labelDesc"))
## Read in features
features <- read.table(paste("samsungData", samsungData_dir, "features.txt", sep="/"))
## identify relevant features for this analysis
relevantFeatures <- grep("mean\\(|std\\(", features[,2])

## Read in training set
trainFold <- paste("samsungData", samsungData_dir, "train", sep="/")
trainSub <- read.table(paste(trainFold, "subject_train.txt", sep="/"), 
                               col.names = "subject")
trainDta <- read.table(paste(trainFold, "X_train.txt", sep="/"),
                            col.names = features[,2], check.names=FALSE)
trainDta <- trainDta[,relevantFeatures]
trainLab <- read.table(paste(trainFold, "y_train.txt", sep="/"),
                              col.names = "labelID")
dframeTrain = cbind(trainLab, trainSub, trainDta)

## Read in test data set
testFold <- paste("samsungData", samsungData_dir, "test", sep="/")
testSub <- read.table(paste(testFold, "subject_test.txt", sep="/"), 
                               col.names = "subject")
testDta <- read.table(paste(testFold, "X_test.txt", sep="/"),
                        col.names = features[,2], check.names=FALSE)
testDta <- testDta[,relevantFeatures]
testLab <- read.table(paste(testFold, "y_test.txt", sep="/"),
                              col.names = "labelID")
dframeTest = cbind(testLab, testSub, testDta)

## Merge the two data sets
dframe <- rbind(dframeTrain, dframeTest)

## Replace label IDs with the labelDesc
dframe = merge(labels, dframe, by.x="labelID", by.y="labelID")
dframe <- dframe[,-1]

## Transform the data array
library(reshape2)
molten <- melt(dframe, id = c("labelDesc", "subject"))

## Build tidy dataset to display mean of each variable for each activity and subject
tidydata <- dcast(molten, labelDesc + subject ~ variable, mean)

## Save tidy data set to local hard drive
write.table(tidydata, file="tidy.txt", quote=FALSE, row.names=FALSE, sep="\t")

## Save "codebook" variables to local hard drive
write.table(paste("* ", names(tidydata), sep=""), file="CodeBook.md", quote=FALSE,
            row.names=FALSE, col.names=FALSE, sep="\t")