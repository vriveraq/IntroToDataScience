# HW 5 - Due Tuesday October 30, 2017 in moodle and hardcopy in class. 
# Upload R file to Moodle with name: HW5_490IDS_41.R
# Do Not remove any of the comments. These are marked by #

# Please ensure that no identifying information (other than yur class ID) 
# is on your paper copy, including your name

#########################Part 1#############################

#Q1.)

#For this problem we will start with a simulation in order to find out
#how large size needs to be for the binomial distribution to be 
#approximated by the normal distribution. 


#(a)(4pts) Let's let p=0.45, use the rbinom function to generate 
# 500 observations(n = 500)
#Use 10, 30, and 50 for number of trials(size = 10,30,50). 
#Add normal curves to all of the plots. 
#Display the three histograms as well as your code below. 
#Also comment something on the shape of the histogram for each plot
set.seed(69069)
num_trials =c(10,30,50)
binom_obs = matrix(0,500,3)
for (i in 1:3){
binom_obs[,i] = rbinom(500,num_trials[i],p = 0.45)
}

par(mfrow=c(1,3))
hist(binom_obs[,1],freq=FALSE)
curve(dnorm(x, mean=mean(binom_obs[,1]),sd=sd(binom_obs[,1])),0,10,add=TRUE)
hist(binom_obs[,2],freq=FALSE)
curve(dnorm(x, mean=mean(binom_obs[,2]),sd=sd(binom_obs[,2])),0,30,add=TRUE)
hist(binom_obs[,3],freq=FALSE)
curve(dnorm(x, mean=mean(binom_obs[,3]),sd=sd(binom_obs[,3])),0,50,add=TRUE)

#(b)(3pts.) Now use the techniques described in class to improve graphs. 
# Explain each step you choose including why you are making the change. You
# might consider creating density plots, changing color, axes, 
# labeling, legend, and others for example.

### First, I add a title to each graph that indicate the number of trials used to create the distribution.
### Then I add axis labels to that explain the differences in the x-axis, and also when building the
### histogram if we want to add the normal curves we need to account for the density in the y-axis
### rather than the frequency. I've decided to plot them in a row so it is easiery to compare them
### against each other. Also, the share title is to indicate the distribution used for the histogram
### vs. the distribution used for the curve. I think it would be nice to include the mean and
### standard deviation as a legend on the curve but I am unsure on how to do that. 


par(oma=c(0,0,2,0),mfrow=c(1,3))
hist(binom_obs[,1],main="Simulation, 10 Trials",freq=FALSE,xlab = "Observations",xlim=c(0,10))
curve(dnorm(x, mean=mean(binom_obs[,1]),sd=sd(binom_obs[,1])),add=TRUE,col="blue",lwd=2)
hist(binom_obs[,2],main="Simulation, 30 Trials",freq=FALSE,xlab = "Observations",xlim=c(0,30))
curve(dnorm(x, mean=mean(binom_obs[,2]),sd=sd(binom_obs[,2])),add=TRUE,col="blue",lwd=2)
hist(binom_obs[,3],main="Simulation, 50 Trials",freq=FALSE,xlab = "Observations",xlim=c(0,50))
curve(dnorm(x, mean=mean(binom_obs[,3]),sd=sd(binom_obs[,3])),add=TRUE,col="blue",lwd=2)
title("Binomial Distribution Histogram vs. Normal Curve", outer=TRUE)

#Q2.) (2pts.)
#Why do you think the Data Life Cycle is crucial to understanding the opportunities
#and challenges of making the most of digital data? Give two examples.

### I think the Data Life Cycle is crucial to make "good science". For example, if we don't
### follow the cycle we wouldn't be able to make generalizations from a data sample to the population properly
### and this could lead to false results. Ideally, when using the cycle you would find statement that are robust, 
### and, while this is not always possible, strive to have your work and assumptions that led to your results availble publicly.
### Another example I've struggled before  is reproducing work of others because of typos in their parameters but because 
### the authors don't share their code it is almost impossible to reuse their work in other settings properly.
### Also, by making them public you advance science more efficiently that keeping them in a black box.

#########################Part 2#############################

#Q3.)Install and Load the library ElemStatLearn
# Load the data prostate into R.

install.packages("ElemStatLearn")
library(ElemStatLearn)
data(prostate)

#(a) (1 pt) Print out the structure of the dataset using str()
str(prostate)

#(b)(1 pt) What are the names of the features in the dataset?
names(prostate)

# (c). (2 pts.)
# The first eight variables are the our predictors. Subset the dataset with
# these eight variables and name it X.
X = prostate[,1:8]


# (d) (2 pts)
# Name the correlation matrix for X CorX and print it out.
CorX = cor(X)
print(CorX)

# (e) (2 pts)
# Find out the pair of variables with largest correlation
copyCorX = CorX # Make a copy 
copyCorX[lower.tri(CorX,diag = TRUE)]= 0 #Remove duplicate data
summary_cor <- as.data.frame(as.table(copyCorX)) 
idx = which(summary_cor[,3] == max(abs(summary_cor[,3]))) #Find the index which has the maximum correlation
print(summary_cor[idx,]) #Subset by the index above to also display variable names.

# (f) (2 pts)
# Use corrplot function from package corrplot to make a correlation plot 
install.packages("corrplot")
library(corrplot)
par(mfrow=c(1,1))
corrplot(CorX)

# (f) (3 pts.)
# Create a new variable called age_group: 
# if 40 < age < 50, set it to fortys, if 50 < age < 60, set it to fiftys
# if 60 < age < 70, set it to sixtys, if 70 < age < 80, set it to seventys.
# Make a barplot for this variable. 

age_group = rep(0,length(prostate$age))

for (j in 1:length(prostate$age)){
  if (40 <= prostate$age[j]  & prostate$age[j]< 50){
      age_group[j] = 40
  }
  else if (50 <= prostate$age[j]  & prostate$age[j]< 60){
      age_group[j] = 50
  }else if (60 <= prostate$age[j]  & prostate$age[j]< 70){
      age_group[j] = 60
  }else{
    age_group[j] = 70
  }
}

par(mfrow=c(1,1))
barplot(table(age_group),main="Distribution of Age Groups",xlab="Age",ylab="Frequency")

#(g) Bonus (1 pt) Can you try to make the same plot using ggplot?
library(ggplot2)
ggplot(as.data.frame(table(age_group)),aes(age_group,Freq))+geom_bar(stat="identity")+
xlab("Age groups") + ylab("Frequency") 

#########################Part 3#############################
#You can use either ggplot or normal plot method for plotting.

#4.)

#Load the dataset "titanic.csv" you downloaded from moodle, omit the NA using
#na.omit(). There are 714 observations after removing the missing values.
data_titanic = na.omit(read.csv("titanic.csv", header = TRUE))
#a.)(1 pt) First print out the str() of the dataset and think about
#          which variable need to be converted to categorical.
str(data_titanic)

### The variable survived or not could be a good categorical variable instead of an integer.

#b.(2pt) If Survived = 0, change it to "No", else change it to "Yes".
#        Replace the "Yes/No" variable to original "Survived" Variable
#       Also convert Pclass to factor.

idx_no = which(data_titanic$Survived== 0)
idx_yes = which(data_titanic$Survived== 1)
data$Survived[idx_no] = "No"
data$Survived[idx_yes] = "Yes"

data_titanic$Pclass=as.factor(data_titanic$Pclass)
data_titanic$Survived=as.factor(data_titanic$Survived)
#c.)(3 pt) Make a histogram for the Age variable and fill the 
#         histogram by Survived Variable.
#The plot is similar to 
#http://ggplot2.tidyverse.org/reference/geom_freqpoly-9.png
ggplot(data_titanic, aes(x=data_titanic$Age),xlab="Age") + geom_histogram(aes(fill=data_titanic$Survived)) +
ggtitle("Survival per Age") +
labs(x="Age",y="Count") + 
scale_fill_manual("Survival",values=c("blue","green"))

#d.) (4 pts.)
#Make a mosaic plot with Sex, Pclass, Survived variables.
#Google is your friend if you find yourself stuck. 
library(vcd)
mosaic(table(data_titanic[,c("Sex","Pclass","Survived")]),shade=TRUE,legend=TRUE)
