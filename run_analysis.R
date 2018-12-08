#Step 1.A read train data
X_train <- read.table("C:/Users/AL-Qaisi/Documents/Clean Data Project/Project/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("C:/Users/AL-Qaisi/Documents/Clean Data Project/Project/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("C:/Users/AL-Qaisi/Documents/Clean Data Project/Project/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

# Step 1.B read test data
X_test <- read.table("C:/Users/AL-Qaisi/Documents/Clean Data Project/Project/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("C:/Users/AL-Qaisi/Documents/Clean Data Project/Project/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("C:/Users/AL-Qaisi/Documents/Clean Data Project/Project/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

# Step 1.C read data description
features <- read.table("C:/Users/AL-Qaisi/Documents/Clean Data Project/Project/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/features.txt")

# Step 1.D read activity labels
activityLabels <- read.table("C:/Users/AL-Qaisi/Documents/Clean Data Project/Project/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

# Step 2 Tag the test and train data sets

colnames(X_train) <- features[,2]
colnames(Y_train)  <-  "activityId"
colnames(subject_train)  <-  "subjectId"
colnames(X_test)  <-  features[,2]
colnames(Y_test)  <-  "activityId"
colnames(subject_test)  <-  "subjectId"
colnames(activityLabels) <- c('activityId','activityType')

# Step 3 Merge training and test sets togther to create one data set. 

mrg_train <- cbind(ytrain, subject_train, X_train)
mrg_test <- cbind(ytest, subject_test, X_test)
AllData <- rbind(mrg_train, mrg_test)

# Step 4 Extract the measurements on the mean and standard deviation only for each measurement

colNames <- colnames(AllData)
mean_and_std <- (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))

setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]
setWithActivityNames <- merge(setForMeanAndStd, activityLabels, by='activityId', all.x=TRUE)

#Step 5, from previous dataset creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.

Tidydata <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
Tidydata <- Tidydata[order(secTidySet$subjectId, Tidydata$activityId),]
write.table(Tidydata,"C:/Users/AL-Qaisi/Documents/Clean Data Project/Project/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/Tidydata.txt", row.name=FALSE)


