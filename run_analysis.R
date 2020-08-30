library("reshape2")

#1 Get&Merge Data

x.train<-read.table("C:/Users/marti/Documents/Cleaningdata/UCI HAR Dataset/train/X_train.txt")
y.train<-read.table("C:/Users/marti/Documents/Cleaningdata/UCI HAR Dataset/train/Y_train.txt")
s.train<-read.table("C:/Users/marti/Documents/Cleaningdata/UCI HAR Dataset/train/subject_train.txt")

x.test<-read.table("C:/Users/marti/Documents/Cleaningdata/UCI HAR Dataset/test/X_test.txt")
y.test<-read.table("C:/Users/marti/Documents/Cleaningdata/UCI HAR Dataset/test/Y_test.txt")
s.test<-read.table("C:/Users/marti/Documents/Cleaningdata/UCI HAR Dataset/test/subject_test.txt")

x_full<- rbind(x.train,x.test)
Activity <- rbind(y.train,y.test)
Subject <- rbind(s.train,s.test)
colnames(Activity)<- c("Activity")
colnames(Subject)<- c("Subject")
Activity#2Activiity inf wasnt working to use just one argument for grep had to separat them
feature <- read.table("C:/Users/marti/Documents/Cleaningdata/UCI HAR Dataset/features.txt")
selectedColsX <- grep("mean", as.character(feature[,2]))
selectedColsY <- grep("std", as.character(feature[,2]))
selectedNamesX <- feature[selectedColsX, 2]
selectedNamesY <- feature[selectedColsY, 2]
selectedNamesX <- gsub("mean", "Mean", selectedNamesX)
selectedNamesX <- gsub("[-()]", "", selectedNamesX)
selectedNamesY <- gsub("std", "SatandarD", selectedNamesY)
selectedNamesY <- gsub("[-()]", "", selectedNamesY)

#Data with descriptive names
x.data <- x_full[selectedColsX]
x2.data<-x_full[selectedColsY]

colnames(x.data)<- c(selectedNamesX )
colnames(x2.data)<- c(selectedNamesY) 
TODO<- cbind(Subject,Activity,x.data,x2.data)
TODO2<- melt(TODO, id = c("Subject", "Activity"))
tData <- dcast(TODO2, Subject + Activity ~ variable, mean)
write.table(tData,"C:/Users/marti/Documents/Cleaningdata/UCI HAR Dataset/tidy_dateset.txt")

