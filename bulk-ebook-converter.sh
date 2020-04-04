#!/bin/sh
DIR="$1"
INTYPE="$2"
OUTTYPE="$3"

# default to current dir and input=epub, output=mobi
[ "$DIR" == "" ] && DIR="."
[ "$INTYPE" == "" ] && INTYPE="epub"
[ "$OUTTYPE" == "" ] && OUTTYPE="mobi"

# save and change IFS
OLDIFS=$IFS
IFS=$'\n'
 
# read all file name into an array
fileArray=($(find "$PWD"/$DIR -type f |grep "\.$INTYPE$"))
 
# restore it
IFS=$OLDIFS
 
# get length of an array
tLen=${#fileArray[@]}
 
# loop all files
for (( i=0; i<${tLen}; i++ ));
do
  echo "Converting ${fileArray[$i]}"
  ebook-convert "${fileArray[$i]}" "$(basename "${fileArray[$i]}" .$INTYPE).$OUTTYPE"
done

#Credits: base script inspired from https://www.cyberciti.biz/tips/handling-filenames-with-spaces-in-bash.html
