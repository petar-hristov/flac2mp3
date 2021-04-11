#!/usr/bin/env bash

#store start path in case of relative path arguments
start_path=$PWD

#get arguments; convert possible relative paths to absolute paths
if [[ $# -gt 0 ]]
then
	path=$1
else
	path=.
fi
cd "$path"
path=$PWD
cd "$start_path"

if [[ $# -gt 1 ]]
then
	out_path=$2
else
	out_path=.
fi
cd "$out_path"
out_path=$PWD
cd "$start_path"


#install ffmpeg with homebrew if not present
if ! 'ffmpeg';then
     echo 'ffmpeg not installed, installing now; please install manually if unsuccessful'
     brew install ffmpeg
fi


#create lists only on new line breaks rather than spaces
IFS=$'\n'

#create directory tree structure
mkdir -p "$out_path"
cd "$path"
ls -R | grep :$ | sed 's/\.\/\(.*\):$/\1/' | while read thisFolder; do mkdir -p "mp3_converted"/"$thisFolder"; done

#loop through folders in main directory
for album in $(ls "$path");
do
	
	#find all tracks, regardless of the individual folder nesting structure (handles multiple subdirectories)
	new_var=$(find "$path"/"$album" -type f -follow -print)
	
	for track in $new_var;
	do
		
		if [[ ${track: -5} == .flac ]]
		then
			
			#substitution performed here
			unprocessed_string=${track/"$album"/"mp3_converted/$album"}
			final_path=${unprocessed_string%flac}mp3
			
			#convert to mp3
			ffmpeg -i "$track" -ab 320k -map_metadata 0 -id3v2_version 3 "$final_path"
		fi
	
	done

done

#move the entire output folder to our desired path
mv mp3_converted/ "$out_path"




