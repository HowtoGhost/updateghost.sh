#!/bin/bash
# Written by Andy Boutte and David Balderston of howtoinstallghost.com and allaboutghost.com
# updateghost_ami.sh will update your current Amazon ami ghost install to the latest version without you losing any content

sudo -u ghost

#Stop Ghost
pm2 stop all

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
yes | cp -R temp/content/themes/casper content/themes
npm install --production
echo "###### NPM Installed ######"

#Delete temp folder
rm -R temp

#Start Ghost Again
pm2 start index.js --name ghost
echo "###### Ghost Started ######"