#!/bin/bash

# handleNamesDates: < file >< city >
# starts searching for files that end with .flat, turns their content into lines, erases all irrelevant data from each line, and turns what's left of each line
# into an array which can be used for comparisons easily






path="$1"
city="$2"


if [[ -f "$path" ]]; then	# if the given path in file is a file, take the lines which are relevant to the given city and translate each of them
	if [[ "$path" == *.flat ]]; then		# if the file ends with .flat
		cat "$path"|grep -i "[0-9] $city [0-9]"|./cleanLines.bash|while read line;
		do
			./handleNamesDates.bash "$line"
		done
	fi
else						# if the given path in file is a directory
	ls "./$path"|grep /*.flat|while read line	# read every file in it, and search for the ones that end with .flat, and translate them
	do
		./handlePath.bash "$path/$line" "$city"
	done
fi
