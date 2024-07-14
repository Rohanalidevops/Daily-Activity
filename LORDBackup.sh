#!/bin/bash

# Variables
ip_LROD=192.168.0.8
hostname=$(hostname)
video_location=/home/mpokket/Videos/
log_file="/var/log/lrod_backup.log"

# Functions
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $log_file
}

send_email() {
    local subject=$1
    local body=$2
    echo "$body" | mail -s "$subject" user@example.com
}

# Script start
log "Script for LROD_Video_Backup started."

# User authentication
echo "Please enter your user name for authentication: "
read -p "User name: " CHOICE_USER

# Use stty for enhanced password security
stty -echo
read -sp "Enter the password: " PASSWORD
stty echo
echo

# Optionally add basic password validation
if [[ -z $PASSWORD ]]; then
    log "Password cannot be empty."
    send_email "LROD Backup Failed" "Password cannot be empty."
    exit 1
fi

# User selection of the day for backup
echo "Select the day to backup:"
echo "1) Yesterday"
echo "2) 2 days ago"
echo "3) 3 days ago"
echo "4) 4 days ago"
echo "5) 5 days ago"
echo "6) 6 days ago"
echo "7) 7 days ago"
read -p "Enter your choice (1-7): " day_choice

if ! [[ $day_choice =~ ^[1-7]$ ]]; then
    log "Invalid choice. Please select a number between 1 and 7."
    send_email "LROD Backup Failed" "Invalid choice. Please select a number between 1 and 7."
    exit 1
fi

# Calculate the selected day
file_name=$(date +%Y-%m-%d -d "$day_choice days ago")
FOLDER_NAME=$(date +%d-%m-%Y -d "$day_choice days ago")
path=/mnt/$FOLDER_NAME/$hostname

# Mount the network drive
mount -t cifs //$ip_LROD/Monitoring/"GS_Review & Ratings+Risk+LROD" /mnt/ -o username=$CHOICE_USER,password=$PASSWORD,domain=WORKGROUP

# Check if the mount was successful
if [[ $? -ne 0 ]]; then
    log "Failed to mount the network drive. Please check your credentials and network connection."
    send_email "LROD Backup Failed" "Failed to mount the network drive. Please check your credentials and network connection."
    exit 1
fi

# Ensure target directory exists
if [[ ! -d $path ]]; then
    mkdir -p $path
    log "Created directory $path."
else
    log "Directory $path already exists."
fi

# Change to the video location directory
cd $video_location || { log "Failed to change directory to $video_location."; umount /mnt; send_email "LROD Backup Failed" "Failed to change directory to $video_location."; exit 1; }

# Logging start time
start_time=$(date)
log "Backup started for $file_name at: $start_time"

# File synchronization
rsync --progress -ahv --include="*$file_name*" --exclude="*" $video_location $path

# Check if rsync was successful
if [[ $? -ne 0 ]]; then
    log "File synchronization for $file_name failed."
    umount /mnt
    send_email "LROD Backup Failed" "File synchronization for $file_name failed."
    exit 1
fi

# Unmount the network drive
umount /mnt

# Logging end time
end_time=$(date)
log "Backup completed for $file_name at: $end_time"
send_email "LROD Backup Success" "Backup completed successfully for $file_name."

log "Script for LROD_Video_Backup completed successfully."
