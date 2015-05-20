## DOWNLOAD AND EXTRACT FILES
if(!file.exists("data")){dir.create("data")}
print("downloading dataset...", quote=FALSE)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
destfile="./data/UCI HAR Dataset.zip")
print("unzipping...", quote=FALSE)
unzip("./data/UCI HAR Dataset.zip", exdir="./data")

## LOAD COMMON DATA
features<-read.csv("./data/UCI HAR Dataset/features.txt", header=FALSE, sep="", 
stringsAsFactors=FALSE, col.names=c("number", "feature"))
features_col<-gsub("\\(|\\)", "", as.character(features$feature))

activity_labels<-read.csv("./data/UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="", 
col.names=c("number", "activity"), stringsAsFactors=FALSE)

## LOAD AND PROCESS TRAIN DATA
print("loading and processing train data...", quote=FALSE)
x_train<-read.csv("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="", col.names=features_col)
x_train<-x_train[,c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,
165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,
424,425,426,427,428,429,503,504,516,517,529,530,542,543)]
x_train$id<-1:nrow(x_train)

y_train<-read.csv("./data/UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="", col.names=c("number"))
y_train$id<-1:nrow(y_train)

y_train<-merge(y_train, activity_labels, by=c("number"), sort=FALSE)

subject_train<-read.csv("./data/UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="", 
col.names=c("subject"))
subject_train$id<-1:nrow(subject_train)

m_train_t<-merge(y_train, subject_train, by=c("id"), sort=FALSE)
m_train<-merge(m_train_t, x_train, by=c("id"), sort=FALSE)

## LOAD AND PROCESS TEST DATA
print("loading and processing test data...", quote=FALSE)
x_test<-read.csv("./data/UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="", col.names=features_col)
x_test<-x_test[,c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,
165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,
424,425,426,427,428,429,503,504,516,517,529,530,542,543)]
x_test$id<-1:nrow(x_test)
y_test<-read.csv("./data/UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="", col.names=c("number"))
y_test$id<-1:nrow(y_test)

y_test<-merge(y_test, activity_labels, by=c("number"), sort=FALSE)

subject_test<-read.csv("./data/UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="", 
col.names=c("subject"))
subject_test$id<-1:nrow(subject_test)

m_test_t<-merge(y_test, subject_test, by=c("id"), sort=FALSE)
m_test<-merge(m_test_t, x_test, by=c("id"), sort=FALSE)

## CONCATENATE TRAIN AND TEST DATA
print("concatenating train and test data...", quote=FALSE)
m_merged<-rbind(m_train, m_test)

## CLEANING
print("throwing garbage...", quote=FALSE)
m_merged$number<-NULL

rm(features)
rm(features_col)
rm(activity_labels)
rm(x_train)
rm(y_train)
rm(subject_train)
rm(m_train_t)
rm(m_train)

rm(x_test)
rm(y_test)
rm(subject_test)
rm(m_test_t)
rm(m_test)
unlink("./data", recursive=TRUE)

## FINAL DATASET OF MEANS
m_mean<-aggregate(m_merged[,4:69], by=list(activity=m_merged$activity, subject=m_merged$subject), 
FUN=mean, na.rm=TRUE)
print("writing final dataset into './tidy_dataset.txt'...", quote=FALSE)
write.table(m_mean, "./tidy_dataset.txt", row.names=FALSE)
print("finished successfully!", quote=FALSE)
