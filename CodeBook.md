*run_analysis.R* script performs the data preparation and then 5 steps as mentioned in the project's definition.

### 1. Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

### 2. Assign each data to variables
1. features <- features.txt :561 rows, 2 columns
2. activities <- activity_labels.txt :6 rows, 2 columns
3. subjectTest <- test/subject_test.txt :2947 rows, 1 column
4. xTest <- test/X_test.txt : 2947 rows, 561 columns
5. yTest <- test/y_test.txt : 2947 rows, 1 columns
6. subjectTrain <- test/subject_train.txt : 7352 rows, 1 column
7. xTrain <- test/X_train.txt : 7352 rows, 561 columns
8. yTrain <- test/y_train.txt : 7352 rows, 1 columns

### 3. Merges the training and the test sets to create one data set

X - Created by merging xTrain and xTest using rbind() function
Y - Created by merging yTrain and yTest using rbind() function

Subject - Created by merging subjectTrain and subjectTest using rbind() function
MergedData - Created by merging Subject, Y and X using cbind() function

### 4. Extracts only the measurements on the mean and standard deviation for each measurement
CleanData - Created by subsetting MergedData, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

### 5. Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the CleanData replaced with corresponding activity taken from second column of the activities variable

### 6. Appropriately labels the data set with descriptive variable names
* code column in CleanData renamed into activities
* All Acc in column's name replaced by Accelerometer
* All Gyro in column's name replaced by Gyroscope
* All BodyBody in column's name replaced by Body
* All Mag in column's name replaced by Magnitude
* All start with character f in column's name replaced by Frequency
* All start with character t in column's name replaced by Time

### 7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
* FinalData (180 rows, 88 columns) is created by sumarizing CleanData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
* Export FinalData into FinalData.txt file.