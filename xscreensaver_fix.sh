#!/bin/sh
apt-get update 

apt-get install $(apt-cache depends xscreensaver | awk '$1~/Dépend/{printf $2" "}')
apt-get install libx11-dev intltool libxt-dev libxext-dev libxpm-dev libgtk2.0-dev libxml2-dev libglade2-dev
apt-get source xscreensaver

cd xscreensaver-5.30
mv driver/prefs.c driver/prefstmp.c
head -n -32 driver/prefstmp.c > driver/prefs.c 
echo "return 0; }" >> driver/prefs.c 
rm driver/prefstmp.c 

./configure
make
make install

cd ..
rm -rf xscreensaver-5.30
rm xscreensaver_5.30*

echo "Xscreensaver Fixed"

exit 0
