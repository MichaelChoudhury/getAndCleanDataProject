# getAndCleanData - Course Project

## Project Objectives:

- Develop a single R script called run_analysis.R to perform the following tasks:

- Merge the training and the test sets to create one data set

- Extract only the measurements on the mean and standard deviation for each measurement

- Use descriptive activity names to name the activities in the data set

- Appropriately label the data set with descriptive activity names

- Create a second, independent tidy data set with the average of each variable for each activity and each subject

### Steps in run_analysis.R:
1. Download the UCI HAR Dataset into ./samsungData after setting working directory
2. Unzip the data set into samsungData directory
3. Import the label IDs from activity_labels.txt by providing suitable column names
4. Import the feature key from features.txt 
5. Identify features containing -mean() or -std() by identifying relevant features using the grep function
6. Import the training and test data sets and only keep data columns from previous step above
7. Merge the training and test data sets using rbind
8. Replace label IDs in the datas et with appropriate labels 
9. Reshape data to use label names and subjects using the reshape2 package
10. Create a tidy data set called tidy.txt with the average of each variable for each activity and subject using dcast(molten)
11. Create code book with a list of variables extracted from the features file and write to local disk

### Additional information about the variables, data and transformation may be found in the CodeBook.MD file.

