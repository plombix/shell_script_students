#!/bin/bash

num_of_files=$( ls -l people | wc -l )
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
  ls people | while read line;
    do
      if [[ $line = $c* ]]
        then
        case $line in
          *name)
           echo "$line is a the card's nb $c name :"
           name=$(cat "people/$line")
           echo "<p class='fn'>Nom, prenom: <a class='url' href='http://www.google.com/search?q=${name}'>${name}</a><p>">> people/phone_book.html
           ;;
          *work)
           echo "$line is a the card's nb $c job description :"
            cat "people/$line"
            job=$(cat "people/$line")
            wikijob=$(cat "people/$line" | sed 's/ /+/g')
            echo "<p class='fn'>Métier: <a class='url' href='https://fr.wikipedia.org/w/index.php?search=${wikijob}'>${job}</a><p>">> people/phone_book.html
            ;;
          *png)
            echo "$line is a the card's nb $c pict"
            echo "<img src='$line' alt='${name}' height='100' width='100'>">> people/phone_book.html
            ;;
         *add)
           echo "$line is a the card's nb $c address :"
            cat "people/$line"
            add=$(cat "people/$line")
            echo "<p class='adr'>Adresse: ${add}</p>">> people/phone_book.html
            ;;
         *tel)
           echo "$line is a the card's nb $c phone data :"
            cat "people/$line"
            tel=$(cat -e "people/$line" | sed  's/\$/<br>/g')
            echo "<p class='tel'>Numéro de téléphone: ${tel}</p>" >> people/phone_book.html
            ;;
          *)
           echo "$line is something i dont know "
           ;;
         esac
       fi
    done
done
echo "
</body>
</html>" >> people/phone_book.html
