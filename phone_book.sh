#!/bin/bash

ls people -1 | while read line;
  do
      echo "One file is named  ${line}"
  done
