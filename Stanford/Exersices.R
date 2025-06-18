knitr::opts_chunk$set(echo = TRUE)

College = read.csv("~/Downloads/algoritmika/python pro 1 year/Дасаева София PP/Learning_R/Stanford/College.csv")

rownames(College) = College[,1]
College= College[,-1] 

summary(College)
pairs(College[,2:11])
attach(College)
Private = as.factor(Private)
plot(Private, Outstate,
     col      = "green",
     varwidth = TRUE,
     xlab     = "Private?",
     ylab     = "Out-of-state Tuition")

attach(College)
Elite = rep("No", nrow(College))
Elite[Top10perc>50]="Yes"
Elite=as.factor(Elite)
College = data.frame(College, Elite)
summary(Elite)


plot(Elite, Outstate,
     col      = "red",
     varwidth = TRUE,
     xlab     = "Elite?",
     ylab     = "Out-of-state Tuition")
par(mfrow = c(2,2), mar = c(4,4,2,1))
hist(College$Apps,      breaks = 30, col = "lightblue", main = "Apps")
hist(College$Accept,    breaks = 30, col = "lightblue", main = "Accept")
hist(College$Enroll,    breaks = 30, col = "lightblue", main = "Enroll")
hist(College$Outstate,  breaks = 30, col = "lightblue", main = "Out-of-State Tuition")
par(mfrow = c(1,1))

Auto = read.table("~/Downloads/algoritmika/python pro 1 year/Дасаева София PP/Learning_R/Stanford/Auto.data", header=T, na.strings="?") #means that this data sets has headers and that ? indicate missing values
#if its csv file, we might use read.csv()

Auto = na.omit(Auto)

cylinders = as.factor(cylinders)

# numeric columns
quantitative <- names(Auto)[ sapply(Auto, is.numeric) ]

# factor/character columns
qualitative  <- names(Auto)[ sapply(Auto, function(x) is.factor(x) || is.character(x)) ]

quantitative
qualitative

ranges <- sapply(Auto[, quantitative], range, na.rm = TRUE)
ranges
means <- sapply(Auto[ , quantitative], mean, na.rm = TRUE)
means

sds   <- sapply(Auto[ , quantitative], sd,   na.rm = TRUE)
sds
NewAuto = Auto[-(10:85), ]
Newranges <- sapply(NewAuto[ , quantitative], range, na.rm = TRUE)
Newmeans  <- sapply(NewAuto[ , quantitative], mean,  na.rm = TRUE)
Newsds    <- sapply(NewAuto[ , quantitative], sd,    na.rm = TRUE)

Newranges

Newmeans

Newsds
pairs(Auto[ , quantitative],
      panel = panel.smooth,
      main  = "Scatterplot Matrix of Quantitative Predictors")


par(mfrow = c(2,2), mar = c(4,4,2,1))
plot(Auto$horsepower, Auto$mpg,
     xlab = "Horsepower", ylab = "MPG",
     main = "MPG vs Horsepower")
plot(Auto$weight,     Auto$mpg,
     xlab = "Weight",     ylab = "MPG",
     main = "MPG vs Weight")
plot(Auto$displacement, Auto$mpg,
     xlab = "Displacement", ylab = "MPG",
     main = "MPG vs Displacement")
plot(Auto$year, Auto$mpg,
     xlab = "Model Year",  ylab = "MPG",
     main = "MPG vs Year")
par(mfrow = c(1,1))

correlations <- cor(Auto[ , c("mpg", quantitative)])
round(correlations["mpg", ], 2)

library(MASS)
Boston
dim(Boston)

pairs(Boston,
      panel = panel.smooth,
      main  = "Scatterplot Matrix of Predictors")

cors <- cor(Boston)
crime_corrs <- sort(cors["crim", ], decreasing = TRUE)
round(crime_corrs, 2)

top_crime <- Boston[order(-Boston$crim), "crim"][1:5]
top_tax   <- Boston[order(-Boston$tax),   "tax"][1:5]
top_ptr   <- Boston[order(-Boston$ptratio),"ptratio"][1:5]

top_crime
top_tax
top_ptr

ranges <- sapply(Boston, range, na.rm = TRUE)
ranges 

n_chas <- sum(Boston$chas == 1)
n_chas
med_ptr <- median(Boston$ptratio)
med_ptr
idx_minmedv <- which.min(Boston$medv)
sub_minmedv <- Boston[idx_minmedv, ]
sub_minmedv

n_gt7 <- sum(Boston$rm > 7)
n_gt8 <- sum(Boston$rm > 8)
 n_gt7
 n_gt8
