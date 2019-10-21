#!bin/bash

# Setup environment.
apt-get update
apt-get install -y sudo
sudo apt-get install -y wget
sudo apt-get install -y gnupg

# Add postgresql and postgis source to the apt-get.
echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" >> "/etc/apt/sources.list"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update

# Intall postgresql and postgis.
sudo apt-get install -y postgresql-10
sudo apt install -y postgresql-10-postgis-2.4 
sudo apt install -y postgresql-10-postgis-scripts