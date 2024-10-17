#!/bin/bash

echo "Removing Current Firefox"
apt autoremove -y firefox > /dev/null 2>&1
smbget smb://192.168.201.8/it/Linux_Mint_Install/firefox-130.0.deb -U share%Passw0rd
echo "Installing Stable Firefox"
dpkg -i firefox-130.0.deb > /dev/null 2>&1 
apt-mark hold firefox > /dev/null 2>&1
echo "Please restart the system once"
exit
