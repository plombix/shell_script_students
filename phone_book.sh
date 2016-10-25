#!/bin/bash

num_of_files=$( ls -l people | wc -l )

for (( c=0; c<=$num_of_files; c++ ))
do
  ls people -1 | while read line;
    do
      if [[ $line = $c* ]]
        then
         if  [[ $line =~ \.name$ ]]
           then
           echo "${line} is a the card's nb ${c} name :"
           cat "people/${line}"
         elif  [[ $line =~ \.png$ ]]
           then
           echo "${line} is a the card's nb ${c} pict"
         elif  [[ $line =~ \.tel$ ]]
           then
           echo "${line} is a the card's nb ${c} phone data :"
            cat "people/${line}"
         elif [[ $line =~ \.work$ ]]
           then
           echo "${line} is a the card's nb ${c} job description :"
            cat "people/${line}"
         elif  [[ $line =~ \.add$ ]]
           then
           echo "${line} is a the card's nb ${c} address :"
            cat "people/${line}"
         else
           echo "${line} is something i dont know "
         fi
       fi
    done
done
