#!/bin/bash
# Written by Andy Boutte and David Balderston of howtoinstallghost.com and allaboutghost.com
# updateghost.sh will update your current ghost install to the latest version without you losing any content

#Check to make sure script is being run as root
if [[ `whoami` != root ]]; then
    echo "This script must be run as root"
    exit 1
fi

#Make Tempory Directory and Download Lates Ghost
mkdir temp
wget -d temp https://github.com/TryGhost/Ghost/releases/download/0.4.0-pre/Ghost-0.4.0-pre.zip
unzip Ghost-0.4.0-pre.zip

#Copy the new files over
cp temp/*.md temp/*.js temp/*.json .
rm -R core
cp -R temp/core .
cp -R temp/content/themes/casper content/themes
npm install --production

echo "You can now start ghost with npm, forever or whatever else you use"
