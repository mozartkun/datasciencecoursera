##Practical Machine Learning: Project
##http://groupware.les.inf.puc-rio.br/har

##Set environment
setwd("C:/Users/User/Desktop/Practical Machine Learning/Course Project/")
library(ggplot2)
library(kernlab)
library(randomForest)
library(caret)
library(corrplot)
library(rpart)
library(rpart.plot)
library(rattle)
library(knitr)

##Download file and load data
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
download.file(fileUrl1, destfile="./pml-training.csv")
download.file(fileUrl2, destfile="./pml-testing.csv")
timeDownload <- date()
pml_training <- read.csv("./pml-training.csv", na.strings=c("NA"," ",""))
pml_testing <- read.csv("./pml-testing.csv", na.strings=c("NA"," ",""))

##Data clean
##Subset by dropping null variables and unrelated variables
##First, drop null variables
id <- c()
for (j in 1:dim(pml_training)[2]) { ##by column
  for (i in 1:dim(pml_training)[1]) { ##by row
    if (is.na(pml_training[i,j])) {
      id <- c(id,j)
      break
    }
  }
}

##Second, drop unrelated variables
id <- c(id, 1:7)

##Then get clean training dataset
pml_training_clean <- pml_training[, -id]

##Similarly clean test dataset
id <- c()
for (j in 1:dim(pml_testing)[2]) { ##by column
  for (i in 1:dim(pml_testing)[1]) { ##by row
    if (is.na(pml_testing[i,j])) {
      id <- c(id,j)
      break
    }
  }
}
id <- c(id, 1:7)
pml_testing_clean <- pml_testing[, -id]

##Train training dataset and cross-validate
##70% for training and 30% for cross-validate
inTrain <- createDataPartition(y=pml_training_clean$classe, p=0.7, list=FALSE)
train <- pml_training_clean[inTrain, ]
validate <- pml_training_clean[-inTrain, ]

##Train model using random forest method and cross-validate: activity quality
##Expect the out-of-sample error and estimate error with cross-validation
modelFit <- randomForest(classe~., data=train) ##Train model
modelValidate <- predict(modelFit, validate) ##Cross-validate model
cmatrix <- confusionMatrix(validate$classe, modelValidate) ##Check accuracy
cmatrix
accuracy <- cmatrix$overall[1] ##Accuracy is not low, so this model can be used
ExpectOOSER <- 1-accuracy ##Expected out-of-sample error rate

validate$predRight <- modelValidate==validate$classe
table(modelValidate, validate$classe) ##Validation table
misclassification <- 1-sum(validate$predRight)/length(validate$classe) ##Misclassification rate
misclassification

##Predict testing dataset: activity quality
testPredict <- predict(modelFit, pml_testing_clean)

##Exploratory plot
corr <- cor(pml_training_clean[, -length(pml_training_clean)]) ##Correlation plot
corrplot(corr, order = "FPC", method = "circle",
         type = "lower", tl.cex = 0.8,  tl.col = rgb(0, 0, 0))

plot(pml_training_clean$classe, col="red", main="Barplot of Activity Quality Level in Training Set",
     xlab="Activity Quality Level", ylab="Frequency")

modelFitTree <- rpart(classe~., data=train, method="class") ##Decision tree plot
rpart.plot(modelFitTree, main="Classification Tree Diagram", extra=102, under=TRUE, faclen=0)

##Save files to submit
answers <- as.character(testPredict) ##20 Answers
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}
pml_write_files(answers)


