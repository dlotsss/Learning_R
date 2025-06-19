# kNN for Iris Data
library(ggplot2)
library("class")

# load the data
data(iris)


set.seed(12L)
tr <- sample(150, 50)
nw <- sample(150, 50)


knn.result <- knn(iris[tr, -5], iris[nw, -5], iris$Species[tr]
                  ,  k = 3, prob = TRUE
)
table(knn.result, iris$Species[nw])

qplot(iris$Petal.Length[nw], iris$Petal.Width[nw], 
           col = iris$Species[nw], 
           shape = knn.result)

mean(knn.result == iris$Species[nw]) #accuracy

