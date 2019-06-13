# HW 4 Due Monday Oct 2, 2017. 
# Upload R file to Moodle with name: HW4_490ID_41.R

# Your classID: 41

# Notice we are using the new system with your unique class ID. You should have received an email with
# your unique class ID. Please make sure that ID is the only information on your hw that identifies you. 

# Do not remove any of the comments. These are marked by #

################## Part 1: Linear Regression Concepts #######################

## These questions do not require coding but will explore some important concepts.

## "Regression" refers to the simple linear regression equation:
##    y = b0 + b1*x
## This homework will not discuss other models.

## 1. (1 pt)
## What is the interpretation of the coefficient B1? 
## (What meaning does it represent?)

## Your answer here
### B1 gives us the increase in y for every unit increase in x.

## 2. (1 pt)
## Outliers are problems for many statistical methods, but are particularly problematic
## for linear regression. Why is that? It may help to define what outlier means in this case.
## (Hint: Think of how residuals are calculated)

## Your answer here
### Outliers are data values that are very far (have a high residual) from the regression line (prediction).
### This is problematic since linear regression gives the coefficients of the line which minimizes the 
### residuals. Thus, outliers have higher errors and can "skew" the optimal line.  


## 3. (1 pt)
## How could you deal with outliers in order to improve the accuracy of your model?

## Your answer here

### It depends. If the outlier seems like an error (in data collection or recording) then one could remove it from the data.
### If that is not the case, one must be careful since it might be the case we need a better model.




############# Part 2: Sampling and Point Estimation #####################

## The following problems will use the cats dataset and explore
## the average body weight of female cats.

## Load the data by running the following code

install.packages("MASS")
library(MASS)
data(cats)

## 4. (2 pts)
## Subset the data frame to ONLY include female cats.

## Your answer here

female.cats =cats[cats$Sex == "F",]
head(female.cats)

## Use the sample function to generate a vector of 1s and 2s that is the same
## length as the subsetted data frame you just created. Use this vector to split
## the 'Bwt' variable into two vectors, Bwt1 and Bwt2.

## IMPORTANT: Make sure to run the following seed function before you run your sample
## function. Run them back to back each time you want to run the sample function to ensure 
## the same seed is used every time.

## Check: If you did this properly, you will have 24 elements in Bwt1 and 23 elements
## in Bwt2.

set.seed(676)
## Your answer here
dim(female.cats) 
fcats.idx = sample(c(1,2),47, replace = TRUE)
Bwt1 = female.cats$Bwt[fcats.idx==1]
Bwt2 = female.cats$Bwt[fcats.idx==2]

## 5. (3 pts)
## Calculate the mean and the standard deviation for each of the two
## vectors, Bwt1 and Bwt2. Use this information to create a 95% 
## confidence interval for your sample means (you can use the following formula 
## for a confidence interval: mean +/- 2 * standard deviation). 
## Compare the confidence intervals -- do they seem to agree or disagree?

## Your answer here
mean.Bwt1 = mean(Bwt1)
mean.Bwt2 = mean(Bwt2)

sd.Bwt1 = sd(Bwt1)
sd.Bwt2 = sd(Bwt2)

CI.Bwt1 = print(c(mean.Bwt1 -2*sd.Bwt1, mean.Bwt1+2*sd.Bwt1))
CI.Bwt2 = print(c(mean.Bwt2 -2*sd.Bwt2, mean.Bwt2+2*sd.Bwt2))



## 6. (4 pts)
## Draw 1000 observations from a standard normal distribution. Calculate the sample mean.
## Repeat this 500 times, storing each sample mean in a vector called mean_dist.
## Plot a histogram of mean_dist to display the distribution of your sample mean.
## How closely does your histogram resemble this normal distribution? Explain.

## Your answer here
set.seed(666)
mean_dist={}
for (i in 1:500){
obs = rnorm(1000)
mean_dist[i] =  mean(obs)
}
hist(mean_dist,xlab = "Mean Distribution", main = paste("Histogram of", "Mean Distribution"))


## 7. (3 pts)
## Write a function that implements Q6.

HW.Bootstrap=function(distn,nval,reps){
  set.seed(666)
  
  ### Your answer here
  mean_dist={}
  for (i in 1:reps){
    obs = do.call('distn',list(n=nval))
    mean_dist[i] =  mean(obs)
  }
  hist(mean_dist,xlab = "Mean Distribution", main = paste("Histogram of", "Mean Distribution"))
}

## Use the function you write to repeat the experiment in Q5 but instead of the
## normal distribution as we used above, use an exponential distribution with mean 1.
## Check your histogram and write out your findings.
## (Hint: HW.Bootstrap(rexp,n,reps))

## Your answer here
HW.Bootstrap(rexp,1000,500)

################### Part 3: More Linear Regression ######################

## This problem will use the Prestige dataset.
## Load the data by running code below
install.packages("car")
library(car)
data(Prestige)

## We will focus on this two variables:
## income: Average income of incumbents, dollars, in 1971. 
## education: Average education of occupational incumbents, years, in 1971

## Before starting this problem, we will declare a null hypthosesis that
## education has no effect on income .
## That is: H0: B1 = 0
##          HA: B1 != 0
## We will attempt to reject this hypothesis by using a linear regression


## 8. (2 pt)
## Fit a linear regression using of Prestige data using education to predict
## income, using lm(). Examine the model diagnostics using plot(). Would you 
## consider this a good model or not? Explain.

## Your answer here

model = lm(Prestige$income~Prestige$education)
plot(Prestige$education,Prestige$income,xlab = "Education",ylab = "Income")
abline(model)

## 9. (2 pts)
## Using the information from summary() on your model (the output from the lm() command), create a 
## 95% confidence interval for the coefficient of education variable 

## Your answer here
summary(model)
lower.bound = model$coefficients[2] - 2*summary(model)$coefficients[2,2]
upper.bound = model$coefficients[2] + 2*summary(model)$coefficients[2,2]
CI = print(c(lower.bound,upper.bound))

## 10. (2 pts)
## Based on the result from question 9, would you reject the null hypothesis or not?
## (Assume a significance level of 0.05). Explain.

## Your answer here
### I would reject the null hypothesis since the interval is far and does not contain zero. 
### Suggesting there is a relationship between education and income.



## 11. (1 pt)
## Assuming that the null hypothesis is true. 
## Based on your decision in the previous question, would you be committing a decision error? 
## If so, which type of error?

## Your answer here
### If we assume the null hypothesis is true, and we reject it we would have a Type I error (False Positive).


## 12. (1 pt)
## Discuss what your regression results mean in the context of the data.
## (Hint: Think back to Question 1)

## Your answer here
### From our model, we obtain that the intercept is  -2853.6  while beta1 is 898.8. 
### This means that for every year of education we should observe and increase in income
### equivalent to 898.8.








