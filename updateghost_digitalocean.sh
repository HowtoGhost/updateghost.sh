#!/bin/bash
# Written by Andy Boutte and David Balderston of howtoinstallghost.com, ghostforbeginners.com, allaboutghost.com
# updateghost_digitalocean.sh will update your current Digital Ocean Ghost install to the latest version without you losing any content

if [[ `whoami` != root ]]; then
    echo "This script must be run as root"
    exit 1
fi

#Make Tempory Directory and Download Lates Ghost
cd /var/www/ghost
mkdir temp
cd temp
wget https://ghost.org/zip/ghost-latest.zip
unzip *.zip
cd ..

#Stop Ghost
service ghost stop

#Make Backup DB
cp content/data/ghost.db content/data/ghost_backup.db
echo "###### Data Backed Up ######"

#Copy the new files over
yes | cp temp/*.md temp/*.js temp/*.json .
rm -R core
yes | cp -R temp/core .
yes | cp -R temp/content/themes/casper content/themes
npm install --production
echo "###### NPM Installed ######"

chown -R ghost:ghost ./

#Delete temp folder
rm -R temp

#Start Ghost Again
service ghost start
echo "###### Ghost Started ######"
