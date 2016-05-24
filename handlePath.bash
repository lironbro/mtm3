#!/bin/bash

# handleNamesDates: < file >< city >
# starts searching for files that end with .flat, turns their content into lines, erases all irrelevant data from each line, and turns what's left of each line
# into an array which can be used for comparisons easily



# details: < date for comparison >< number of rooms >< rent price >< tel number >
# 			^^ for comparison ^^  ^^ for printing ^^



path=$1
city=$2
#echo in handlePath ------- path is: $path '|||' city is: $city -------


if [[ -f $path ]]; then	# if the given path in file is a file, take the lines which are relevant to the given city and translate each of them
	#echo handlePath: $path is a file!
	if [[ $path == *.flat ]]; then		# if the file ends with .flat
		#echo handlePath: $path ends with .flat!!!
		cat $path|grep -i "[0-9] $city [0-9]"|./cleanLines.bash|while read line;
		do
			#echo handlePath line is: $line
			./handleNamesDates.bash "$line"
		done
	fi
else						# if the given path in file is a directory
	#echo handlePath: $path is a directory!
	#echo the paths are:    `ls ./$path|grep /*.flat`
	ls ./$path|grep /*.flat|while read line	# read every file in it, and search for the ones that end with .flat, and translate them
	do
		./handlePath.bash $path/$line $city
	done
fi

#echo after handlePath
