features <- read.table(file = './UCI HAR Dataset/features.txt') # loads features table to memory

feature_exp <- sort(c(1,2,grep('std()', features[[2]], fixed = TRUE)+2,grep('mean()', features[[2]], fixed = TRUE)+2)) # identifies variables that contains string 'mean()' and 'std()'
# index is increased by 2 because the columns individual (1) and activity (2) will be added later

activity_labels <- read.table(file = './UCI HAR Dataset/activity_labels.txt', col.names = c('activity','activity_name')) # loads activity_labels table to memory

X_test <- read.table(file = './UCI HAR Dataset/test/X_test.txt', header = FALSE, sep = '', col.names = features[[2]]) # loads X_test table to memory
Y_test <- read.table(file = './UCI HAR Dataset/test/Y_test.txt', header = FALSE, sep = '', col.names = 'activity') # loads Y_test table to memory
subject_test <- read.table(file = './UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = '', col.names = 'individual') # loads subject_test table to memory

X_train <- read.table(file = './UCI HAR Dataset/train/X_train.txt', header = FALSE, sep = '', col.names = features[[2]]) # loads X_train table to memory
Y_train <- read.table(file = './UCI HAR Dataset/train/Y_train.txt', header = FALSE, sep = '', col.names = 'activity') # loads Y_train table to memory
subject_train <- read.table(file = './UCI HAR Dataset/train/subject_train.txt', header = FALSE, sep = '', col.names = 'individual') # loads subject_train table to memory

YSX_test <- cbind(Y_test,subject_test, X_test) # merges test tables together
YSX_train <- cbind(Y_train,subject_train, X_train) # merges train tables together
YSX_UNION <- rbind(YSX_test, YSX_train) # merges train and test tables together

selected_YSX_UNION<-YSX_UNION[,feature_exp] # filters out relevant mean and std_d variables

output_header<- c('activity_name',names(selected_YSX_UNION)) # saving names of the header names to be used for final output file

tidy_mean <- aggregate.data.frame(x = selected_YSX_UNION, by = list(selected_YSX_UNION$activity, selected_YSX_UNION$individual), FUN = 'mean') # aggregates data by activity and individual using the function mean

tidy_mean_act <- merge(tidy_mean, activity_labels, by.x = 'activity', by.y = 'activity', all = TRUE) # merges the textual description to activity
tidy_data <- tidy_mean_act[with(tidy_mean_act, order(individual, activity)),output_header] # orders final table and filters out relevant variables
write.table(tidy_data,'tidy_data.txt',row.names=FALSE) # writes data to HDD
