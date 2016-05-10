#!/bin/bash

case $1 in
    "on" )
        systemctl start network-manager.service > /dev/null
        systemctl start NetworkManager.service > /dev/null
        nmcli radio wifi on > /dev/null
	service networking restart
        su -c "nm-applet&" -s /bin/zsh knonn &>/dev/null
        exit 0
        ;;
    "off" )
        ip link set eth0 up > /dev/null
        nmcli radio wifi off > /dev/null
        systemctl stop network-manager.service > /dev/null
        systemctl stop NetworkManager.service > /dev/null
        killall nm-applet > /dev/null
        service networking restart
        exit 0
        ;;
    * )
        print "error"
        ;;
esac
