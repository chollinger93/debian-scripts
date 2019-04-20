#!/bin/sh
export GPG_KEY="YOUR_KEY_HERE"
SHARE="/mnt/shares/6TB-Server"
SERVER="192.168.1.213"
MOUNT="6TB"
MOUNT_PATH="/mnt/shares/6TB-Server"
if [ "${EUID}" -ne 0 ]; then
	echo "You're not root"
exit
fi
    
# Check if external drive is mounted
if [[ -z $(mount -t cifs | grep "${SHARE}") ]]; then
	echo "Disk not connected, trying mount"
	mount -t cifs //"{SERVER}/${MOUNT} ${MOUNT_PATH}" -o credentials=/etc/samba/credentials/share
	if [ $? -ne 0 ]; then
		export GPG_KEY=
      		exit 1
	else
		echo "Disk mounted!"
	fi
else
	echo "Disk available, continuing..."
fi
		      
# Make the regular backup
# Will be a full backup if past the older-than parameter
mkdir -p "${MOUNT_PATH}/backups/arch/"
duplicity --full-if-older-than 7D --encrypt-key=${GPG_KEY} --sign-key=${GPG_KEY} -exclude=/proc --exclude=/lost+found --exclude=/backups --exclude=/mnt --exclude=/sys --exclude=/opt/virtual /  "file://${MOUNT_PATH}/backups/arch/"
if [ $? -ne 0 ]; then
	echo "Backup failed!"
else
	echo "Backup done, good job"
fi
export GPG_KEY=
