features <- read.table(file = './UCI HAR Dataset/features.txt')

feature_exp <- sort(c(1,2,grep('std()', features[[2]], fixed = TRUE)+2,grep('mean()', features[[2]], fixed = TRUE)+2))

activity_labels <- read.table(file = './UCI HAR Dataset/activity_labels.txt', col.names = c('activity','activity_name'))

X_test <- read.table(file = './UCI HAR Dataset/test/X_test.txt', header = FALSE, sep = '', col.names = features[[2]])
Y_test <- read.table(file = './UCI HAR Dataset/test/Y_test.txt', header = FALSE, sep = '', col.names = 'activity')
subject_test <- read.table(file = './UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = '', col.names = 'individual')

X_train <- read.table(file = './UCI HAR Dataset/train/X_train.txt', header = FALSE, sep = '', col.names = features[[2]])
Y_train <- read.table(file = './UCI HAR Dataset/train/Y_train.txt', header = FALSE, sep = '', col.names = 'activity')
subject_train <- read.table(file = './UCI HAR Dataset/train/subject_train.txt', header = FALSE, sep = '', col.names = 'individual')

YSX_test <- cbind(Y_test,subject_test, X_test)
YSX_train <- cbind(Y_train,subject_train, X_train)
YSX_UNION <- rbind(YSX_test, YSX_train)

selected_YSX_UNION<-YSX_UNION[,feature_exp]

output_header<- c('activity_name',names(selected_YSX_UNION))

tidy_mean <- aggregate.data.frame(x = selected_YSX_UNION, by = list(selected_YSX_UNION$activity, selected_YSX_UNION$individual), FUN = 'mean')

tidy_mean_act <- merge(tidy_mean, activity_labels, by.x = 'activity', by.y = 'activity', all = TRUE)
tidy_data <- tidy_mean_act[with(tidy_mean_act, order(individual, activity)),output_header]
write.table(tidy_data,'tidy_data.txt',row.names=FALSE)
