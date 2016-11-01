#!/bin/bash
num_of_files=$( ls -l people | wc -l )
echo "<!DOCTYPE html> 
<html>
<head>
 <meta charset='UTF-8'>
 <title>Phone_book</title>
</head>
<body>" > people/phone_book.html
for (( c=0; c<=$num_of_files; c++ ))
do
  ls people | while read line;
    do
      if [[ $line = $c* ]]
         then
        case $line in      
            *name) 
                name=$(cat "people/$line")
                echo "<article id='${name}'><p class='fn'><a target='_blank' class='url' href='http://www.google.com/search?q=${name}'>${name}</a><p>">> people/phone_book.html;;
            *work) 
                job=$(cat "people/$line")
                wikijob=$(cat "people/$line" | sed 's/ /+/g')
                echo "<p class='fn'><a target='_blank' class='url' href='https://fr.wikipedia.org/w/index.php?search=${wikijob}'>${job}</a><p>">> people/phone_book.html;;
            *png) 
                echo "<img src='$line' alt='${name}' height='100' width='100'>">> people/phone_book.html;;
            *add) 
                add=$(cat "people/$line")
                echo "<p class='adr'>${add}</p>">> people/phone_book.html;;
            *tel) 
                tel=$(cat -e "people/$line" | sed  's/\$/<br>/g')
                echo "<p class='tel'>${tel}</p></article>" >> people/phone_book.html;;
            *) 
              echo "$line a une extension inconnu et ne peut être rajoutée";;
        esac
       fi
    done
done
echo "
</body>
</html>" >> people/phone_book.html
