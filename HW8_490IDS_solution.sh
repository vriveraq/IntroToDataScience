
#!/bin/bash


# HW 8 - Due Monday Nov 27, 2017 in moodle.
 
# Upload .sh file to Moodle with filename: HW8_490IDS_YOURCLASSID.sh

# Please make sure all the commends work well in google cloud, we will 
# test your script by choosing other arguments.  

# Hard copy report is not required for this homework.

# Do not remove any of the comments. These are marked by #

### For this assignment we will use some basic commends of UNIX / Linux.  
### The text file Homework_8.txt is uploaded to Moodle.

# You can use the following commends to run the script on google cloud:
# chmod +x HW8_490IDS_YOURCLASSID.sh
# ./HW8_490IDS_YOURCLASSID.sh Argument_1 Argument_2 Argument_3 Argument_4
# ./HW8_490IDS_solution.sh 4 Homework_8.txt make 3


# Here is a list of your input arguments:
# Argument_1: a positive number
# Argument_2: text file (Homework_8.txt)
# Argument_3: a word
# Argument_4: a positve interger which is less than 15 



# Q1. Calculate the square root of the input number(Argument_1)
#     and print your result. (5 points)
# (Hint: bc)

# install bc package
#sudo apt-get install bc 

echo "************ Q1 ************"
echo "The square root of $1:"
# Your answer here:

echo "sqrt ( $1 )" | bc -l




# Q2. Check whether your input integer(Argument_4) is even or odd 
#     and print your result. (5 points)
echo "************ Q2 ************"
# Your answer here:

rem=$(( $4 % 2 ))
 
if [ $rem -eq 0 ]
then
  echo "$4 is even number"
else
  echo "$4 is odd number"
fi


# Q3. Input a lowercase letter(Argument_3) and convert it to uppercse
#     and print your result. (5 points)
# (Hint: tr)
echo "************ Q3 ************"
# Your answer here:

echo $3 | tr a-z A-Z


# Q4. Convert the following phrase "CS 498/LIS 490/STAT 430:INTRODUCTION
#     TO DATA SCIENCE" into separate words, and put each word on its own
#     line (ignoring space,'/' and ':'). (5 points)

# The output would look like:

# CS
# 498
# LIS
# 490
# STAT
# 430
# INTRODUCTION
# TO
# DATA
# SCIENCE

echo "************ Q4 ************"
# Your answer here:


echo "CS 498/LIS 490/STAT 430:INTRODUCTION TO DATA SCIENCE"|
tr -c '[:alnum:]' '\n' 





# Q5. Sort the answer in Q4 by descending order. (5 points)

# The output would look like:

# TO
# STAT
# SCIENCE
# LIS
# INTRODUCTION
# DATA
# CS
# 498
# 490
# 430

echo "************ Q5 ************"
# Your answer here:


echo "CS 498/LIS 490/STAT 430:INTRODUCTION TO DATA SCIENCE"|
tr -c '[:alnum:]' '\n'  | sort -r




# Q6. The dataset menu.csv provides some nutrition facts for McDonald's 
#     menu, calculate how many items are there in each category
#     and print your result. (5 points)
#     (Hint: awk)

echo "************ Q6 ************"
# Your answer here:

awk -F, 'NR!=1{a[$1]++;}END{for (i in a)print i, a[i];}' menu.csv




# Q7. For your output in Q4, change the format of categories, replace "&"
#     with word "and", and connect the words by "_". 
#     For example: "Chicken & Fish" ---> "Chicken_and_Fish" (5 points)
#     (Hint: sed)

# The output would look like:

# Smoothies_and_Shakes 28
# Coffee_and_Tea 95
# Salads 6
# ......

echo "************ Q7 ************"
# Your answer here:

awk -F, 'NR!=1{a[$1]++;}END{for (i in a)print i, a[i];}' menu.csv|
sed 's/ & /_and_/g'





# Q8. Count the lines of your text file(Argument_2). (5 points)
#     (Hint: wc)

echo "************ Q8 ************"
echo "The number of lines in $2:"
# Your answer here:

line=$(wc -l < $2)
echo "$line+1" | bc -l


# Q9. Count the frequency of a input word(Argument_3) in a text 
#     file(Argument_2),and print "The frequency of word ____ is ____ ". 
#     (5 points)
#     (Hint: grep)

echo "************ Q9 ************"
echo "The frequency of word $3:"
# Your answer here:

cat $2 | grep -ow $3 | wc -l 


# Q10. Print the number of unique words in the text file(Argument_2). 
#     (5 points)

echo "************ Q10 ************"
echo "The number of unique words in text file:"
# Your answer here:

uniqwords=$(tr -c '[:alnum:]' '\n' < $2 | sort | uniq |wc -l)
echo "$uniqwords-1" | bc -l

# or

echo 'If convert all upper case letters into lower case, 
the number of unique words in text file is:' 
tr '[:upper:]' '[:lower:]' < $2 | tr -d '[:punct:]' | tr -s ' ' '\n' | sort | uniq | tail -n+2 | wc -l 


# Q11. Print the number of words that begins with letter 'a' in the 
#     text file(Argument_2) (5 points).

echo "************ Q11 ************"
echo "The number of words that begins with letter 'a':"
# Your answer here:

tr -c '[:alnum:]' '\n' < $2 | grep ^a | wc -l

# or

echo 'If convert all upper case letters into lower case, 
the number of words that begins with letter "a" is:'

tr '[:upper:]' '[:lower:]' < $2 | tr -d '[:punct:]' | tr -s ' ' '\n' | sort | grep -o '\ba\w*'| wc -l 

# or

echo 'The number of unique words that begins with letter "a" is:'

tr -c '[:alnum:]' '\n' < $2 | grep ^a |sort|uniq| wc -l



# Q12. Print top-k(Argument_4) frequent word and their frequencies.
# (Hint: uniq, sort, head) (5 points).

echo "************ Q12 ************"
echo "Top-$4 words are:"
# Your answer here:

cat $2 | tr -d '[:punct:]' | tr -s ' ' '\n' | sort | uniq -c | tail -n+2  | sort -bnr | head -$4
 
 
# or

echo "If convert all upper case letters into lower case, top-$4 words are:"


tr '[:upper:]' '[:lower:]' < $2 | tr -d '[:punct:]' | tr -s ' ' '\n' | sort | uniq -c | tail -n+2  | sort -bnr | head -$4






