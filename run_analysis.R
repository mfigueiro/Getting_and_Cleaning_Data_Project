## Reading Training dataset
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

## Reading Test dataset
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## Merging the datasets 
NewDataSet <- cbind(rbind(subject_test, subject_train), rbind(y_test,y_train),
                    rbind(x_train,x_test))

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

## Calculating the mean and The standard deviation 

MeanSd <- NewDataSet %>% select(subject, code, contains("mean"), contains("std"))
MeanSd

## Using the descriptive activity names 

MeanSd$code <- activities[MeanSd$code, 2]
MeanSd$code
MeanSd$subject <- activities[MeanSd$subject, 2]
MeanSd$subject

## Labeling the data set with descriptive variable names.
names(MeanSd)[2] = "activity"
names(MeanSd)<-gsub("Acc", "Accelerometer", names(MeanSd))
names(MeanSd)<-gsub("Gyro", "Gyroscope", names(MeanSd))
names(MeanSd)<-gsub("BodyBody", "Body", names(MeanSd))
names(MeanSd)<-gsub("Mag", "Magnitude", names(MeanSd))
names(MeanSd)<-gsub("^t", "Time", names(MeanSd))
names(MeanSd)<-gsub("^f", "Frequency", names(MeanSd))
names(MeanSd)<-gsub("tBody", "TimeBody", names(MeanSd))
names(MeanSd)<-gsub("-mean()", "Mean", names(MeanSd), ignore.case = TRUE)
names(MeanSd)<-gsub("-std()", "STD", names(MeanSd), ignore.case = TRUE)
names(MeanSd)<-gsub("-freq()", "Frequency", names(MeanSd), ignore.case = TRUE)
names(MeanSd)<-gsub("angle", "Angle", names(MeanSd))
names(MeanSd)<-gsub("gravity", "Gravity", names(MeanSd))

## Extracting the final results
FinalResults <- MeanSd %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean))
write.table(FinalResults, "FinalResults.txt", row.name=FALSE)


## Checking the final results

str(FinalResults)

FinalResults

