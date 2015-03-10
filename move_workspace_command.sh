#!/bin/sh

#    Move workspace on another screen for i3
#    Copyright (C) 2015  <romain.besland@cryptolab.net>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
clear
exit 0
