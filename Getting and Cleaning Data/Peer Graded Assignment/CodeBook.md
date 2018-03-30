


Review Criteria: GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.


# CodeBook

This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

Dataset Obtained from:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Description of the dataset obtained from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.



## Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment. 


## The data

The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.



## Transformation details

There are 5 parts:
## Pre Analysis
 The code first set the working directory. As long as the run_analysis.r is in the same directory, the following steps should work.

## 1.Merging the data sets
* subject_test : subject IDs for test
* subject_train  : subject IDs for train
* x_test : values of variables in test
* x_train : values of variables in train
* y_test : activity ID in test
* y_train : activity ID in train
* activity_labels : Description of activity IDs in y_test and y_train
* data_feature_names : description(label) of each variables in X_test and X_train
* merged_train: column wise bind of (y_train, subject_train, x_train). 
* merged_test : column wise bind of (y_test, subject_test, x_test)
* dataset_master : Merge of train and test data sets 

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

* mean_std : a vector of only mean and std labels


## 3. Uses descriptive activity names to name the activities in the data set
mean_std : activity labels are merged to the mean_std

## 4. Appropriately labels the data set with descriptive variable names. 
 ( Idea from https://github.com/fxcebx/datasciencecoursera-1/blob/master/3.GettingandCleaningData/CourseProject/run_analysis.R ) 

 Parenthesis are removed from the column names and the following transformations are made using regular expressions:  
"Acc" -> "Acceleration"
"^t" ->  "Time"
"^f" -> "Frequency"
"BodyBody" ->   "Body"
"mean" -> "Mean"
"std" -> "Std"
"Freq" ->"Frequency"
"Mag" -> "Magnitude"


## Part 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_set : second dataset with aggregated values for the means for each subject 

"tidy_data_set.txt" file created at the end.

