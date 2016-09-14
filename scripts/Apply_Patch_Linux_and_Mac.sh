#!/bin/bash

mkdir -p old 

for a in *.delta 
do
    echo "Patching ${a%.*}.mkv"
    xdelta3 -d -q "$a"
    mv "${a%.*}".* ./old
done

