
#!/bin/bash

# num_of_files=$( ls -l people | wc -l )
OPTIONS="search list text html Quit"
           select opt in $OPTIONS; do
               if [ "$opt" = "Quit" ]; then
                echo done
                exit
               elif [ "$opt" = "search" ]; then
                echo "Your result :"
               elif [ "$opt" = "list" ]; then
                echo "Your list"
               elif [ "$opt" = "text" ]; then
                echo "generating text file :phone_book.txt"
               elif [ "$opt" = "html" ]; then
                echo "generating html file: phone_book.html"
                html_out
               else
                clear
                echo bad option
               fi
           done
function search_name{

}


function list_names{

}

function file_out{

}

function html_out{
echo "Saisir num_of_files"
read num_of_files

touch "phone_book.html"
echo "<!DOCTYPE html>
<html>
<head>
 <meta charset='UTF-8'>
 <title>Phone_book</title>
</head>

<body>" > phone_book.html
for (( c=0; c<$num_of_files; c++ ))
do
  echo "---D--"
  ls people | while read line;
    do
      if [[ $line = $c* ]]
        then
         case $line in
           *.png)
              echo "$line is a the card's nb $c pict"
              echo "<img src='$line' alt='${name}' style='float: left;display: block;margin-top: -5%;' height='120' width='120'>" >> phone_book.html
            ;;
            *.add)
              echo "$line is a the card's nb $c address :"
              cat "people/$line"
              add=$(cat "people/$line")
              googlemaps=$(cat "people/$line" | sed 's/ /+/g')
              echo "<p class='add'>Adresse : <b><a class='url' style='text-decoration:none;' target='_blank' href='https://www.google.fr/maps/place/${googlemaps}'>${add}</a></b></p>" >> phone_book.html
            ;;
            *.name)
              echo "$line is a the card's nb $c name :"
              name=$(cat "people/$line")
              echo "<p class='pn'>Prénom / Nom : <a class='url' style='text-decoration:none;' target='_blank' href='http://www.google.com/search?q=${name}'><b>${name}</b></a><p>" >> phone_book.html
            ;;
            *.tel)
              echo "$line is a the card's nb $c phone data :"
              cat "people/$line"
              tel=$(cat -e "people/$line" | sed  's/\$/<br>/g')
              call=$(cat "people/$line")
              echo "<p class='tel'>Numéro : <a href='tel:${call}'><b>${tel}</b></a></p>" >> phone_book.html
            ;;
            *.work)
              echo "$line is a the card's nb $c job description :"
              cat "people/$line"
              job=$(cat "people/$line")
              wikijob=$(cat "people/$line" | sed 's/ /+/g')
              echo "<p class='job'>Job : <a class='url' style='text-decoration:none;' target='_blank' href='https://fr.wikipedia.org/w/index.php?search=${wikijob}'><b>${job}</b></a><p><hr />" >> phone_book.html
            ;;
            *)
              echo "$line is something i dont know "
            ;;
         esac
       fi
    done
    echo "***F**"
done
echo "
</body>
</html>" >> phone_book.html
}
