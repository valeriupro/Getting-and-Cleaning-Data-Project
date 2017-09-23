# Getting-and-Cleaning-Data-Project
This file reflects my work on the final project in the Getting and Cleaning Data Course on the Coursera.
The run_analysis.R file does the following:
1. Gets and unpacks the data from a web source
2. Reads in the activities and features of the human activity measurements 
3. Selects only those variables that refer to means and standard deviations
4. From the data pack reads and cbinds  the test data sets with columns corresponding to mean and std columns only
5. From the data pack reads and cbinds  the train data sets with columns corresponding to mean and std columns only
6. Appends the train and data sets and tydies the data accordingly
7. Creates an independent tidy data set with the averages of each variables for each activity and each subject
8. Saves the tidy data in the tidydata.txt file
