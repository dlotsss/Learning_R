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

h = outer(x,y,function (x,y)cos(y)/(1+x^2))
contour(x,y,h) #more sophisticated graphs

# 1) Define grid
i <- seq(-pi, pi, length = 50)
j <- seq(-pi, pi, length = 50)

# 2) Compute heights: e.g. z = cos(x)*sin(y)
k <- outer(j, i, function(j, i) cos(i) * sin(j)) #this returns a matrix where values are products of cosi*sinj
#     note: outer rows correspond to j, columns to i

# 3) Plot contours
contour(i, j, k,
        levels = seq(-1, 1, by = 0.2),
        drawlabels = TRUE,
        col = "blue",
        lwd = 2,
        xlab = "I axis",
        ylab = "j axis",
        main = "Contour of cos(i)*sin(j)")
image(i, j, k) #produces heatmap 
persp(i, j, k, theta =30, phi=70 ) #produces 3dimensional plot and theta and phi help control the angles through which the plot is viewed 

#INDEXING DATA
A = matrix(1:16, 4, 4)
A[2,3] #this works just as usual matrix, it shows 2nd row and 3rd column
A[c(1,3), c(2,4)] #it is like 1;2, 1;4, and 3;2, 3;4
A[1:3,2:4] #1;2, 2;2, 3;2 and so on 
A[1:2,] #take rows 1 to 2 and every column 
A[-c(1,3),] #keep everything except those indicated in the index because of - sign
dim(A) #outputs the number of rows and columns of given matrix 

#LOADING DATA
Auto = read.table("~/Downloads/algoritmika/python pro 1 year/Дасаева София PP/Learning_R/Stanford/Auto.data", header=T, na.strings="?") #means that this data sets has headers and that ? indicate missing values
fix(Auto)
#if its csv file, we might use read.csv()

Auto = na.omit(Auto) #because there are only 5 missing values, we can just remove those 
names(Auto) #tells the variables names 



