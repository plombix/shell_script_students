#!/bin/bash

# search through files of names and print info based on id of match ,himself coded with *
function search_name {
  echo "Ask for a Name"
  read search
  ls people -1 | while read line;
    do
      if  [[ $line =~ \.name$ ]]
        then
        founded_name=$(cat "people/$line")
        if [[ $founded_name == *$search* ]]
          then
          echo -e "\e[96m==================================================\e[0m"
          echo -e  "Founded : \e[96m
$founded_name \e[0m
"
          filename=$(basename "$line")
          c="${filename%.*}"
          ls people -1 | while read line;
            do
              if [[ $line = $c* ]]
                then
                 if  [[ $line =~ \.tel$ ]]
                   then
                    cat "people/$line"
                 elif [[ $line =~ \.work$ ]]
                   then
                    cat "people/$line"
                 elif  [[ $line =~ \.add$ ]]
                   then
                    cat "people/$line"
                 fi
               fi
            done
        fi
      fi
    done
 echo "Done serching ''$search '' in Names"
}

# list all name files'content
function list_names {
  ls people -1 | while read line;
    do
      if  [[ $line =~ \.name$ ]]
        then
          echo -e "\e[96m==================================================\e[0m"
        cat "people/$line"
      fi
    done
}


# rely on ruby's cleaner
function clean {
  echo "Cleaning old entries"
    ruby random_people.rb clean
}
# rely on ruby's generator
function generate {
  echo "How much?"
  read num_of_people
  ruby random_people.rb $num_of_people}
OPTIONS=" generate clean search list text html Quit"
           select opt in $OPTIONS; do
               if [ "$opt" = "Quit" ]; then
                echo done
                exit
               elif [ "$opt" = "search" ]; then
                echo "More info are needed !"
                search_name
              elif [ "$opt" = "generate" ]; then
                echo "will generate but ..."
                generate
              elif [ "$opt" = "clean" ]; then
                echo "Your result :"
                clean
               elif [ "$opt" = "list" ]; then
                echo "Your list:"
                list_names
               elif [ "$opt" = "text" ]; then
                echo "generating text file :phone_book.txt"
                file_out
               elif [ "$opt" = "html" ]; then
                echo "generating html file: phone_book.html"
                html_out
               else
                clear
                echo bad option
               fi
           done
}

# export to text file
function file_out {
  echo "">phone_book.txt
  for (( c=0; c<=$num_of_files; c++ ))
  do
    ls people -1 | while read line;
      do
        if [[ $line = $c* ]]
          then
           if  [[ $line =~ \.name$ ]]
             then
             echo "$line is a the card's nb ${c} name :"
             cat "people/$line" >>phone_book.txt
           elif  [[ $line =~ \.jpg$ ]]
             then
             echo "$line is a the card's nb ${c} pict"
           elif  [[ $line =~ \.tel$ ]]
             then
             echo "$line is a the card's nb ${c} phone data :"
              cat "people/$line">>phone_book.txt
           elif [[ $line =~ \.work$ ]]
             then
             echo "$line is a the card's nb ${c} job description :"
              cat "people/$line">>phone_book.txt
           elif  [[ $line =~ \.add$ ]]
             then
             echo "$line is a the card's nb ${c} address :"
              cat "people/$line">>phone_book.txt
           else
             echo "$line is something i dont know "
           fi
         fi
      done
  done
}
function html_out {
echo "number of entries to list"

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
           *.jpg)
              echo "$line is a the card's nb $c pict"
              echo "<img src='people/$line' alt='${name}' style='position: absolute;right:10px ;margin-top:-1%' height='120' width='120'>" >> phone_book.html
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
OPTIONS=" generate clean search list text html Quit"
           select opt in $OPTIONS; do
               if [ "$opt" = "Quit" ]; then
                echo done
                exit
               elif [ "$opt" = "search" ]; then
                echo "More info are needed !"
                search_name
              elif [ "$opt" = "generate" ]; then
                echo "will generate but ..."
                generate
              elif [ "$opt" = "clean" ]; then
                echo "Your result :"
                clean
               elif [ "$opt" = "list" ]; then
                echo "Your list:"
                list_names
               elif [ "$opt" = "text" ]; then
                echo "generating text file :phone_book.txt"
                file_out
               elif [ "$opt" = "html" ]; then
                echo "generating html file: phone_book.html"
                html_out
               else
                clear
                echo "go by new fingers ..."
               fi
           done
