# GettingCleaningData
Repo for Coursera Data Science Course Getting &amp; Cleaning Data

### Introduction

The objective of the project is to demonstrate the ability to collect and clean data so that it is suited to further analyses.  The dataset used for the project is: 

Human Activity Recognition Using Smartphones Dataset, Version 1.0

        Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
        Smartlab - Non Linear Complex Systems Laboratory
        DITEN - Universit? degli Studi di Genova.
        Via Opera Pia 11A, I-16145, Genoa, Italy.
        activityrecognition@smartlab.ws
        www.smartlab.ws

Additional information regarding this data can be accessed here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

Data from the above dataset is read, filtered, and merged to produce a tidy (wide) dataset that contains one observation per combination of subject and activity.  Each observation is a series of means of selected measurements that themselves involve either a mean or a standard deviation. The CodeBook.md contains more detail regarding the selection process for  the measurements.


### Project Files

#### UCI HAR Dataset Files 

The following files from the UCI Human Activity Recognition dataset were used:

- **features_info.txt**: provides information on the variables used on the feature vector

- **features.txt**: provides a list of all features

- **activity_labels.txt**: links the class labels with their activity name

- **train/X_train.txt**: training set of feature measurements

- **train/y_train.txt**: training labels indicating activity performed for each set of measurements

- **train/subject_train.txt**: Each row identifies the subject who performed the activity for each window sample

- **test/X_test.txt**: Test set of feature measurements

- **test/y_test.txt**: Test labels indicating activity performed for each set of measurements
 
- **test/subject_test.txt**: Each row identifies the subject who performed the activity for each window sample.

The link to the dataset is here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 



#### Output/Result File 

A single file, **tidydataset.txt**, is produced containing a dataset of one observation vector for each combination of subject and activity.  Given that 30 subjects participated in 6 activities, the final dataset contains 180 observations.   



#### R Code File

The file **run_analysis.R** contains the code that transforms the initial dataset components into the result.  The logic assumes that the UCI HAR data file has been downloaded and unzipped into its components and that the working directory is "~/.../UCI HAR Dataset".

### Data Transformation Process

The transformation logic can be summarized as follows:

**Read in required data**

- activity labels ("activity_labels.txt", activityLabel)

- measurement feature labels ("features.txt", featureLabel)

- training & test data
        
        - measurements   
                - "./train/X_train.txt", trainMeasureData                 
                - "./test/X_test.txt", testMeasureData      
        - subjects        
                - "./train/subject_train.txt", trainSubjectData                
                - "./test/subject_test.txt", testSubjectData               
        - activities        
                - "./train/y_train.txt", trainActivityData                
                - "./test/y_test.txt", testActivityData

**Merge the training and test dataset pairs**

- the training and the test datasets for each of measurements, subjects, and activities are merged using the function rbind().  

**Add descriptive column names to the measurements dataset**

- the names provided in "features.txt" are made into valid R variables (make.names()) and the column names of the dataset are renamed (names()).
        
**Reduce measurements dataset to columns containing a reference to mean or standard deviation (std)**

- only columns containing the pattern "-mean" or "-std" are selected.  Note that the patterns become ".mean" and ".std" once the names go through the make.names() function.

**Column bind subject and activity to measurements & rename newly added columns**

- the result is now one dataset with Subject, Activity, and the selected columns from the measurement dataset.
              
**Replace activity code by descriptive label**

- the code/label links as provided in "activity_labels.txt" 

**Aggregate by subject and activity and compute mean**

- the aggregate() function is used to compute the mean of the different measurements grouped by subject and activity. 

**Return the tidy dataset in .txt file**

- return the resulting dataset in text file 
