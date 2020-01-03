#!/bin/bash




if [[ ! $1 ]]; then
	echo Enter commit message...
	read -r \n  MESSAGE
	echo $MESSAGE
else
	MESSAGE=$1
fi

git add -A
git commit -m $MESSAGE
git push  origin HEAD



