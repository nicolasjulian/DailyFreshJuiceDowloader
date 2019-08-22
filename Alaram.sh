#!/bin/bash
#Nicolas Julian
#9 Januray 2019
#Daily Fresh Juice Downloeader

#Make sure "Play" Env already installed
echo "Update CLI Player & Install if Nothing"
sudo apt install sox libsox-fmt-mp3 -y

user=`whoami`
hari=`date '+%Y-%m-%d'`
bulan=`date '+%Y/%m'`
tahun=`date '+%Y'`

		#Checking is file ready
	if [[ ! -d /home/$user/Renungan/ ]]; then
   		echo "Creating $folderFile/ folder"
   		mkdir /home/$user/Renungan/
  	else
		echo  "File Renungan Tersimpan Di /home/$user/Renungan/"
    fi
    		#Curl To Daily Fresh Juice (dot) net
    		date=`date '+%d %B %Y'`
			tema_date="$date"
			get_tema=`curl -s 'http://dailyfreshjuice.net'`
			tema_today=`echo $get_tema | grep -Po '(title=")[^"]*' | grep "$tema_date" | sort -u | grep -Po '(&#8211; )[^"]*' | sed -r 's|&#8211; ||g'`
			echo "Tema dan Bacaan Hari ini : " $tema_today

			    		#Downloading file rennungan
					if [[ ! -f /home/$user/Renungan/$hari'.mp3' ]]; then
						    echo "Download Renungan Hari ini"
						    get_link_renungan=`echo $get_tema | grep -Po '(href=")[^"]*' | grep 'http://media.blubrry.com/dailyfreshjuice/p/dailyfreshjuice.net/wp-content/uploads/'$tahun'/' | grep 'FJ'$hari'' | sort -u | sed 's/\href=//g' | tr -d '"'`
							echo $get_link_renungan
							simpan_file=`wget $get_link_renungan -O /home/$user/Renungan/$hari'.mp3' -q --show-progress`
							notify-send "Renungan Harian" "`date`"
							putar=`play /home/$user/Renungan/$hari'.mp3'`
					else
						echo "File Renungan "`date`" Already Exist"
						exit
					fi
