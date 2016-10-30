
#!/bin/bash
# http://csvlint.io/
#
# ls people -1 | while read line;
#   do
#     if [[ $line =~ \.png$ ]]
#      then
#       echo "${line} is a pict file "
#     elif [[ $line =~ \.tel$ ]]
#      then
#       echo "${line} is a phone file "
#     elif [[ $line =~ \.work$ ]]
#      then
#       echo "${line} is a job desc file "
#     elif [[ $line =~ \.add$ ]]
#      then
#       echo "${line} is a address file "
#     else
#       echo "${line} is something i dont know "
#     fi
#   done

# num_of_files=$( ls -l people | wc -l )
# for (( c=0; c<=$num_of_files; c++ ))
# do
#   ls people -1 | while read line;
#     do
#       if [[ $line = $c* ]]
#       then
#        echo "${line} is a card  nb ${c} concern"
#      fi
#     done
# done


# num_of_files=$( ls -l people | wc -l )
#
# for (( c=0; c<=$num_of_files; c++ ))
# do
#   ls people -1 | while read line;
#     do
#       if [[ $line = $c* ]]
#         then
#          if  [[ $line =~ \.png$ ]]
#            then
#            echo "${line} is a the card's nb ${c} pict"
#          elif  [[ $line =~ \.tel$ ]]
#            then
#            echo "${line} is a the card's nb ${c} phone data "
#          elif [[ $line =~ \.work$ ]]
#            then
#            echo "${line} is a the card's nb ${c} job description"
#          elif  [[ $line =~ \.add$ ]]
#            then
#            echo "${line} is a the card's nb ${c} address"
#          else
#            echo "${line} is something i dont know "
#          fi
#        fi
#     done
# done
# num_of_files=$( ls -l people | wc -l )
# for (( c=0; c<=$num_of_files; c++ ))
# do
#   ls people -1 | while read line;
#     do
#       if [[ $line = $c* ]]
#         then
#          if  [[ $line =~ \.name$ ]]
#            then
#            echo "${line} is a the card's nb ${c} name :"
#            cat "people/${line}"
#          elif  [[ $line =~ \.png$ ]]
#            then
#            echo "${line} is a the card's nb ${c} pict"
#          elif  [[ $line =~ \.tel$ ]]
#            then
#            echo "${line} is a the card's nb ${c} phone data :"
#             cat "people/${line}"
#          elif [[ $line =~ \.work$ ]]
#            then
#            echo "${line} is a the card's nb ${c} job description :"
#             cat "people/${line}"
#          elif  [[ $line =~ \.add$ ]]
#            then
#            echo "${line} is a the card's nb ${c} address :"
#             cat "people/${line}"
#          else
#            echo "${line} is something i dont know "
#          fi
#        fi
#     done
# done
#!/bin/bash

num_of_files=$( ls -l people | wc -l )
echo "creating HTML5 file"
touch "people/phone_book.html"
echo "<!DOCTYPE html>
<html>
<head>
 <meta charset='UTF-8'>
 <title>Phone_book</title>
</head>

<body>" > people/phone_book.html
for (( c=0; c<=$num_of_files; c++ ))
do
  ls people -1 | while read line;
    do
      if [[ $line = $c* ]]
        then
         if  [[ $line =~ \.name$ ]]
           then
           echo "$line is a the card's nb $c name :"
           name=$(cat "people/$line")
           echo "<p class='fn'><a class='url' href='http://www.google.com/search?q=${name}'>${name}</a><p>">> people/phone_book.html
         elif [[ $line =~ \.work$ ]]
           then
           echo "$line is a the card's nb $c job description :"
            cat "people/$line"
            job=$(cat "people/$line")
            wikijob=$(cat "people/$line" | sed 's/ /+/g')
            echo "<p class='fn'><a class='url' href='https://fr.wikipedia.org/w/index.php?search=${wikijob}'>${job}</a><p>">> people/phone_book.html
         elif  [[ $line =~ \.png$ ]]
           then
           echo "$line is a the card's nb $c pict"
            echo "<img src='$line' alt='${name}' height='100' width='100'>">> people/phone_book.html
         elif  [[ $line =~ \.add$ ]]
           then
           echo "$line is a the card's nb $c address :"
            cat "people/$line"
            add=$(cat "people/$line")
            echo "<p class='adr'>${add}</p>">> people/phone_book.html
         elif  [[ $line =~ \.tel$ ]]
           then
           echo "$line is a the card's nb $c phone data :"
            cat "people/$line"
            tel=$(cat -e "people/$line" | sed  's/\$/<br>/g')
            echo "<p class='tel'>${tel}</p>" >> people/phone_book.html
         else
           echo "$line is something i dont know "
         fi
       fi
    done
done
echo "
</body>
</html>" >> people/phone_book.html
