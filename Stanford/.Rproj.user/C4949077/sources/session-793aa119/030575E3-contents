#BASIC COMMANDS 
#vectors 
x = c(1, 3, 4)
y = c(2, 6, 8)

#if x and y are the same length, we can add it and it will add the first number from x to the first number from y, and so on.
x+y

ls() #shows everything that we have now 
#rm(x, y) #deletes something we don't need OR use rm(list=ls()) to delete everything

a = matrix (data=c(1,2,3,4), nrow=2, ncol=2, byrow=TRUE) #or just matrix(c(1,2,3,4) ,2,2)
a
#because of byrow=TRUE it numerates like 1st row, then 2nd row. As default it makes it by columns

sqrt(a) #returns matrix with sqrt of each value 
a^2 #returns matrix with each value being in the power of 2

c = rnorm(50) #by default creates standard normal random variables with a mean of 0 and a standard deviation of 1; 50 is sample size
d = rnorm(50, mean=50, sd=.1) #the mean and standard deviation can be altered using the mean and sd arguments
cor(c, d) #shows correlation between them 

set.seed(3) #this command allows us to generate the same random number each time we generate random number
e = rnorm(5)

mean(e) #compute the mean of vector e
var(e) #computes the дисперсия (variance) of vector e 
sqrt(var(e)) #= sd(e) which is standard deviation


# GRAPHICS 
plot(x, y) #plots basic scatterplot of numerbs in x vs y
plot(x,y,xlab="this is the x-axis",ylab="this is the y-axis",
     main="Plot of X vs Y") #this will give names to the axis and to the scatterplot overall

#this allows to save the plot as a file. Now I have a fugure.pdf with this graph in green. I can also save it as jpeg()
pdf("Figure.pdf")
plot(x,y, col="green")
dev.off() #indicates that we are done with creating the plot 

f = seq(1, 10) #makes sequence of integers from 1 to 10 OR just write f=1:10
g = seq(1, 2, length=10) #makes a sequence of 10 numbers that are equally spaced between 0 and 1


