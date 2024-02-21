#!/bin/bash
# Name: Ellis Guo
# Student Number: 261133980
if [[ $1 = backup ]]
then
	#ex2.1
	realpath "$0"
	ls *.txt 
	
	#ex2.2
	mkdir backup
	cd backup
	echo Moved to backup directory
	realpath "$0"

	#ex2.3
	cp -r $(dirname "$PWD")/*.txt $PWD
	echo Copied all text files to backup directory

	#ex2.4
	echo Current backup: > date.txt
	echo $(date) >> date.txt
	cat date.txt

elif [[ $1 = archive ]]
then
	if [ -n "$2" ]
	then
		#ex3.2
		today=$(date +"%Y-%m-%d")
		tar -cvzf archive-$today.tgz *"$2"
		echo Created archive archive-$today.tgz
		ls -l
	else
		#ex3.1
		echo -e "Error: Archive task requires file format \nUsage: ./setup.sh archive <fileformat>"
	fi

elif [[ $1 = sortedcopy ]]
then
	if [ -n "$3" ]
	then 
		if [[ -d "$2" ]]
		then
			if [[ -d "$3" ]]
			then
				#ex4.3
				echo -e "$ ./setup.sh sortedcopy "$2" "$3" \nDirectory '"$3"' already exists. Overwrite? (y/n)"
				read yn
					if [[ $yn == y ]]
					then
						# the directory gets removed and recreated
						rm -r "$3"; mkdir "$3"
					else
						exit 3
					fi
			else
				mkdir "$3"
			fi
			
			# copying all files from source directory to target directory
			# "$2"/* comes with an error if the directory is empty so it redirects to null
			cp -r "$2"/* "$3"/ 2>/dev/null
			cd "$3"

			# to avoid getting files from other subdirectories, mindepth and maxdepth are used
			# all type d directories are removed
			find . -maxdepth 1 -mindepth 1 -type d -exec rm -rf '{}' \;
			
			# ls -r * prints the remaining files in reverse alphabetical order since the default is alphabetical
			n=1
			for f in $(ls -r * 2</dev/null);
			do
				# renames the file and prepends a number to the file name
				mv "$f" "$((n++)).$f" 
			done
			exit 0

		else 
			#ex4.1 - exit code 2
			echo -e "$ ./setup.sh "$2" "$3" \nError: Input parameter #2 '"$2"' is not a directory. \nUsage: ./setup.sh sortedcopy <sourcedirectory> <targetdirectory>"
			exit 2
		fi
	else 
		#ex4.1 - exit code 1
		echo -e "$ ./setup.sh sortedcopy \nError: Expected two additional input parameters. \nUsage: ./setup.sh sortedcopy <sourcedirectory> <targetdirectory>"
		exit 1
	fi	
else 
	#ex1
	echo -e "Task must be specified. Supported tasks: backup, archive, sortedcopy. \nUsage: ./setup.sh <task> <additional_arguments>"	
fi
