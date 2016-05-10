#!/bin/bash

# Name : ghosy ip generator
# Function : generate ghost ip to a bridge interface
# Developer : knonn

file=/tmp/sav_ipghost.txt

case $1 in
	-g)
		printf "Plage IP modèle :\n \t1 : 172.16.100.*\n\t2 : 192.168.100.*\t\n\t3 : Custom\n"
		read -p "Choix : " choice

		case $choice in
			1)
				baseip="172.16.100."
				;;
			2)
				baseip="192.168.100."
				;;
			3)
				read -p "Adresse réseau (forme XXX.XXX.XXX.) :" baseip
				;;
			*)
				echo "Bad entry, exit..."
				exit 1
				;;
		esac
		read -p "Nombre d'ip : " nbip

		if [ -e $file ]; then
			rm $file
		fi

		for ((i=0;i<$nbip;i++));
		do
			nip=$[2 + $[ RANDOM % 240 ]]
			printf "$baseip$nip\n" >> $file
			sudo ip addr add $baseip$nip/16 brd + dev docker0
			echo "$baseip$nip successfully created"
		done
		;;
	-d)
		if [ -e $file ]; then
			while read line
			do
				sudo ip addr delete $line/16 brd + dev docker0
				echo "$line successfully removed"
			done <$file
			rm $file
		else
			echo "File does no exist, exit..."
			exit 1
		fi
		;;
	*)
		printf "Usage : \n -g : generate\n -d : delete"
esac
