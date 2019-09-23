#!/bin/bash
# Write a shell script that automatically and periodically back up all files in the current directory (Hint: crontab). 
# mybackup –n: backup the current directory once every n minutes as .tgz file names as “dirname_date_time.tgz” in the home/username/backup directory.
# mybackup –q: stop periodical backup of the directory. 
# The deadline is 4/2 23:59. Please upload your code via portal.

# 要開可以執行的權限 chmod +x mybackup
# 指令 ~/./mybackup

# TIME=`date +"%Y%m%d_%H%M"`
# CurrentDirectory=`pwd`
DIR=${PWD##*/} # 取當前資料夾名稱

# File="$DIR"_"$TIME.tgz" # 備份檔案名稱
# echo "FileName: $File"
# echo "$CurrentDirectory" >> backupCommand

if  [[ $1 = "-n" ]]; 
	then
		
		# tar -czvPf - $CurrentDirectory | gzip > ~/backup/$File # 將當前目錄的資料備份進backup資料夾，並命名為$File
		# echo "$DIR backup successfully completed"

		# F完整字串 x完全符合 q不顯示訊息
		if crontab -l | grep -Fxq "*/$2 * * * * tar -czvPf - `pwd` | gzip > ~/backup/"${PWD##*/}"_\$(date +\%Y\%m\%d_\%H\%M).tgz"; # 檢查cron job 是否存在
		 	then
		  		echo "Cronjob already exists"
		else
			echo "start doing backup ${PWD##*/} once every $2 minutes."
		  	crontab -l > mycron
			echo "*/$2 * * * * tar -czvPf - `pwd` | gzip > ~/backup/"${PWD##*/}"_\$(date +\%Y\%m\%d_\%H\%M).tgz" >> mycron
			crontab mycron
			rm mycron
		fi

elif [[ $1 = "-q" ]]; 
	then
        echo "stop periodical backup of "${PWD##*/}" directory."
        crontab -r
        # sed '/"$DIR"/d' < crontab > tmp
        # crontab -l | sed '/^#.*$pwd/s/^/#/' | crontab -
        # cat tmp
        # crontab -e | sed '/`pwd`/d' < crontab > tmp
        # mv tmp crontab
        # echo "$DIR"
        # crontab -r

elif [[ "$1" = "-h" ]] ; then
    echo "Usage: `basename $0` [-h]"
    echo "   [-n]  backup the current directory once every n minutes "
    echo "   [-q]  stop periodical backup "
    exit 0	
		
else
    echo "You did not use option -o"
fi

#END

