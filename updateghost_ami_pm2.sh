#!/bin/bash
# Written by Andy Boutte and David Balderston of howtoinstallghost.com and allaboutghost.com
# updateghost_ami.sh will update your current Amazon ami ghost install to the latest version without you losing any content

if [[ `whoami` != root ]]; then
    echo "This script must be run as root"
    exit 1
fi

#Stop Ghost
pm2 stop all

#Make Tempory Directory and Download Lates Ghost
cd /var/www/ghost
mkdir temp
cd temp
wget https://github.com/TryGhost/Ghost/releases/download/0.5.0-rc2/Ghost-0.5.0-rc2.zip
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
chown -R ghost:ghost /var/www/ghost/

#Start Ghost Again
pm2 --run-as-user ghost start index.js --name ghost
echo "###### Ghost Started ######"