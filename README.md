Update Ghost
==============

This repo contains different scripts to automate the update of Ghost. All of them are up to date to take you from any version of Ghost to the latest. If you are unsure, here are the scripts you should use:

Full instructions located on [All About Ghost](http://allaboutghost.com)

###Hosting on DigitalOcean

Script: `updateghost_digitalocean.sh`

Command: `wget -O - https://allaboutghost.com/updateghost-digitalocean | sudo bash`

###Hosting on Amazon EC2 ([Using our ami](http://www.howtoinstallghost.com/how-to-setup-an-amazon-ec2-instance-to-host-ghost-for-free/))

Script: `updateghost_ami_pm2.sh`

Command: `wget -O - https://allaboutghost.com/updateghost-aws | sudo bash`


###Hosting Yourself

Script: `updateghost.sh`

Command: `wget -O - https://allaboutghost.com/updateghost | sudo bash`