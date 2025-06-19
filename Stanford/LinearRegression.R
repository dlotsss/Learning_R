library(ggplot2)
library(tibble)

#get some data to explore
Auto <- read.csv("~/IntroDataScience/ISLRBook/Data/Auto.csv",
                 header=T,na.strings="NA")
#attach(Auto) # can run into trouble with other global variables
# Clean it up
view(Auto) # Check the type of the horsepower variable
Auto$horsepower <- as.numeric(Auto$horsepower)
Auto <- na.omit(Auto)

###################
# Correlation
###################
pairs(Auto[,-c(9)])

# Scatterplot of the data
ggplot(Auto, aes(x=acceleration, y=mpg)) +
  geom_point(shape=1)      # Use hollow circles

cor(Auto$mpg,Auto$weight)

##########################
# Linear Regression
##########################

fit <- lm(Auto$mpg ~ Auto$weight + Auto$cylinders + Auto$horsepower)
summary(fit)

#or in one line
summary(lm(Auto$mpg ~ Auto$weight))

# Scatterplot of the data
ggplot(Auto, aes(x=weight, y=mpg)) +
  geom_point(shape=1)      # Use hollow circles

# Add regresion line
ggplot(Auto, aes(x=weight, y=mpg)) +
  geom_point(shape=1) +    # Use hollow circles
  geom_smooth(method=lm, se=FALSE)   # Add linear regression line 
#  (by default includes 95% prediction region, set se = FALSE to remove)

#Multi variate regression for the Auto data
summary(lm(Auto$mpg ~ Auto$weight + Auto$cylinders + Auto$horsepower))

########################
# Assessing the Model
########################

# Residual plots
plot(fit)

#analysis of variance
anova(fit)
