#!/bin/bash
cd Videos/;ls
# Execute the find and remove command
if find /home/mpokket/Videos/ -type f -name '*.mkv' ! -newermt "$(date -d 'today 00:00' +%Y-%m-%d\ %H:%M)" -exec rm {} +; then echo "Command executed successfully."
else echo "Error executing the command."
fi





Run as crontab
------------------
00 18 * * *  /script/Delete.sh;./Delete.sh


find /home/mpokket/Videos/ -type f -name '*.mkv' ! -newermt "$(date -d 'yesterday 00:00' +%Y-%m-%d\ %H:%M)" -exec rm {} +
