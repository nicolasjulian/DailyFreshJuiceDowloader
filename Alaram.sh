#!/bin/bash
#Nicolas Julian
#9 Januray 2019
#Daily Fresh Juice Downloeader

user=`whoami`
hari=`date '+%Y-%m-%d'`
bulan=`date '+%Y/%m'`
tahun=`date '+%Y'`
if [ ! -f /home/$user/Renungan/$hari'.mp3' ]; then
    echo "Download Renungan Hari ini"
    get_link_renungan=`curl -s dailyfreshjuice.net | grep -Po '(href=")[^"]*' | grep 'http://media.blubrry.com/dailyfreshjuice/p/dailyfreshjuice.net/wp-content/uploads/'$tahun'/' | grep 'FJ'$hari'' | sort -u | sed 's/\href=//g' | tr -d '"'`
	simpan_file=`wget $get_link_renungan -O /home/$user/Renungan/$hari'.mp3' -q --show-progress`
	notify-send "Renungan Harian" "`date`"
	putar=`play /home/$user/Renungan/$hari'.mp3'`
else
	exit
fi
