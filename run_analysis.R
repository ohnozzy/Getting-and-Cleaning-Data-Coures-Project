run_analysis<-function(row=-1){
 
 #Y_train<-read.csv("train/Y_train.txt", FALSE)
 features<-read_feature()
 selected_column_vector<-grep("((mean\\(\\))|(std\\(\\)))", features[,2], value=TRUE)
 select_filter<-32*grepl("((mean\\(\\))|(std\\(\\)))", features[,2])-16
 #nrow(features)
 X_train<-read.fwf("train/X_train.txt",  select_filter,FALSE, n=row, col.names=selected_column_vector, colClasses=rep("numeric",66))
 
 Y_train<-read.csv("train/Y_train.txt", FALSE, nrows=row, col.names="ActivityID")
 subject_train<-read.csv("train/subject_train.txt", FALSE, nrows=row, col.names="SubjectID")
 xy_train<-cbind(X_train, Y_train)
 train_data<-cbind(subject_train, xy_train)
 
 X_test<-read.fwf("test/X_test.txt",  select_filter,FALSE, n=row, col.names=selected_column_vector, colClasses=rep("numeric",66))

 Y_test<-read.csv("test/Y_test.txt", FALSE, nrows=row, col.names="ActivityID")
 subject_test<-read.csv("test/subject_test.txt", FALSE, nrows=row, col.names="SubjectID")
 xy_test<-cbind(X_test, Y_test)
 test_data<-cbind(subject_test, xy_test)
 total_data<-rbind(train_data, test_data)
 activity<-read_activity()
 m1<-merge(total_data, activity)
 sp<-split(m1[,3:68], paste(m1[,2],' ',m1[,69]))
 transposedata<-t(sapply(sp, colMeans))
 row_name<-rownames(transposedata)
 data<-cbind(SUbjectID=substr(row_name, 1,2),Activity=substr(row_name, 3,10),transposedata)
 data
}
read_feature<-function(){
  read.table("features.txt", FALSE, sep=" ", colClasses=c("numeric", "character"))
}
read_activity<-function(){
  read.table("activity_labels.txt", FALSE, sep=" ", col.names=c("ActivityID","Activity"))
}