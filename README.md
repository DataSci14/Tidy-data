Tidy-data readme.md

*Two script files were submitted along with readme.md:
*run_analysis.R - contains script for the original tidy data set submitted in the first question that provides features that contain mean() and standard devitation()

*run_analysis(full-features).R - contains script to create tidy data set with mean and sd for all 561 features

*The script starts with reading in necessary data (x_test, y_test, x_train, y_train, features, subject_test, subject_train).  Files need to be in the current working directory.  Accessing features will provide a descriptive list of all the features recorded in the HAR UCI study and useful for decoding values in the dataset.


*Next activities (6 total) and subject values(volunteers, n = 30) are linked to features (561 total values) using cbind

*Next test subject data (consisting of 30% of total subjects) are combined with train subject data (consisting of 70% of total subjects) using rbind.  This will result in one dataset.

*Next descriptive activity labels ("walking", "walking upstairs", "walking downstairs", "sitting", "standing", "laying") are added to the dataset through a series of loops that subset.  The data is ordered and rbinded so that subject id rows, new activity names in rows, and feature data do not lose their counterparts after subseting has occured.

*Next the mean and standard deviation for each variable and for each volunteer are computed using cbind, rbind, apply(as.matrix(x, 2, mean), apply(as.matrix(x, 2, sd).  The data is subsetted based on features in the features.txt file that contain mean() and standard deviation().  Alternatively, "run_analysis(full-feature).R" contains similar script but wil compute the mean and standard deviation for each of the 561 variables and each volunteer.  There is a function included in the script "run_analysis(volunteer, positioning, measurement)" that provides parameters to subset to desired dataset.  "volunteer" can equal a number 1 to 30, "positioning" can equal "walking", "walking upstairs", "walking downstairs", "sitting", "standing", "laying" or left blank will return all six activities.  "measurement" can equal a number 1 to 561 that represents a row with the desired feature matching rows from "features.txt" or left blank will return all 561 features.

*I added both scripts since step two of the course project "Extracts only the measurements on the mean and standard deviation for each measurement" was confusing in that I didn't know if it was asking for means/sd pre (compute mean/sd for each of the 561 measurements) or post extraction (after taking out each of the features with mean() and sd() in their description find their mean and sd).  Either way it helped me learn and gave me more practice in manipulating large datasets to make them tidy. 

