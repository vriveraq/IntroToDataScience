
#!/bin/bash

#Downloads the information into a html file called temp.
wget -O temp.html http://www.imdb.com/chart/top 



#Save movie title, ratings, year and rank in separate text files.


grep "title=" temp.html | grep ">.*</a>"| grep -oP "(?<=>).*(?=<)"> movietitles.txt

sed 's/^/\"/; s/$/\"/;s/,/ /g;1,2d' movietitles.txt > titles.txt	 #Removes first two entries, adds quotes and removes commas from title (for Part II)

grep "strong title=" temp.html | grep ">.*</strong>"| grep -oP "(?<=>).*(?=<)" > movieratings.txt

grep "secondaryInfo" temp.html | grep ">.*</span>"| grep -oP "(?<=\().*(?=\)<)" > movieyear.txt

grep -oP " \d+(?=\.)" temp.html > movierank.txt



#Compiles all the text files into a csv file

paste -d"," movierank.txt titles.txt movieratings.txt movieyear.txt > result.csv

