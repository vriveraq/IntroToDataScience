#!/bin/bash


# Ask user for year to use for search 
echo "Please enter movie year to search:"


# Read user input
read yearvalue
# Display number of movies release before inputed year


# Using awk, we can count the number of movies that satisfy the given condition (<= year) and print the output
echo "Number of movies released previous to given year:"
awk -v year=$yearvalue -F',' '$4<=year { tot++ } END { print +tot}' result.csv


# Outputs second and third column (which correspond to title and rating) for the movies that satisfy the given condition (<=year)
echo "Movie information(Title and Rating):"
awk -v year=$yearvalue -F',' '$4<=year {print "Title: ", $2 ,",","Rating: " $3}' result.csv

