#!/bin/bash
# Written by Andy Boutte and David Balderston of howtoinstallghost.com and allaboutghost.com
# updateghost_ami.sh will update your current Amazon ami ghost install to the latest version without you losing any content

if [[ `whoami` != root ]]; then
    echo "This script must be run as root"
    exit 1
fi

#Stop Ghost
forever stopall

#Make Tempory Directory and Download Lates Ghost
cd /var/www/ghost
mkdir temp
cd temp
wget https://github.com/TryGhost/Ghost/releases/download/0.4.0-pre2/Ghost-0.4.0-pre2.zip
unzip *.zip
cd ..

#Make Backup DB
cp content/data/ghost.db content/data/ghost_backup.db
echo "###### Data Backed Up ######"

#Copy the new files over
yes | cp temp/*.md temp/*.js temp/*.json .
rm -R core
yes | cp -R temp/core .
yes | cp -R temp/content/themes/casper content/themes
npm install --production

#Delete temp folder
rm -R temp

#Install and use pm2
yes | yum install git
echo "###### Git Installed ######"

npm install git://github.com/Unitech/pm2.git -g
echo "###### pm2 Installed ######"

echo "export NODE_ENV=production" >> ~/.profile
pm2 start index.js --name ghost
pm2 startup centos
echo "###### pm2 Startup Started ######"

#Delete Old Forever Script and Cron
crontab -r
rm /usr/local/scripts/ghoststart.sh
rm /etc/init.d/ghostscript.sh