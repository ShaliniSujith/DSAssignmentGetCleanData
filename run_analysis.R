#package dplyr to clean the dataset
library(dplyr) 

#Download the dataset

#fileName of the dataset
fileName <- "getdata_projectfiles_UCI HAR Dataset.zip"

#Check if archive file already exist
if(!file.exists(fileName)){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, fileName)    
}

#Check if folder exist
if(!file.exists("UCI HAR Dataset")){
    unzip(fileName)
}

#Assign features file data to a data frame
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

#Assign activities file data to a data frame
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code","activity"))

#Assign test - subject_test/y_test file data to a data frame
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
xTest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

#Assign subject_train file data to a data frame
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

#Assign x&y file data to a data frame
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

##Merge training data
X <- rbind(xTrain, xTest)
Y <- rbind(yTrain, yTest)

##Merge test sets data
Subject <- rbind(subjectTrain, subjectTest)

##1. Merge training & test sets to create one data set
MergedData <- cbind(Subject, Y, X)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
CleanData <- MergedData %>% select(subject, code, contains("mean"), contains("std"))

#3: Uses descriptive activity names to name the activities in the data set.
CleanData$code <- activities[CleanData$code, 2]

#4: Appropriately labels the data set with descriptive variable names.
names(CleanData)[2] = "activity"
names(CleanData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(CleanData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(CleanData)<-gsub("BodyBody", "Body", names(TidyData))
names(CleanData)<-gsub("Mag", "Magnitude", names(TidyData))
names(CleanData)<-gsub("^t", "Time", names(TidyData))
names(CleanData)<-gsub("^f", "Frequency", names(TidyData))
names(CleanData)<-gsub("tBody", "TimeBody", names(TidyData))
names(CleanData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(CleanData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(CleanData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(CleanData)<-gsub("angle", "Angle", names(TidyData))
names(CleanData)<-gsub("gravity", "Gravity", names(TidyData))

#5:From the final data set create a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalData <- CleanData %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(FinalData,"FinalData.txt", row.names = FALSE)


