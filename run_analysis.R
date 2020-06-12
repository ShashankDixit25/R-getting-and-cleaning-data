getwd()
setwd("C:/Users/shashank/Documents/R")
#unzip files#
z = unzip(zipfile="DSET.zip",exdir="./DSET")
z
#path for data #
pathdata = file.path("DSET", "UCI HAR Dataset")
files = list.files(path, recursive=TRUE)
files
#calling Data#
f1 = file.path(pathdata, "train", "X_train.txt")
f2 = file.path(pathdata, "train", "y_train.txt")
f3 = file.path(pathdata, "train", "subject_train.txt")
f4 = file.path(pathdata, "test", "X_test.txt")
f5 = file.path(pathdata, "test", "y_test.txt")
f6 = file.path(pathdata, "test", "subject_test.txt")
f7 = file.path(pathdata, "features.txt")
f8 = file.path(pathdata, "activity_labels.txt")
#read the data#
xtrain = read.table(f1,header = FALSE)
ytrain = read.table(f2,header = FALSE)
subject_train = read.table(f3,header = FALSE)
xtest = read.table(f4,header = FALSE)
ytest = read.table(f5,header = FALSE)
subject_test = read.table(f6,header = FALSE)
#featuredata#
features = read.table(f7,header = FALSE)
activityLabels = read.table(f8,header = FALSE)

#assigning column names #
colnames(xtrain) = features[,2]
colnames(ytrain) = "activityId"
colnames(subject_train) = "subjectId"

colnames(xtest) = features[,2]
colnames(ytest) = "activityId"
colnames(subject_test) = "subjectId"

colnames(activityLabels) =c('activityId','activityType')
# merge data#
mrg_train = cbind(ytrain, subject_train, xtrain)
mrg_test = cbind(ytest, subject_test, xtest)

set_one_file = rbind(mrg_train, mrg_test)

colNames = colnames(set_one_file)
#calculation#
mean_and_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
mean_and_std
setmean_std = set_one_file[ , mean_and_std == TRUE]

set_activity_names = merge(setmean_std, activityLabels, by='activityId', all.x=TRUE)
set_activity_names
#writing data#
write.csv(set_activity_names, "final.csv", row.name=TRUE)