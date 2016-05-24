#!/bin/bash
# handleNamesDates: < line >
# reads a line from a file that ends with .flat, translating it into an array which holds the date in a format which makes comparisons easier, and the info for printing
# each line contains: < street name > < number in street > < city name > < num of rooms > < rent price > < tel number > < date of publishing > 
# details: < street name > <number in street> <city name> <num of rooms> <rent price> <tel number> <date for comparison>  
# to print in getApartments: < num of rooms >< price >< tel number >


line=$1
let index=0


echo $line|grep -o "[^[:space:]][^[:space:]]*"|while read word;
do
	if [ $index -eq 6 ]; then		# if the current word is a date
		year=`echo $word|cut  -d"." --output-delimiter=" " -f3`	# take the year
		month=`echo $word|cut  -d"." --output-delimiter=" " -f2`	# take the month
		day=`echo $word|cut  -d"." --output-delimiter=" " -f1`	# take the day
		if [ $month -lt 10 ]; then
			month=0$month	# turning month to a 2 digit word
		fi
		if [ $day -lt 10 ]; then
			day=0$day		# turning day to a 2 digit word
		fi
		details[6]=$year$month$day	# details[0] hold the date for easier comparisons
		echo ${details[*]}	# prints a single array for comparisons and printing
		let index=0
	else
		if ((index>0&&word==0&&details[1]==0)); then
			details[0]=${details[0]}" "$word
			let index--
		else
			details[$index]=$word
		fi
	fi
	let index++	
done 

