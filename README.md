The run_analysis.R script assumes the following files in the working directory.
*features.txt
*activity_labels.txt
*train/X_train.txt
*train/subject_train.txt
*test/X_test.txt
*test/subject_test.txt

The function run_analysis() returns the tidy data set.
To generate the tidydata.txt, run the following commands. 
*m1<-run_analysis()
*write.table(m1, "tidydata.txt", row.names = FALSE)