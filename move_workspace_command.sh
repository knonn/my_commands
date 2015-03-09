#!/bin/sh

while [ 1 ]
do
    echo "Bouger ce bureau sur l'écran :\n\t1. De gauche (g)\n\t2. De droite (d)"
    read -p "Choix : " move

    if [ $move = 'd' ]
    then
	i3-msg move workspace to output right > null
	break
    elif [ $move = 'g' ]
    then
	i3-msg move workspace to output left > null
	break
    else
	echo "Mauvaise entrée,recommencez"
    fi
done

rm null
