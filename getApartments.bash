#!/bin/bash

# getApartments: < file >< city >< limit >


#	check if valid number of parameters was given
if [ $# -eq 0 ] || [ $# -eq 2 ] || [ $# -gt 3 ]; then
	echo Illegal or missing parameters
	exit
fi


#	check if the file for searching exists
if [[ `ls | grep -c $1` == 0 ]]; then
	echo File is missing
	exit
fi


#	set the values of city and limit to be those given, or default
if (($# == 1)); then
	city=haifa
	limit=1
else
	city="$2"
	limit=$3
fi

if [[ $limit -le 0 ]]; then
	echo Illegal or missing parameters
	exit
fi



# gets the content in source | cleans its lines <<<<< MISSES FIRST LINE| reads each line and gets its content 
./cleanLines.bash "$1" | while read path; do
	#echo path is $path
	./handlePath.bash "$path" "$city"
done |sort -s|uniq -i|rev|cut -d" " -f 1-4|rev|sort -nsk 2,2|head -$limit|sort -rnsk 4,4|cut -d" " -f 1-3| cat
# sorts by price | keeps the limit cheapest lines | sorts by date | removes the date field | prints
