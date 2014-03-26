#!/bin/bash
# Written by Andy Boutte and David Balderston of howtoinstallghost.com and allaboutghost.com
# updateghost_digitalocean.sh will update your current Digital Ocean Ghost install to the latest version without you losing any content

if [[ `whoami` != root ]]; then
    echo "This script must be run as root"
    exit 1
fi

#Stop Ghost
service ghost stop

#Add Git
apt-get update
apt-get upgrade -y
apt-get install -y git
echo "###### Git Installed ######"

#Make Tempory Directory and Download Lates Ghost
cd /var/www/ghost
mkdir temp
cd temp
wget https://ghost.org/zip/ghost-latest.zip
unzip *.zip
cd ..

#Make Backup DB
cp content/data/ghost.db content/data/ghost_backup.db
echo "###### Data Backed Up ######"

#Copy the new files over
yes | cp temp/*.md temp/*.js temp/*.json .
rm -R core
yes | cp -R temp/core .
rm -R content/themes/casper
yes | cp -R temp/content/themes/casper content/themes/.
npm install --production
echo "###### NPM Installed ######"

#Delete temp folder
rm -R temp

#Start Ghost Again
service ghost start
echo "###### Ghost Started ######"