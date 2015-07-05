#!/bin/bash
# Setup script for Ubuntu 14.04

NODE_VERSION=0.12.5 
NVM_VERSION=0.25.4
NVM_URL=https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh

echo "===> Setting up key for MongoDB" 
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 > /dev/null 2>&1

echo "===> Setting source list for MongoDB" 
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list > /dev/null 2>&1

echo "===> Updating apt-get packages" 
sudo apt-get update > /dev/null 2>&1

echo "===> Installing web packages (nginx, mongodb, git)" 
sudo apt-get install -y build-essential libssl-dev nginx mongodb-org git > /dev/null 2>&1

echo "===> Installing ImageMagick and dependencies" 
sudo apt-get install -y libmagickwand-dev imagemagick > /dev/null 2>&1

echo "===> Installing node version manager" 
curl -sS $NVM_URL | sh

# Hack to get remote access client to source nvm config data
echo "source /home/vagrant/.nvm/nvm.sh" >> /home/vagrant/.profile
source /home/vagrant/.profile

echo "===> Installing Node 0.12.5" 
nvm install $NODE_VERSION > /dev/null 2>&1
nvm alias default $NODE_VERSION > /dev/null 2>&1
nvm use default > /dev/null 2>&1

echo "===> Installing PM2 to manage node" 
npm install -g pm2 > /dev/null 2>&1

echo "===> PROVISION COMPLETE" 
