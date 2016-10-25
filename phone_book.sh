#!/bin/bash

ls people -1 | while read line;
  do
      echo "One file is named  ${line}"
      if [[ $line =~ \.png$ ]]
        then
         echo "${line} is a pict file "
       fi
  done
