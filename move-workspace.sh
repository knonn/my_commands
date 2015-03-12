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

case $1 in
    -d|d)
	i3-msg move workspace to output right > null
	rm null
	exit 0
	;;
    -g|g)
	i3-msg move workspace to output left > null
	rm null
	exit 0
	;;
    -h)
	echo "Ce programme permet de changer l'écran d'affichage du workspace de votre choix sous i3-window-manager\n
Utilisation :\n
\t-d              Déplacement du workspace vers l'écran de droite\n
\t-g              Déplacement du workspace vers l'écran de gauche\n
\t-h              Afficher cette aide"
	exit 1
	;;
    *)
	echo "Usage : move-workspace [-d|-g][-h]"
	exit 1
	;;
esac

exit 0
