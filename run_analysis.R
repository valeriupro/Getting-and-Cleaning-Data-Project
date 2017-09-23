# This script implements the Course Project of the Getting and Cleaning Data Course on the Coursera

# getting and unpacking the data from the external source 
FileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
FileName<-"UCI HAR Dataset.zip"
if (!file.exists(FileName)) {download.file(FileUrl, "rdata")}
FilePath<-"UCI HAR Dataset"
if (!file.exists(FilePath)) {unzip("rdata")}

# reading in the activities
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities_levels<-activities$V1
activities_labels <- as.character(activities$V2)

# reading in the variables referring to mean and standard deviation values only
features <- read.table("UCI HAR Dataset/features.txt")
features_names<-grep(".mean().|.std().", features$V2,value=TRUE)
features_colnames <- paste("V",grep(".mean().|.std().", features$V2),sep="")

# reading in and cbinding the test data sets with mean and std columns only
testSelect <- read.table("UCI HAR Dataset/test/X_test.txt")[features_colnames]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test<-cbind(testSubjects,testActivities,testSelect)

# reading in and cbinding the train data sets with mean and std columns only
trainSelect <- read.table("UCI HAR Dataset/train/X_train.txt")[features_colnames]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train<-cbind(trainSubjects,trainActivities,trainSelect)

# appending the train and test data sets and tyding
combset<-rbind(train,test)
colnames(combset)<-c("Subject","Activity",features_names)
combset$Activity<-factor(combset$Activity,levels=activities_levels,labels=activities_labels)
combset$Subject<-as.factor(combset$Subject)
colnames(combset) <- gsub("[\\(\\)-]", "", colnames(combset))
colnames(combset) <- gsub("BodyBody", "Body", colnames(combset))
colnames(combset) <- gsub("^f", "FreqDomain", colnames(combset))
colnames(combset) <- gsub("^t", "TimeDomain", colnames(combset))
colnames(combset) <- gsub("Acc", "Accelerometer", colnames(combset))
colnames(combset) <- gsub("Gyro", "Gyroscope", colnames(combset))
colnames(combset) <- gsub("Mag", "Magnitude", colnames(combset))
colnames(combset) <- gsub("Freq", "Frequency", colnames(combset))
colnames(combset) <- gsub("mean", "Mean", colnames(combset))
colnames(combset) <- gsub("std", "StdDev", colnames(combset))

# creating a secondary tidy data set with the average of each variable for each activity and each subject
library(dplyr)
combset_averages<-combset%>%group_by(Subject,Activity)%>%summarize_all(funs(mean))

#saving the tidy data  in a txt file
write.table(combset_averages,"tidydata.txt")
