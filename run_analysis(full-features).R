##Read in files associated with dataset
features <- read.table("./UCI HAR Dataset/features.txt")
colnames(features) <- c("feat.id","feature")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

##Link activities and subject values to features in dataset
alltestdata <- data.frame()
alltestdata <- cbind(y_test, subject_test, x_test)
alltraindata <- data.frame()
alltraindata <- cbind(y_train, subject_train, x_train)

##Combine test(30%) and train(70%) volunteers to make one dataset
alldata <- data.frame()
alldata <- rbind(alltestdata, alltraindata)

##Add descriptive activity labels to dataset
templabels <- data.frame()
for(i in levels(factor(alldata[,1]))) {
  activity <- data.frame()
  activity <- subset(alldata, V1 == i, select = c(V1))
  if(i == "1") {act <- "walking"} else 
    if(i == "2") {act <- "Walking upstairs"} else
      if(i == "3") {act <- "walking downstairs"} else
        if(i == "4") {act <- "sitting"} else
          if(i == "5") {act <- "standing"} else
            if(i == "6") {act <- "laying"}
  activity[,1] = act
  templabels <- rbind(templabels, activity) }
(o <- order(alldata[,1], decreasing = FALSE)); templabels[o, ]
activities <- templabels[o,1]
alldata1 <- data.frame()
alldata1 <- cbind(activities, alldata[,2:563])

##Find the mean and sd for each variable and for each volunteer
run_analysis <- function(volunteer, positioning, measurement) {
combined <- data.frame()
onlymeansd <- data.frame()
for(i in levels(factor(alldata1[,2]))) {
  final <- data.frame()
  final <- subset(alldata1, alldata1$V1==i)
  id <- i
    for(i in levels(factor(final[,1]))) { 
      if(i=="walking") {
        threshold1 <- subset(final, final$activities==i)
      mean_walking <- apply(as.matrix(threshold1[,3:563]), 2, mean)
      sd_walking <- apply(as.matrix(threshold1[,3:563]), 2, sd) } else 
        {mean_walking <- NA 
         sd_walking <- NA } 
      if(i=="walking upstairs") {
        threshold2 <- subset(final, final$activities==i)
      mean_walking_upstairs <- apply(as.matrix(threshold2[,3:563]), 2, mean)
      sd_walking_upstairs <- apply(as.matrix(threshold2[,3:563]), 2, sd) } else 
        {mean_walking_upstairs <- NA
        sd_walking_upstairs <- NA}
      if(i=="walking downstairs") {
        threshold3 <- subset(final, final$activities==i)
      mean_walking_downstairs <- apply(as.matrix(threshold3[,3:563]), 2, mean)
      sd_walking_downstairs <- apply(as.matrix(threshold3[,3:563]), 2, sd) } else 
      {mean_walking_downstairs <- NA
       sd_walking_downstairs <- NA}
      if(i=="sitting") {
        threshold4 <- subset(final, final$activities==i)
      mean_sitting <- apply(as.matrix(threshold4[,3:563]), 2, mean)
      sd_sitting <- apply(as.matrix(threshold4[,3:563]), 2, sd) } else
      {mean_sitting <- NA
       sd_sitting <- NA}
      if(i=="standing") {
        threshold5 <- subset(final, final$activities==i)
      mean_standing <- apply(as.matrix(threshold5[,3:563]), 2, mean)
      sd_standing <- apply(as.matrix(threshold5[,3:563]), 2, sd) } else 
      {mean_standing <- NA
       sd_standing <- NA}
      if(i=="laying") {
        threshold6 <- subset(final, final$activities==i)
      mean_laying <- apply(as.matrix(threshold6[,3:563]), 2, mean)
      sd_laying <- apply(as.matrix(threshold6[,3:563]), 2, sd) } else 
      {mean_laying <- NA
      sd_laying <- NA}
      results <- data.frame()
      results <- cbind(id, features, mean_walking, sd_walking, mean_walking_upstairs, sd_walking_upstairs, mean_walking_downstairs, sd_walking_downstairs, mean_sitting, sd_sitting, mean_standing, sd_standing, mean_laying, sd_laying) 
      combined <- rbind(combined, results)
    }
}

#run_analysis function parameters to subset to desired data
#volunteer can equal a number 1 to 30
#positioning can equal "walking", "walking upstairs", "walking downstairs", "sitting", "standing", "laying" or left blank will give all six activities
#measurement can equal a number 1 to 561 that represents a row with desired feature matching rows from "features.txt" or left blank will give all 561 features
  combined <- subset(combined, combined[,1]==volunteer) 
if(missing(positioning)) { 
  combined <- subset(combined, select = c(id, feat.id, feature, mean_walking, sd_walking, mean_walking_upstairs, sd_walking_upstairs, mean_walking_downstairs, sd_walking_downstairs, mean_sitting, sd_sitting, mean_standing, sd_standing, mean_laying, sd_laying)) } else 
    if(positioning == "walking") {
     combined <- subset(combined, select = c(id, feat.id, feature, mean_walking, sd_walking)) } else 
      if(positioning == "walking upstairs") {
         combined <- subset(combined, select = c(id, feat.id, feature, mean_walking_upstairs, sd_walking_upstairs)) } else
          if(positioning == "walking downstairs") {
             combined <- subset(combined, select = c(id, feat.id, feature, mean_walking_downstairs, sd_walking_downstairs)) } else 
               if(positioning == "sitting") {
                 combined <- subset(combined, select = c(id, feat.id, feature, mean_sitting, sd_sitting)) } else 
                   if(positioning == "standing") {
                     combined <- subset(combined, select = c(id, feat.id, feature, mean_standing, sd_standing)) } else 
                       if(positioning == "laying") {
                        combined <- subset(combined, select = c(id, feat.id, feature, mean_laying, sd_laying)) }
if(missing(measurement)) {
   combined <- combined[1:561,] } else 
      {combined <- combined[measurement,] }
combined
}
