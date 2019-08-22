#!/bin/bash
#Nicolas Julian
#9 Januray 2019
#Daily Fresh Juice Downloeader

#Make sure "Play" Env already installed
echo "Update CLI Player & Install if Nothing"
echo "+===========================================+"
if [[ ! -f /bin/sox ]]; then
	sudo apt install sox libsox-fmt-mp3 -y
else
	echo "Apabila terjadi kesalahan pada saat memutar audio lakukan [sudo apt install sox libsox-fmt-mp3 -y] "
fi

user=`whoami`
hari=`date '+%Y-%m-%d'`
bulan=`date '+%Y/%m'`
tahun=`date '+%Y'`

		#Checking is file ready
	if [[ ! -d /home/$user/Renungan/ ]]; then
   		echo "Creating $folderFile/ folder"
			mkdir /home/$user/Renungan/
			echo "Silahkan Restart Tools Ini"
  	else
		echo "+===========================================+"
		echo  "File Renungan Tersimpan Di /home/$user/Renungan/"
    fi
    		#Curl To Daily Fresh Juice (dot) net
    		date=`date '+%d'`
			tema_date="$date"
			get_link_download=`curl -s 'http://dailyfreshjuice.net'`
			tema_today=$(curl -s "http://dailyfreshjuice.net/feed/podcast/" | grep '<title>' | grep 'Juice '$tema_date'' | awk -F ';' '{print $2}' | sed -r "s/^ //g" | sed -r "s|</title>||g")
			echo "+===========================================+"
			echo "Tema dan Bacaan Hari ini :  $tema_today"
			echo "+===========================================+"

			    		#Downloading file rennungan
					if [[ ! -f /home/$user/Renungan/$hari'.mp3' ]]; then
						    echo "Download Renungan Hari ini"
						    get_link_renungan=`echo $get_link_download | grep -Po '(href=")[^"]*' | grep 'http://media.blubrry.com/dailyfreshjuice/p/dailyfreshjuice.net/wp-content/uploads/'$tahun'/' | grep 'FJ'$hari'' | sort -u | sed 's/\href=//g' | tr -d '"'`
							echo $get_link_renungan
							simpan_file=`wget $get_link_renungan -O /home/$user/Renungan/$hari'.mp3' -q --show-progress`
							notify-send "Renungan Harian" "`date`"
							putar=`play /home/$user/Renungan/$hari'.mp3'`
					else
						echo "File Renungan "`date`" Already Exist"
						exit
					fi
