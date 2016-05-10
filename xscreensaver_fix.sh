#!/bin/sh
<<<<<<< HEAD
apt-get update 

apt-get install $(apt-cache depends xscreensaver | awk '$1~/Dépend/{printf $2" "}')
apt-get install libx11-dev intltool libxt-dev libxext-dev libxpm-dev libgtk2.0-dev libxml2-dev libglade2-dev libatk1.0-0 libc6
=======
apt-get update

apt-get install awk

apt-get install $(apt-cache depends xscreensaver | awk '$1~/Dépend/{printf $2" "}')
apt-get install libx11-dev intltool libxt-dev libxext-dev libxpm-dev libgtk2.0-dev libxml2-dev libglade2-dev
>>>>>>> 5cb0532c4c3e1ccf0f44201b5d685ad561feee09
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

<<<<<<< HEAD
exit 0
=======
exit 0
>>>>>>> 5cb0532c4c3e1ccf0f44201b5d685ad561feee09
