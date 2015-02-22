## Assumptions:
##   - file has been downloaded and unzipped into its components
##   - working directory is "~/.../UCI HAR Dataset"

## Read in required data:
## - activity labels and measurement (feature) variables
        activityLabel <- read.table("activity_labels.txt")
        featureLabel <- read.table("features.txt")
        
## - training & test data (measurements, subjects, activities)
##      - training data
        trainMeasureData <- read.table("./train/X_train.txt")
        trainSubjectData <- read.table("./train/subject_train.txt")
        trainActivityData <- read.table("./train/y_train.txt")

##      - test data
        testMeasureData <- read.table("./test/X_test.txt")
        testSubjectData <- read.table("./test/subject_test.txt")
        testActivityData <- read.table("./test/y_test.txt")

        
## Combine the training and test dataset pairs
        MeasureData <- rbind(trainMeasureData, testMeasureData)
        SubjectData <- rbind(trainSubjectData, testSubjectData)
        ActivityData <- rbind(trainActivityData, testActivityData)
 
        
## Add descriptive column names to MeasureData
##      - use names provided in features.txt and make valid R variables
        featureName <- make.names(featureLabel[,2], unique=TRUE)

##      - rename columns of MeasureData
        names(MeasureData) <- featureName


## Reduce measurements to columns containing a reference to mean or standard deviation (std)
        reducedMeasureData <- select(MeasureData, contains(".mean", ignore.case=TRUE), contains(".std", ignore.case=TRUE))

## Column bind subject and activity to measurements & rename newly added columns
        names(SubjectData) <- "Subject" 
        names(ActivityData) <- "Activity"       
        reducedMeasureData <- cbind(SubjectData, ActivityData, reducedMeasureData)
        
        
## Replace activity code by descriptive label
        reducedMeasureData$Activity <- as.factor(reducedMeasureData$Activity)
        reducedMeasureData$Activity <- factor(reducedMeasureData$Activity, labels=activityLabel$V2)

## Aggregate by subject and activity and compute mean
        temp <- aggregate(reducedMeasureData, list(Subject=reducedMeasureData$Subject,Activity=reducedMeasureData$Activity), mean)

## Return the tidy dataset in .txt file
        keep <- c(1:2, 5:83)
        tidy <- temp[,keep]
        tidy <- arrange(tidy, Subject, Activity)
        write.table(tidy, "tidydataset.txt", row.names=FALSE, sep='\t', quote=FALSE)
