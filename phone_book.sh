#!/bin/bash

# Déclaration de variables préalables
num_of_files=$( ls -l people | wc -l )
file='phone_book.html' # Enregistrement du chemin du fichier dans une variable pour ne pas réécrire le chemin à chaque fois

# Création du fichier .html
touch "phone_book.html"

# Enregistrement des premieres lignes de la structure de la page html
echo "<!DOCTYPE html>
<html>
<head>
 <meta charset='UTF-8'>
 <title>Phone_book</title>
</head>
<body>" > $file

# Traitement des fichiers
for (( c=0; c<=$num_of_files; c++ ))
do
  ls people | while read line;
  do
    if [[ $line = $c* ]]
      then
      case $line in
        *name)
          echo "$line is the card's nb $c name :"
          name=$(cat "people/$line")
          echo "<p class='fn'>Nom, prenom: <a class='url' href='http://www.google.com/search?q=${name}'>${name}</a><p>">> $file
          ;;
        *work)
          echo "$line is the card's nb $c job description :"
          cat "people/$line"
          job=$(cat "people/$line")
          wikijob=$(cat "people/$line" | sed 's/ /+/g')
          echo "<p class='fn'>Métier: <a class='url' href='https://fr.wikipedia.org/w/index.php?search=${wikijob}'>${job}</a><p>">> $file
          ;;
        *png)
          echo "$line is the card's nb $c pict"
          echo "<img src='$line' alt='${name}' height='100' width='100'>">> $file
          ;;
        *add)
          echo "$line is the card's nb $c address :"
          cat "people/$line"
          add=$(cat "people/$line")
          echo "<p class='adr'>Adresse: ${add}</p>">> $file
          ;;
        *tel)
          echo "$line is the card's nb $c phone data :"
          cat "people/$line"
          tel=$(cat -e "people/$line" | sed  's/\$/<br>/g')
          echo "<p class='tel'>Numéro de téléphone: ${tel}</p>" >> $file
          ;;
        *)
          echo "$line is something i dont know..."
          ;;
        esac
      fi
    done
    echo "<br /><hr />" >> $file
done
echo "
</body>
</html>" >> $file
