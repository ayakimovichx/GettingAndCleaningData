## DOWNLOAD AND EXTRACT FILES
if(!file.exists("data")){dir.create("data")}
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="./data/UCI HAR Dataset.zip")
unzip("./data/UCI HAR Dataset.zip", exdir="./data")

## LOAD COMMON DATA
features<-read.csv("./data/UCI HAR Dataset/features.txt", header=FALSE, sep="", stringsAsFactors=FALSE, col.names=c("number", "feature"))
features_col<-as.character(features$feature)

activity_labels<-read.csv("./data/UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="", col.names=c("number", "activity"), stringsAsFactors=FALSE)

## LOAD AND PROCESS TRAIN DATA
x_train<-read.csv("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="", col.names=features_col)
x_train<-x_train[,c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,294,295,296,345,346,347,348,349,350,373,374,375,424,425,426,427,428,429,452,453,454,503,504,513,516,517,526,529,530,539,542,543,552,555,556,557,558,559,560,561)]
x_train$id<-1:nrow(x_train)

y_train<-read.csv("./data/UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="", col.names=c("number"))
y_train$id<-1:nrow(y_train)

y_train<-merge(y_train, activity_labels, by=c("number"), sort=FALSE)

subject_train<-read.csv("./data/UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="", col.names=c("subject"))
subject_train$id<-1:nrow(subject_train)

m_train_t<-merge(y_train, subject_train, by=c("id"), sort=FALSE)
m_train<-merge(m_train_t, x_train, by=c("id"), sort=FALSE)

## LOAD AND PROCESS TEST DATA

x_test<-read.csv("./data/UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="", col.names=features_col)
x_test<-x_test[,c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,294,295,296,345,346,347,348,349,350,373,374,375,424,425,426,427,428,429,452,453,454,503,504,513,516,517,526,529,530,539,542,543,552,555,556,557,558,559,560,561)]
x_test$id<-1:nrow(x_test)
y_test<-read.csv("./data/UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="", col.names=c("number"))
y_test$id<-1:nrow(y_test)

y_test<-merge(y_test, activity_labels, by=c("number"), sort=FALSE)

subject_test<-read.csv("./data/UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="", col.names=c("subject"))
subject_test$id<-1:nrow(subject_test)

m_test_t<-merge(y_test, subject_test, by=c("id"), sort=FALSE)
m_test<-merge(m_test_t, x_test, by=c("id"), sort=FALSE)

## CONCATENATE TRAIN AND TEST DATA

m_final<-rbind(m_train, m_test)

## CLEANING DATA
# remove "number" column from m_final
m_final$number<-NULL

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

## NEW DATASET OF MEANS

m_aggr<-aggregate(m_final[,4:89], by=list(activity=m_final$activity, subject=m_final$subject), FUN=mean, na.rm=TRUE)
