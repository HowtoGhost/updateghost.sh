#!/bin/bash
# Written by Andy Boutte and David Balderston of howtoinstallghost.com and allaboutghost.com
# updateghost.sh will update your current ghost install to the latest version without you losing any content

#Check to make sure script is being run as root
# if [[ `whoami` != root ]]; then
#     echo "This script must be run as root"
#     exit 1
# fi
echo `whoami`
#Make Tempory Directory and Download Lates Ghost
mkdir temp
cd temp
curl -L -O https://ghost.org/zip/ghost-latest.zip 
unzip *.zip
cd ..

#Make Backup DB
cp content/data/ghost.db content/data/ghost_backup.db

#Copy the new files over
yes | cp temp/*.md temp/*.js temp/*.json .
rm -R core
yes | cp -R temp/core .
yes | cp -R temp/content/themes/casper content/themes
npm install --production

#Delete temp folder
rm -R temp

echo "You can now start ghost with npm, forever or whatever else you use"
