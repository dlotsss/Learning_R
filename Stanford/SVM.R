####SVM for Loan Defaults###
## Set Up

#install.packages("e1071")
library(e1071)
#install.packages("caret")
library(caret)
library(lattice)

#data
#install.packages("ISLR2")
library(ISLR2)

# Usual data manipulation and plotting
library(readr)
library(dplyr)
library(ggplot2)

# Set the parameters for the plot sizes for all plots below
options(repr.plot.width=9, repr.plot.height=6)

## Data

data(Default)
Default$default <- ifelse(Default$default == "Yes", 1, 0)
head(Default)
mean(Default$default)


#Split the data into a training and test sets, maintaining the same survival percentage in train and test (80%).
#the same method I used at my accessibility data set 
prop.index <- createDataPartition(Default$default, p = 0.8,
                                  list = FALSE,                            
                                  times = 1)
#
Default.train <- Default[prop.index, ]
Default.test <- Default[-prop.index, ]

## SVM

model_svm <- svm(default ~ student + balance + income 
                       , data = Default.train, cost = 10)
predict_svm <- predict(model_svm, Default.train)

#Results: In sample RMSE

sqrt(mean((Default.train$default - predict_svm)^2))

#Out sample RMSE:

#out sample prediction and RMSE
predict_svm_test <- predict(model_svm, Default.test) 
sqrt(mean((Default.test$default - predict_svm_test)^2)) 

## ROC
#Compare ROC and AUC for the model

#install.packages("pROC")
library("pROC")
roc.svm <- roc(Default.test$default, predict_svm_test, plot = TRUE, 
               legacy.axes = TRUE, percent =TRUE, 
               xlab = "True Positive %", ylab = "False Positive %", 
               col = "blue", lwd = 4, # line thickness
               print.auc = TRUE ) #this tells the area under the graph 

#because the curve is above the line, we can tell that it is better than random guess. It is right 85.9% of time

roc.svm.df <- data.frame(
    tpp = roc.svm$sensitivities, #true positive %
    fpp = (100 - roc.svm$specificities), #false positive %
    thresholds = roc.svm$thresholds
)
head(roc.svm.df)
