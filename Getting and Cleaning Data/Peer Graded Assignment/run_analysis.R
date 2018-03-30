
#Set Appropriate working directory 
setwd("~/datascience/datasciencecoursera/Getting and Cleaning Data/Peer Graded Assignment")

#Part 1 : Merging the data sets 
#loading Train data :

subject_train <-read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
x_train   <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
y_train  <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)

#loading Test data :
subject_test    <-read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
x_test         <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
y_test         <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)

#loading features and tables
data_feature_names   <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)
activity_labels   <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)


#After exploring the data , I named the columns to make processing easier 
colnames(x_train) <- data_feature_names[,2]
colnames(x_test) <- data_feature_names[,2]

colnames(y_train) <- "activity_id"
colnames(y_test) <- "activity_id"

colnames(subject_train) <- "subject_id"
colnames(subject_test) = "subject_id"

colnames(activity_labels) <- c('activity_id','activity_type')

#PART 1
merged_train <- cbind(y_train, subject_train, x_train)
merged_test <- cbind(y_test, subject_test, x_test)
dataset_master <- rbind(merged_train, merged_test)

 
#PART 2 :Extracts only the measurements on the mean and standard deviation for each measurement.                   
mean_std <-dataset_master[,grepl("mean|std|subject_id|activity_id",colnames(dataset_master))]   


# PART 3.Uses descriptive activity names to name the activities in the data set

mean_std <- merge(mean_std, activity_labels, by='activity_id', all.x=TRUE)

#Part 4 Appropriately labels the data set with descriptive variable names. 

names(mean_std) <- gsub("\\(|\\)", "", names(mean_std), perl  = TRUE)   #perl = regexes 
names(mean_std) <- make.names(names(mean_std))

names(mean_std) <- gsub("Acc", "Acceleration", names(mean_std))
names(mean_std) <- gsub("^t", "Time", names(mean_std))
names(mean_std) <- gsub("^f", "Frequency", names(mean_std))
names(mean_std) <- gsub("BodyBody", "Body", names(mean_std))
names(mean_std) <- gsub("mean", "Mean", names(mean_std))
names(mean_std) <- gsub("std", "Std", names(mean_std))
names(mean_std) <- gsub("Freq", "Frequency", names(mean_std))
names(mean_std) <- gsub("Mag", "Magnitude", names(mean_std))


#Part 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_set <- aggregate(. ~subject_id + activity_id, mean_std, mean)
tidy_set <- tidy_set[order(tidy_set$subject_id, tidy_set$activity_id),]

write.table(tidy_set, "tidy_data_set.txt", row.name=FALSE)
