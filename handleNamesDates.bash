#!/bin/bash
# handleNamesDates: < line >
# reads a line from a file that ends with .flat, translating it into an array which holds the date in a format which makes comparisons easier, and the info for printing
# each line pre-grep: < street name > <number in street> <city name> <num of rooms> <rent price> <tel number> <date of publishing> 
# each line post-grep: <number in street> <num of rooms> <rent price> <tel number> <date of publishing> 
# to print in getApartments: < num of rooms >< price >< tel number >
# details: < date for comparison >< number of rooms >< rent price >< tel number >
# 			^^ for comparison ^^  ^^ for printing ^^
line=$1
let index=0
echo in handleNamesDates: line: $line 		#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< for some reason line is only the first word, not the entire street
echo $line|grep -o "[^[:space:]]*[0-9][^[:space:]]*"|while read number;	# number will be a field in line which contains a number, as listed above in "post-grep"
do
	echo number is: $number
	if [ $index -eq 1 ]; then		# if the current number is the number of rooms
		details[1]=$number
	elif [ $index -eq 2 ]; then		# if the current number is the rent price
		details[2]=$number
	elif [ $index -eq 3 ]; then		# if the current number is the phone number
		details[3]=$number
	elif [ $index -eq 4 ]; then		# if the current number is a date
		year=`echo $number|cut  -d"." --output-delimiter=" " -f3`	# take the year
		month=`echo $number|cut  -d"." --output-delimiter=" " -f2`	# take the month
		day=`echo $number|cut  -d"." --output-delimiter=" " -f1`	# take the day
		if [ $month -lt 10 ]; then
			month=0$month	# turning month to a 2 digit number
		fi
		if [ $day -lt 10 ]; then
			day=0$day		# turning day to a 2 digit number
		fi
		details[0]=$(( day+100*month+10000*year ))	# details[0] hold the date for easier comparisons
		echo details: $details	# prints a single array for comparisons and printing
		let index=0
	fi
	let index++	
done 



#NOTES:
# prints errors on /r, which is strange