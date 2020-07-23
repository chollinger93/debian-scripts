#!/bin/bash
echo "Warning: Utility power failure has occurred for a while, system will be shutdown soon!" | wall

export RECEIPT_NAME
export RECEIPT_ADDRESS
export SENDER_ADDRESS

#
# If you want to receive event notification by e-mail, you must change 'ENABLE_EMAIL' item to 'yes'.
# Note: After change 'ENABLE_EMAIL' item, you must asign 'RECEIPT_NAME', 'RECEIPT_ADDRESS', and 
# 'SENDER_ADDRESS' three items as below for the correct information.
#

# Enable to send e-mail
ENABLE_EMAIL=no

# Change your name at this itme.
RECEIPT_NAME="user name"

# Change mail receiver address at this itme.
RECEIPT_ADDRESS=user_name@company.com

# Change mail sender address at this itme.
SENDER_ADDRESS=user_name@company.com

# Execute the 'pwrstatd-email.sh' shell script
if [ $ENABLE_EMAIL = yes ]; then
   /etc/pwrstatd-email.sh
fi

# Unmount
# This regex matches ignored drives
STATIC_MOUNT_REGEX="usb$"

mountedDrives=$(cat /proc/mounts  | grep mnt | cut -d' ' -f2 | egrep -v "${STATIC_MOUNT_REGEX}")
while IFS= read -r dr; do
    echo "Removing ${dr}!"
    umount "${dr}" 
done <<< "$mountedDrives"

