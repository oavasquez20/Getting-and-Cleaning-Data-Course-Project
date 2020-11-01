#Getting and cleaning Data Course Project By Oscar Vasquez

#First step: Merge Training and Test sets

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#Second step: Extracts Mean & SD  

TidyData <- Merged_Data %>% 
  select(subject, code, contains("mean"), contains("std"))

#Third Step: Name activities

TidyData$code <- activities[TidyData$code, 2]

#Fourth step: Labeling variables

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

#Fifth step: From the data set in step 4, creates a second, independent tidy 
#            data set with the average of each variable for each activity and 
#            each subject

FinalTidyData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(mean)
write.table(FinalTidyData, "FinalTidyData.txt", row.name=FALSE)

View(FinalTidyData)