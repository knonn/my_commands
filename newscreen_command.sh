#!/bin/sh

echo "*************************************\n*** PARAMETRAGE D'UN NOUVEL ECRAN ***\n*************************************\n"

echo "INFORMATIONS :"
echo "-------------------------------------------"
xrandr -q
echo "-------------------------------------------"
echo "Les informations ci-dessus vous permettent de connaitre les résolutions disponibles pour votre écran externe"
echo "\n"
read -p "Résolution souhaitée (ex : 1280x720) : " resos
read -p "Fréquence de rafraichissement souhaitée (Hz) : " freq

reso=`echo $resos |sed 's/\x/ /'`
line=`gtf $reso $freq | grep Modeline | cut -c 12-`
lineshort=`gtf $reso $freq | grep Modeline | gawk '{print $2}'`

while [ 1 ]
do
    
    echo "Emplacement de l'écran externe\n\t1. Droite (d)\n\t2. Gauche (g)\n\t3. Miroir (m)"
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
    else
	echo "Mauvaise entrée"
    fi
done

screen=`xrandr -q | grep " connected" | gawk 'NR==2''{print $1}'`

xrandr --newmode $line
xrandr --addmode $screen $lineshort
xrandr --output $screen --mode $lineshort $final
clear
exit 0
