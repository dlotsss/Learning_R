# Import libraries
library(dplyr)
library(ggplot2)
library(repr)
library(rpart)

# Your train and test set loaded
Titanic.train <- read.csv(file="~/Downloads/Titanictrain.csv"
                          , header=TRUE, sep=",")
Titanic.test <- read.csv(file="~/Downloads/Titanictest.csv"
                         , header=TRUE, sep=",")

##############
#Data cleaning and new variables

# Cabin
Titanic.train_two <- Titanic.train
Titanic.train_two$CabinLevel <- NA
Titanic.train_two$CabinLevel <- substr(Titanic.train_two$Cabin, 1, 1)

Titanic.test_two <- Titanic.test
Titanic.test_two$CabinLevel <- NA
Titanic.test_two$CabinLevel <- substr(Titanic.test_two$Cabin, 1, 1)

# Costruct the Title Variable
Titanic.train_two$Title[grepl(", Mr. ", Titanic.train_two$Name)] <- "Mr"
Titanic.train_two$Title[grepl(", Dr. ", Titanic.train_two$Name)] <- "Dr"
Titanic.train_two$Title[grepl(", Mrs. ", Titanic.train_two$Name)] <- "Mrs"
Titanic.train_two$Title[grepl(", Miss. ", Titanic.train_two$Name)] <- "Miss"
Titanic.train_two$Title[grepl(", Rev. ", Titanic.train_two$Name)] <- "Rev"
Titanic.train_two$Title[grepl(", Master. ", Titanic.train_two$Name)] <- "Master"
Titanic.train_two$Title[grepl(", Ms. ", Titanic.train_two$Name)] <- "Ms"
Titanic.train_two$Title[grepl(", Lady. ", Titanic.train_two$Name)] <- "Lady"
Titanic.train_two$Title[grepl(", Mme. ", Titanic.train_two$Name)] <- "Lady"
Titanic.train_two$Title[grepl(", Mlle. ", Titanic.train_two$Name)] <- "Lady"
Titanic.train_two$Title[grepl(" Countess. ", Titanic.train_two$Name)] <- "Lady"
Titanic.train_two$Title[grepl(", Sir. ", Titanic.train_two$Name)] <- "Sir"
Titanic.train_two$Title[grepl(", Don. ", Titanic.train_two$Name)] <- "Sir"
Titanic.train_two$Title[grepl(" Jonkheer. ", Titanic.train_two$Name)] <- "Sir"
Titanic.train_two$Title[grepl(", Col. ", Titanic.train_two$Name)] <- "Millitary"
Titanic.train_two$Title[grepl(", Capt. ", Titanic.train_two$Name)] <- "Millitary"
Titanic.train_two$Title[grepl(", Major. ", Titanic.train_two$Name)] <- "Millitary"

Titanic.test_two$Title[grepl(", Mr. ", Titanic.test_two$Name)] <- "Mr"
Titanic.test_two$Title[grepl(", Dr. ", Titanic.test_two$Name)] <- "Dr"
Titanic.test_two$Title[grepl(", Mrs. ", Titanic.test_two$Name)] <- "Mrs"
Titanic.test_two$Title[grepl(", Miss. ", Titanic.test_two$Name)] <- "Miss"
Titanic.test_two$Title[grepl(", Rev. ", Titanic.test_two$Name)] <- "Rev"
Titanic.test_two$Title[grepl(", Master. ", Titanic.test_two$Name)] <- "Master"
Titanic.test_two$Title[grepl(", Ms. ", Titanic.test_two$Name)] <- "Ms"
Titanic.test_two$Title[grepl(", Dona. ", Titanic.test_two$Name)] <- "Lady"
Titanic.test_two$Title[grepl(", Col. ", Titanic.test_two$Name)] <- "Millitary"

# Clean up a new variable for cabin levels
Titanic.train_two$CabinLevel <- substr(Titanic.train_two$Cabin, 1, 1)
Titanic.train_two$CabinLevel[Titanic.train_two$CabinLevel == ""] <- "O"
Titanic.train_two$CabinLevel[Titanic.train_two$CabinLevel == "T"] <- "O"
Titanic.train_two$CabinLevel <-as.factor(Titanic.train_two$CabinLevel)

Titanic.test_two$CabinLevel <- substr(Titanic.test_two$Cabin, 1, 1)
Titanic.test_two$CabinLevel[Titanic.test_two$CabinLevel == ""] <- "O"
Titanic.test_two$CabinLevel <-as.factor(Titanic.test_two$CabinLevel)

# Clean Up Title
Titanic.train_two[is.na(Titanic.train_two$Title),]

Titanic.train_two$Title <- as.factor(Titanic.train_two$Title)
Titanic.test_two$Title <- as.factor(Titanic.test_two$Title)

predicted_age <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + 
                         Embarked + Title,
                       data = Titanic.train_two[!is.na(Titanic.train_two$Age), ]
                       , method = "anova")
Titanic.train_two$Age[is.na(Titanic.train_two$Age)] <- predict(predicted_age, 
                           Titanic.train_two[is.na(Titanic.train_two$Age),])

predicted_age <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + 
                         Embarked + Title,
                       data = Titanic.test_two[!is.na(Titanic.test_two$Age), ]
                       , method = "anova")
Titanic.test_two$Age[is.na(Titanic.test_two$Age)] <- predict(predicted_age, 
                           Titanic.test_two[is.na(Titanic.test_two$Age),])

#######################
# Decision Tree
#######################
my_tree_two <- rpart(formula = Survived ~ Pclass + Sex + Age + 
                       SibSp + Parch + Fare + CabinLevel + Title, 
                     data = Titanic.train_two, method = "class", cp=0.00001) 
#cp controls the complexity of the tree displayed default is cp =0.01

# Plot your fancy tree
library(rattle)
library(rpart.plot)

par(mfrow = c(1, 1)) # one plot per window
rpart.plot(my_tree_two)
fancyRpartPlot(my_tree_two)
fancyRpartPlot(my_tree_two, tweak=1.5) #tweak displays larger font by that %

#Check prediction in the training set
predicted <- predict(my_tree_two, Titanic.train_two, type = "class")
table(predicted, Titanic.train_two$Survived)
table(Titanic.train_two$Survived)
#Accuracy
mean(predicted == Titanic.train_two$Survived)

# Make your prediction using the test set
my_prediction <- predict(my_tree_two, Titanic.test_two, type ="class")
table(my_prediction, Titanic.test_two$Survived)

#Accuracy
mean(my_prediction == Titanic.test_two$Survived, na.rm=TRUE)

################
# Random Forest
################
#Check for NA's
summary(is.na(Titanic.train_two) == TRUE)

# Load in the package
library(randomForest)

# Set seed for reproducibility
set.seed(111)

# Turn Survived into factor
# Apply the Random Forest Algorithm
my_forest <- randomForest(factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch +
                           Fare, 
                          data=Titanic.train_two, 
                          importance = TRUE, ntree = 1000)
varImpPlot(my_forest)

# Make your prediction using `my_tree_five` and `test_new`
my_prediction <- predict(my_forest, Titanic.test_two, type = "class")

# Create a data frame with two columns: PassengerId & Survived. 
# Survived contains your predictions
my_solution <- data.frame(PassengerId = Titanic.test_two$PassengerId,
                          Survived = my_prediction, 
                          row.names = NULL)
view(my_solution)

table(my_prediction, Titanic.test_two$Survived)

#Accuracy in the test set
mean(my_prediction == Titanic.test_two$Survived, na.rm=TRUE)

#Actual Survival of passengers to compare
view(Titanic.test_two$Survived)
