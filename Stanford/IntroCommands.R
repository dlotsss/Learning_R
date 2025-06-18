### vectors, data, matrices, subsetting
x <- c(2,7,5)
x
y <- seq(from=4,length=3,by=3) 
my.data <- as.data.frame(cbind(x,y))

# <- and = is the same, but == is still comparison

?seq
y
t <- x+y
x/y
x^y
x[2]
x[2:3]
x[-2]
x[-c(1,2)]
z=matrix(seq(1,12),4,3)
z
z[3:4,2:3]
z[,2:3]
z[,1]
z[,1,drop=FALSE]
dim(z)
ls()
rm(y)
rm(x,z,t)
ls()
### Generating random data, graphics
x = runif(50) #random values from uniform distribution
y = rnorm(50) #random from normal distributions
plot(x,y)
plot(x,y,xlab="Random Uniform",ylab="Random Normal",pch="*",col="blue")
par(mfrow=c(2,1)) #what parameter the function should be assigned as vector
plot(x,y)
hist(y)
par(mfrow=c(1,1))
plot(x,y)
### Reading in data
Auto <- read.csv("~/Downloads/Auto.csv") #give correct path
names(Auto)
dim(Auto)
class(Auto)
summary(Auto)
plot(Auto$cylinders,Auto$mpg)
#install.packages("ISLR")
#library(ISLR)
attach(Auto)
search()
plot(cylinders,mpg)
cylinders=as.factor(cylinders)
plot(Auto$cylinders,Auto$mpg,xlab="Cylinders",ylab="Mpg",col="red")
# pdf(file="../mpg.pdf")
# plot(cylinders,mpg,xlab="Cylinders",ylab="Mpg",col="red")
# dev.off()
pairs(Auto) 
pairs(Auto[ ,-c(4,9)])
Auto$horsepower <- as.numeric(Auto$horsepower)
pairs(Auto[ ,-c(9)])
pairs(mpg~cylinders+acceleration+weight,Auto)

### Adding Library packages
# DO this once to install a package, 
# or follow the menus in RStudio Tools > Install Package
# install.packages("MASS")
library(MASS)
data(Boston)
View(Boston)
### Quit R Studio 
# q()