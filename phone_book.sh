#!/bin/bash

ls people -1 | while read line;
  do
        if [[ $line =~ \.png$ ]]
         then
          echo "${line} is a pict file "
        elif [[ $line =~ \.tel$ ]]
         then
          echo "${line} is a phone file "
        elif [[ $line =~ \.name$ ]]
         then
          echo "${line} is a name file "
        elif [[ $line =~ \.work$ ]]
         then
          echo "${line} is a job desc file "
        elif [[ $line =~ \.add$ ]]
         then
          echo "${line} is a address file "
        else
          echo "${line} is something i dont know "
        fi
  done
