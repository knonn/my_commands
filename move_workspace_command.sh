#!/bin/sh

while [ 1 ]
do
    
    read -p "Bouger ce bureau sur l'écran de gauche ou de droite ? (d/g) " move

    if [ $move = 'd' ]
    then
	i3-msg move workspace to output right > null
	break
    elif [ $move = 'g' ]
    then
	i3-msg move workspace to output left > null
	break
    else
	echo "Mauvaise entrée"
    fi
done

rm null
