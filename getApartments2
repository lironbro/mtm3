#!/bin/bash


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
	city=$2
	limit=$3
fi



echo before loop ##################################### gets stuck in the loop, maybe because of the "cat" command


#	reads the lines and adds the date at the beginning for easy comparisons
let index=3
let lineLength=9
let dateLength=3
#	finds all files that end with .flat | remove notes | take only lines that include the city | sort them | remove duplications | read lines


cat ./$1 | find -name *.flat -type f -print | cat | cut -d"#" -f1 | grep -i "$city" | sort -s | uniq -i | cat  # test for what the while loop gets



find ./$1 -name "*.flat" -print | cat | cut -d"#" -f1 | grep -i "$city" | sort -s | uniq -i | while read line; do
	if 	[ $index -eq 0 ]; then
		apartment[0]=`echo $line|cut -d"." --output-delimiter=" " -f3`		# year
		apartment[1]=`echo $line|cut -d"." --output-delimiter=" " -f2`		# month
		apartment[2]=`echo $line|cut -d"." --output-delimiter=" " -f1`		# day
		let index=2
	else 
		apartment[index]=$line;
	fi
	if [ $index -eq $lineLength ]; then	# year, month, day, and the rest of the apartment details, should be 9
		let index=0
	fi
	if [ $index -eq $dateLength ]; then
		echo ${apartment[*]};
	fi
	let index++
done| sort -nsk 8,8 | head -$limit | sort -rnsk 3,3 | sort -rnsk 2,2 | sort -rnsk 1,1 | cut -d" " -f7,8,9 | cat
#	sort by price | limit best apartments | sort by day | sort by month | sort by year  | keep only number of rooms, price and phone number | print

echo after loop #####################################
