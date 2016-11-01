# R code for Getting and cleaning data project

# Install package: reshape2
if (!require("data.table")) {
  install.packages("reshape2")
}

library(reshape2)

# Getting Zipfile after verification if it already exists

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")){
  download.file(fileurl, destfile = paste(getwd(), "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"))
  # Unzipping the zipfile
  
  unzip("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
} else{ message("The file exists") }


#step 1#-- Merging the training and the test sets to create one data set. 

new.dir <- paste(getwd(), "UCI HAR Dataset/", sep = "/") 
setwd(new.dir)

features <- read.table("features.txt", row.names = 1)
  ## Loading X_test Data

  X_test <- read.table("./test/X_test.txt")
  y_test <- read.table("./test/y_test.txt")
  subject_test <- read.table("./test/subject_test.txt")
  
  ## Loading 
  
  X_train <- read.table("./train/X_train.txt")
  y_train <- read.table("./train/y_train.txt")
  subject_train <- read.table("./train/subject_train.txt")
  
  ## Merged Data
  
  MergedData <- rbind(X_test, X_train) 
  names(MergedData) <- names(MergedData) <- features[,1]
  MergedData[, "subject"] <- rbind(subject_test, subject_train)
  MergedData[, "activity"] <- rbind(y_test, y_train)
  
  
#step 2#-- Extracting only the measurements on the mean and standard deviation for each
# measurement.
  
  mean.sd.col <- grepl("mean\\(\\)", names(MergedData)) | grepl("std\\(\\)", names(MergedData))
  MergedData.extracted <- MergedData[, mean.sd.col]

#step 3#-- Using descriptive activity names to name the activities in the data set 
  
  label_info <- as.factor(read.table("activity_labels.txt", row.names = 1)[,1])
  MergedData$activity <- factor(MergedData$activity, labels = label_info)
  
#step 4#-- Appropriately labels the data set with descriptive variable names. 

  names(MergedData) <- gsub("^t", "time", names(MergedData))
  names(MergedData) <- gsub("^f", "frequency", names(MergedData))
  names(MergedData) <- gsub("Acc", "Accelerometer", names(MergedData))
  names(MergedData) <- gsub("Gyro", "Gyroscope", names(MergedData))
  names(MergedData) <- gsub("Mag", "Magnitude", names(MergedData))
  names(MergedData) <- gsub("BodyBody", "Body", names(MergedData))
 
#step 5#-- From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.
  
  library(plyr)
  MergedData.extracted[, "subject"] <- rbind(subject_test, subject_train)
  MergedData.extracted[, "activity"] <- rbind(y_test, y_train)
  Data2 <- aggregate(. ~subject + activity, MergedData.extracted, mean)
  Data2 <- Data2[order(Data2$subject,Data2$activity),]
  write.table(Data2, file = "tidydata.txt",row.name=FALSE)
  
