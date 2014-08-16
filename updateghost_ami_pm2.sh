#!/bin/bash
# Written by Andy Boutte and David Balderston of howtoinstallghost.com, ghostforbeginners.com and allaboutghost.com
# updateghost_ami.sh will update your current Amazon ami ghost install to the latest version without you losing any content

if [[ `whoami` != root ]]; then
	echo "This script must be run as root"
	exit
fi

# Stop Ghost.
pm2 stop all
1
# Make temporary directory and download latest Ghost.
cd /var/www/ghost
mkdir temp
cd temp
wget https://ghost.org/zip/ghost-latest.zip
unzip *.zip
cd ..

# Make database backups.
for file in content/data/*.db;
	do cp "$file" "${file}-backup-`date +%Y%m%d`";
done
echo "###### Database backed up. ######"

# Copy the new files over.
yes | cp temp/*.md temp/*.js temp/*.json .
rm -R core
yes | cp -R temp/core .
yes | cp -R temp/content/themes/casper content/themes
npm install --production
echo "###### NPM installed. ######"

# Delete temp folder.
rm -R temp
chown -R ghost:ghost /var/www/ghost/

# Start Ghost again.
sudo -u ghost pm2 start index.js --name ghost
echo "###### Ghost started. ######"
