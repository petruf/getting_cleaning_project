getting_cleaning_project
========================

data cleansing script for coursera project Getting and Cleaning data

To use the R script the following conditions have to be met:
* computer must have at least 600 MB of spare RAM memory (script does not drop unused data frames)
* the source UCI HAR Dataset (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) must be unzipped in the R working directory

_Script does not need any additional packages to be loaded_

##Clean dataset variables##
Dataset contains the selection of mean and standard deviation variables from the original UCI HAR Dataset. These variables were aggregated for every activity and tested individual and mean was calculated. Dataset contains following variables:
1. activity_name - description of measured activity
2. activity - integer code of measured activity
3. individual - ID of tested individual
4. - 69. - mean of original variables
