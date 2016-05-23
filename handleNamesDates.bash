#!/bin/bash

# handleNamesDates: < file >< city >
# starts searching for files that end with .flat, turns their content into lines, erases all irrelevant data from each line, and turns what's left of each line
# into an array which can be used for comparisons easily


# each line pre-grep: < street name > <number in street> <city name> <num of rooms> <rent price> <tel number> <date of publishing> 
# each line post-grep: <number in street> <num of rooms> <rent price> <tel number> <date of publishing> 
# to print in getApartments: < num of rooms >< price >< tel number >

# details: < date for comparison >< number of rooms >< rent price >< tel number >
# 			^^ for comparison ^^  ^^           for printing                    ^^




path=$1
city=$2


# given a path, search it for files that end with .flat | print their content | clean lines | get lines with relevant city | sort by price | erase all but numbers | read each line
find ./$path -type f -name *.flat -print|cat|./cleanLines.bash|grep -i "[0-9] $city [0-9]"|sort -bs|uniq -1|while read line;
do	# line is the line of details about the apartment, the following grep splits it up into single fields which contain numbers
	let index=0
	echo $line | grep -o "[^[:space:]]*[0-9][^[:space:]]*"|while read number;	# number will be a field in line which contains a number, as listed above in "post-grep"
	do
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
			if [ $month -lt 10 ]; do
				$month = 0$month	# turning month to a 2 digit number
			fi
			if [ $day -lt 10 ]; do
				$day = 0$day		# turning day to a 2 digit number
			fi
			details[0]=$(( day+100*month+10000*year ))	# details[0] hold the date for easier comparisons
			echo details	# prints a single array for comparisons and printing
		fi
		let index++	
	done
done

