#!/bin/bash

# This script is part of Bash scripts for EPUB production #eprdctn
# url: https://github.com/gregoriopellegrino/epub-bash-scripts/
# author: Gregorio Pellegrino
# license: MIT License https://github.com/gregoriopellegrino/epub-bash-scripts/blob/master/LICENSE

# This script uses pup: https://github.com/ericchiang/pup

# DISCLAIMER
# This script uses regex for HTML manipulation: please note that HTML should not be regexed! The end is nigh.
# Use these script at your own risk!

version="1.0"
dir_path="$1"

find $dir_path -name '*.xhtml' -or -name '*.html' |
while read file_path; do
	
	echo "$file_path"
	
	for level in 1 2 3 4 5 6; do
		first_heading=$(cat $file_path | pup --charset utf8 "h$level:first-of-type text{}")
		if [ "$first_heading" != "" ]; then
			break
		fi
	done
	
	if [ "$first_heading" != "" ]; then
		first_heading=${first_heading//$'\n'/' '}
		echo -e "\tFound h$level: $first_heading"
		sed -i '' -e "s/<title>[^<]*<\/title>/<title>$first_heading<\/title>/g" $file_path
	else
		echo -e "\t[ERROR] No heading found"
	fi
	
done