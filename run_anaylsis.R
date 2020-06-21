#Download and unzip the data set
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "data.zip")
unzip("data.zip")

#Read the various text files into Rstudio as data frames
features <- read.table("UCI HAR Dataset/features.txt")[ ,2]
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject_ID")
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject_ID")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Activity_ID")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Activity_ID")

#Merge the test and train data set
test <- cbind(sub_test, y_test, X_test)
train <- cbind(sub_train, y_train, X_train)
TestNTrain <- rbind(test, train)

#Extract the required features
cols <- grep("mean|std", features)
cols <- cols + 2
cols <- c(1, 2, cols)
TestNTrain <- TestNTrain[ , cols]

#Name the activites in TestNTrain
library(dplyr)
TestNTrain<- mutate(TestNTrain, Activity_label = activity[TestNTrain[, 2], 2])
TestNTrain <- TestNTrain[ , c(1,2, 82, 3:81)]

#Label the columns with descriptive variable names
names(TestNTrain) <- gsub("\\.", "", names(TestNTrain))
names(TestNTrain) <- sub("^t", "Time_", names(TestNTrain))
names(TestNTrain) <- sub("^f", "Frequency_", names(TestNTrain))
names(TestNTrain) <- sub("BodyBody", "Body", names(TestNTrain))
names(TestNTrain) <- sub("Acc", "_Accelerometer", names(TestNTrain))
names(TestNTrain) <- sub("Gyro", "_Gyroscope", names(TestNTrain))
names(TestNTrain) <- sub("Mag", "_Magnitude", names(TestNTrain))
names(TestNTrain) <- sub("Jerk", "_Jerk", names(TestNTrain))
names(TestNTrain) <- sub("std", "_Standard.Deviation", names(TestNTrain))
names(TestNTrain) <- sub("mean", "_Mean", names(TestNTrain))
names(TestNTrain) <- sub("X", "_X", names(TestNTrain))
names(TestNTrain) <- sub("Y", "_Y", names(TestNTrain))
names(TestNTrain) <- sub("Z", "_Z", names(TestNTrain))

#Creates a data set with the average of each variable for each activity and each subject by melting and casting
idVar = c("Subject_ID", "Activity_ID", "Activity_label")
measureVar = setdiff(names(TestNTrain), idVar)
library(reshape2)
meltedData <- melt(TestNTrain, id = idVar, measure.vars = measureVar)
AvgData <- dcast(md, Subject_ID + Activity_ID + Activity_label ~ variable, mean)

write.table(AvgData, file = "AvgData.txt", row.names = FALSE)
