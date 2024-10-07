#!/bin/bash

echo "Removing Current Firefox"
apt autoremove -y firefox > /dev/null 2>&1
echo "Installing Stable Firefox"
apt install -y firefox=130.0.1+build1-0ubuntu0.20.04.1 > /dev/null 2>&1 
apt-mark hold firefox > /dev/null 2>&1
echo "Please restart the system once"
exit
