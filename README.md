Getting And Cleaning Data
===========================

Repository for code written for Getting and Cleaning Data Coursera course:
https://www.coursera.org/course/getdata

# Course Project

## How to Run Script
1. Download the script file to your working directory.
2. Open R/RStudio
3. Open script in R and source it or run command `source('~/run_analysis.R')`
4. That's it. Final dataset (named `tidy_dataset.txt`) will be available in your working directory. 

## How Script Works 
1) Creates temp directory `./data` if not exist, downloads zip archive and unzips all files

2) Loads common data: list of 561 features and activity labels.

3) Loads and processes train data:
- extracts only the measurements on the mean and standard deviation for each measurement from `X_train.txt`
- creates id column for merging
- extracts activity ids for each record from `y_train.txt`
- merges activity ids and activity labels
- extracts subject ids for each record from `subject_train.txt`
- creates id column for merging
- merges activity data and subject ids
- merges activity, subject data and measurements by id column into `m_train` 

4) Loads and processes test data:
- extracts only the measurements on the mean and standard deviation for each measurement from `X_test.txt`
- creates id column for merging
- extracts activity ids for each record from `y_test.txt`
- merges activity ids and activity labels
- extracts subject ids for each record from `subject_test.txt`
- creates id column for merging
- merges activity data and subject ids
- merges activity, subject data and measurements by id column into `m_test` 

5) Concatenates train and test data

6) Removes unnecessary variables and deletes temp directory

7) Final dataset
- data aggregated by groups and means are calculated
- writes tidy dataset into .txt file
