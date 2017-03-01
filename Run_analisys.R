#create a directory
if(!file.exists("./data5")){dir.create("./data5")}
#download the data
fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./data5/data.zip", method = "curl")
#unzip data
unzip(zipfile="./data5/data.zip",exdir="./data5")

# read files train
x_train <- read.table("./data5/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data5/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data5/UCI HAR Dataset/train/subject_train.txt")

#read files test
x_test <- read.table("./data5/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data5/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data5/UCI HAR Dataset/test/subject_test.txt")

# Read feature vector:
features <- read.table('./data5/UCI HAR Dataset/features.txt')


# Read activity labels:
activityLabels = read.table('./data5/UCI HAR Dataset/activity_labels.txt')

#assigning col names
colnames(x_train)<-features[,2]
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')


# update values with correct activity names
y_data[,1] <- activityLabels[y_data[, 1], 2]

y_test[,1]<- activityLabels[y_test[,1],2]

y_train[,1]<- activityLabels[y_train[,1],2]
# correct column name
# names(y_data) <- "activity"
# names(y_test) <- "activity"
# names(y_train) <- "activity"


# create 'x' data set
x_data <- rbind(x_train, x_test)

# create 'y' data set
y_data <- rbind(y_train, y_test)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)

all_data <- cbind(x_data, y_data, subject_data)

averages_data <- ddply(all_data, .(subjectId, activityId), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "averages_data.txt", row.name=FALSE)
