# HW 3 - Due Monday  Oct 2, 2017. Upload R file to Moodle with name: HW3_490IDS_41.R
# Do Not remove any of the comments. These are marked by #
# The .R file will contain your code and answers to questions.

#ClassID:41

# Main topic: Using the "apply" family of functions

#Q1 (5 pts)
# Given a function below,
myfunc <- function(z) return(c(z,z^2,(z^2+z)%/%2))
#(a) explain in words what myfunc is doing.
### myfunc(z) takes a number and returns a vector containing the input z, it's square, and its squate plus itself
### divided by two (rounded to the nearest lowest integer), (i.e. [z,z^2,(z^2+z)/2]).

#(b) Examine the following code, and briefly explain what it is doing.
y = 1:8
myfunc(y)
matrix(myfunc(y),ncol=3)

### Your explanation here
### This code is taking the data vector [1,2,3,4,5,6,7,8] and using it as the input for the previous
### function myfunc(z), but by using matrix() with ncol = 3, it arranges the output into a 
### matrix with 3 coloumns (one for each element in the vector returned by myfunc()).


#(c) Simplify the code in (b) using one of the "apply" functions and save the result as m.
###code & result
m = t(mapply(myfunc,y))

#(d) Find the column product of m.
###code & result
apply(m,2,prod)



#(e) Find the row sum of m in two ways.
###code & result
apply(m,1,sum)



#(f) Multiply all the values by 2 in two different ways:
### 1. code & result
2*m

### 2. code & result
times2.func <- function(z) return (2*z)
apply(m,c(1,2),times2.func)


#Q2 (10 pts)
#Create a list l with 2 elements as follows:
l <- list(a = 1:10, b = 21:30)

#(a) What is the sum of the values in each element?
###code & result
sum.element  = mapply(sum,l)

#(b) What is the (sample) variance of the values in each element?
###code & result
var.elements = mapply(var,l)

#(c) Use the help() function to check what type of output object will you expect if you use sapply and lapply. 
# Show your R code that finds these answers and briefly explain if the results agree with your expectation.

###code
class(sapply(l,sum))
class(lapply(l,sum))

###written explanation
### When looking at the documentation for both functions we see that lapply () returns a list
### while sapply() returns a vector or matrix which then when we apply the class() function ,
### we see by using sapply() we get "integer" and with lapply() we get an list as expected.



#(d) Change one of them to make the two statement return the same results (type of object):
###code & result
class(sapply(l,sum, simplify=FALSE))


# Now create the following list:
l.2 <- list(c = c(11:20), d = c(31:40))

#(e) What is the sum of the corresponding elements of l and l.2, using one function call? Your result should be a 
# single vector with length 10.
###code & result
apply(simplify2array(c(l,l.2)),1,sum)


#(f) Take the log of each element in the list l:
###code & result

mapply(log,l)

#(g) First change l and l.2 into matrixes, make each element in the list as column,
###code & result
l = simplify2array(l)
l.2 = simplify2array(l.2)

#Then, form a list named mylist using l,l.2 and m (from Q1) (in that order).
###code & result

mylist = list(l,l.2, m)
#Then, select the second column of each elements in mylist in one function call (hint '[' is the select operator).
###code & result

lapply(mylist,'[',i=,j=2)
#or 
lapply(mylist,'[',c(1:10,2))

#Q3 (3 pts)
# Let's load the family data again.
load(url("http://courseweb.lis.illinois.edu/~jguo24/family.rda"))
#(a) Find the mean bmi by gender in one function call.
###code & result
tapply(family$bmi,family$gender, mean) 

#(b) Could you get a vector of what the type of variables the dataset is made of？
###code & result
mapply(class, family)

#(c) Could you sort the firstName in bmi descending order?
###code & result
family$firstName[order(family$bmi,decreasing = TRUE)]
#tapply(as.character(family$firstName),family$bmi, function(x) sort(x, decreasing = FALSE))
#not sure why it doesn't sort it decreasingly with tapply()

#Q4 (2 pts)
# There is a famous dataset in R called "iris." It should already be loaded
# in R for you. If you type in ?iris you can see some documentation. Familiarize 
# yourself with this dataset.
#(a) Find the mean petal width by species.
### code & result
tapply(iris$Petal.Width, iris$Species, mean) 


#(b) Now obtain the mean of the first 4 variables, by species, but using only one function call.
### code & result
by(iris[,1:4], iris$Species, colMeans) 


#Q5. (5 pts) Now with the "iris" data, fit a simple linear regression model using lm() to predict 
# Petal length from Petal width. Place your code and output (the model) below. 
model <- lm(Petal.Length ~ Petal.Width, data=iris)
model

# How do you interpret this model?
### This model assumes we can find a linear relation between the petal width and its length. By fitting the data to,
### to a linear regresion model we can find the coefficient of the line that describes the relationship.
### In our case, we obtaine  1.084 for the intercept and 2.230 for the coefficient of x. This tells us
### we have a positive linear relationship and that petal length is roughly 2.5 times larger as its width.
### so I would expect that if the petal width is 1, then the petal length is approximetly 3.3.

# Create a scatterplot of Petal length vs Petal width. Add the linear regression line you found above.
# Provide an interpretation for your plot.
### code & result
plot(iris$Petal.Width,iris$Petal.Length, xlab= 'Petal Width', ylab = 'Petal Length')
abline(model$coefficients, col="red")

