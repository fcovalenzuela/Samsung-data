#########################1ST PART: CREATING A RAW DATA SET################
###Opening files
##TEST
X_test <- read.table("I:/Coursera_Classes/Coursera_Classes/UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("I:/Coursera_Classes/Coursera_Classes/UCI HAR Dataset/test/y_test.txt", quote="\"")
subject_test <- read.table("I:/Coursera_Classes/Coursera_Classes/UCI HAR Dataset/test/subject_test.txt", quote="\"")

##TRAIN
X_train <- read.table("I:/Coursera_Classes/Coursera_Classes/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("I:/Coursera_Classes/Coursera_Classes/UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_train <- read.table("I:/Coursera_Classes/Coursera_Classes/UCI HAR Dataset/train/subject_train.txt", quote="\"")

##FEATURES
features <- read.table("I:/Coursera_Classes/Coursera_Classes/UCI HAR Dataset/features.txt", quote="")

#Creating a data set for TEST
TEST<-cbind(subject_test, X_test, y_test)
##Creating a data set for TRAIN
TRAIN<-cbind(subject_train, X_train, y_train)


##Binding data set TEST and TRAIN
RAW_DATA<-rbind(TEST, TRAIN)

##Column names
features <- as.data.frame(features$V2)
features <- as.data.frame(t(features))
colnames(RAW_DATA)<- c("Subject_ID", as.vector(as.matrix(features)), "Activity")



##############2ND PART: SELLECTING COLUMN OF MEAN AND STANDARD DEVIATION##########################
###Open again the FEATURE file
features <- read.table("I:/Coursera_Classes/Coursera_Classes/UCI HAR Dataset/features.txt", quote="")
###Subset based in the mean and standard deviation name of column 
mean.std.vector<-subset(features, grepl('mean\\(\\)|std\\(\\)', features$V2))

###New file with selected variables
vector <- as.vector(mean.std.vector$V1+1)
SELECTED<- RAW_DATA[,c(1,vector,563)]
d<-SELECTED$Activity

###########3RD PART: DESCRIPTIVE NAMES BASED IN ACTIVITIES##################
SELECTED$Activity[SELECTED$Activity==1]<- "Walking"
SELECTED$Activity[SELECTED$Activity==2]<- "Walking_up"
SELECTED$Activity[SELECTED$Activity==3]<- "Walking_down"
SELECTED$Activity[SELECTED$Activity==4]<- "Sitting"
SELECTED$Activity[SELECTED$Activity==5]<- "Standing"
SELECTED$Activity[SELECTED$Activity==6]<- "Laying"
###########4TH PART: DESCRIPTIVE NAMES OF COLUMN##################
###It was already done. The variable names were taken from the file "features".


  
############5TH PART: DATA FRAME WITH SUMMARY OF VARiABLE BY SUBJECT_ID########
SELECTED$Activity <-c(d)
SMALL_DATA <-aggregate(SELECTED, by=list(SELECTED$Subject_ID,SELECTED$Activity),FUN=mean, na.rm=TRUE)
SMALL_DATA<-SMALL_DATA[,2:69]
colnames(SMALL_DATA)[colnames(SMALL_DATA) == "Group.2"] <- "Activity"
SMALL_DATA$Activity[SMALL_DATA$Activity==1]<- "Walking"
SMALL_DATA$Activity[SMALL_DATA$Activity==2]<- "Walking_up"
SMALL_DATA$Activity[SMALL_DATA$Activity==3]<- "Walking_down"
SMALL_DATA$Activity[SMALL_DATA$Activity==4]<- "Sitting"
SMALL_DATA$Activity[SMALL_DATA$Activity==5]<- "Standing"
SMALL_DATA$Activity[SMALL_DATA$Activity==6]<- "Laying"
SMALL_DATA<-as.data.frame(SMALL_DATA)
write.table(SMALL_DATA, "I:\\Coursera_Classes\\Coursera_Classes\\Small_data.txt", sep="\t")
