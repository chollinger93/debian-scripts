#!/bin/bash
source ../util/logging.sh
if [[ -z $SUDO_USER ]]; then
	logErr "Script must be called as sudo"
	exit 1
fi

if [[ $# -gt 1 ]]; then
	log "Using command line args $1 $2"
	SERVER="${1}"
	MOUNTPOINT="${2}"
else
	log "Using defaults"
	SERVER="//nas/1TB"
	MOUNTPOINT="/mnt/shares/1TB-Server"
fi

# Checking credentials
if [[ ! -f /etc/samba/credentials/share ]]; then
	logErr "No /etc/samba/credentials/share exists"
	exit 1
fi

log "Mounting $SERVER at $MOUNTPOINT"
mount -t cifs "${SERVER}" "${MOUNTPOINT}" -o credentials=/etc/samba/credentials/share,uid=$(id -u),gid=$(id -g)
