# Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to work on this course project

1. The data source (the link is found in ```CodeBook.md```) is downloaded automatically when running the R script ```run_analysis.R```. After downloading, it's unzipped and all the files that are usedfor the project are stored in a directory named UCI HAR Dataset
2. ```run_analysis.R``` could be run from any directory and does all the job and at the end will write down a tidy data set, ```tiny_data.txt```.

## Dependencies

```run_analysis.R``` file will help you to install the dependencies automatically. It depends on ```reshape2``` and ```pdlyr```. 
