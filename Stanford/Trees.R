library(rattle)
library(rpart.plot)
library(rpart)
library(randomForest)


data = read.csv("~/Downloads/ICU.csv")

set.seed(2)
lines = sample(1:200, 40)

train = data[-lines, ]
test = data[lines, ]

tree <- rpart(formula = Survive ~ AgeGroup + SysBP + Pulse + 
                       Emergency + Sex + Infection, data = train, method = "class", cp=0.00001)

fancyRpartPlot(tree, tweak = 1.2, palettes=c("Greens", "Blues"), type=2)
rpart.plot(tree)

predicted = predict(tree, train, type = "class")
table(predicted, train$Survive)
mean(predicted == train$Survive)

predicted = predict(tree, test, type = "class")
table(predicted, test$Survive)
mean(predicted == test$Survive)

my_forest <- randomForest(factor(Survive) ~  AgeGroup + SysBP + Pulse + 
                            Emergency + Sex + Infection, 
                          data=train, 
                          importance = TRUE, ntree = 1000)
varImpPlot(my_forest)

