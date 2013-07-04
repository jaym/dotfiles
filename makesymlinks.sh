#!/bin/bash

for file in `ls -A | grep '^\.' | grep -v .git` 
do 
	ln -s $file ~/$file
done
