#!/bin/sh

#    Configure a new xrandr profile for a dual screen on linux
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


case "$1" in
    off|-off)
	screen=`xrandr -q | grep " connected" | gawk 'NR==2''{print $1}'`
	if [ -z $screen ]; then
	    echo "L'écran externe n'est pas allumé"
	    exit 1
	else
	    xrandr --output $screen --off
	    feh --bg-center ~/Images/ville_miniature.jpg
	    exit 0
	fi
	;;
    -help)
	echo "Usage\n
\toff   or   -off   :   Turn off external screen\n
\tn     or   -new   :   Configure external screen"
	exit 1
	;;
    n|-new)
	break
	;;
    *)
	echo "Use -help to display help"
	exit 1;
	;;
esac

echo "*************************************\n*** PARAMETRAGE D'UN NOUVEL ECRAN ***\n*************************************\n"

echo "INFORMATIONS :"
echo "-------------------------------------------"
xrandr -q
echo "-------------------------------------------"
echo "Les informations ci-dessus vous permettent de connaitre les résolutions disponibles pour votre écran externe"
echo "\n"
read -p "Résolution souhaitée (ex : 1280x720) : " resos
read -p "Fréquence de rafraichissement souhaitée (Hz) [60]: " freq1

if [ -z $freq1 ]; then
    freq=60
else
    freq=$freq1
fi 

reso=`echo $resos |sed 's/\x/ /'`
line=`gtf $reso $freq | grep Modeline | cut -c 12-`
lineshort=`gtf $reso $freq | grep Modeline | gawk '{print $2}'`

while [ 1 ]
do
    
    echo "Emplacement de l'écran externe\n\t1. Droite (d)\n\t2. Gauche (g)\n\t3. Au dessus (de)\n\t4. En dessous (ds)\n\t5. Miroir (m)"
    read -p "Choix : " choice
    
    out=`xrandr -q | gawk 'NR==2''{print $1}'`
    
    if [ $choice = 'd' ]
    then
	final="--right-of $out"
	break
    elif [ $choice = 'g' ]
    then
	final="--left-of $out"
	break
    elif [ $choice = 'm' ]
    then
	final="--same-as $out"
	break
    elif [ $choice = "ds" ]
    then
	final="--below $out"
	break
    elif [ $choice = "de" ]
    then
	final="--above $out"
	break
    else
	echo "Mauvaise entrée"
    fi
done

screen=`xrandr -q | grep " connected" | gawk 'NR==2''{print $1}'`

xrandr --newmode $line
xrandr --addmode $screen $lineshort
xrandr --output $screen --mode $lineshort $final
feh --bg-center ~/Images/ville_miniature.jpg
clear
exit 0
