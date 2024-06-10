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



#!/bin/bash

# Navigate to the Videos directory
cd /home/mpokket/Videos/ || { echo "Failed to navigate to /home/mpokket/Videos/"; exit 1; }

# List the files in the Videos directory
ls

# Execute the find and remove command
if find /home/mpokket/Videos/ -type f -name '*.mkv' ! -newermt "$(date -d '3 days ago 00:00' +%Y-%m-%d\ %H:%M)" -exec rm {} +; then
    echo "Command executed successfully."
else
    echo "Error executing the command."
fi
