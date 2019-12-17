#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/../util/logging.sh"
source "${DIR}/../util/package_installed.sh"
export PASSPHRASE=YOUR_PASSPHRASE
export AWS_ACCESS_KEY_ID=YOUR_AWS_KEY
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY
GPG_KEY=YOUR_GPG_KEY
URL=YOUR_AWS_BUCKET

if [ "${EUID}" -ne 0 ]; then
        logErr "You're not root"
	exit 1
fi

# Checking dependencies
isInstalled "duplicity"
if [[ $? -ne 0 ]]; then
	exit 1
fi


# Delete any older than 1 month
duplicity remove-older-than 7D --force --encrypt-key=${GPG_KEY} --sign-key=${GPG_KEY} s3+${YOUR_AWS_BUCKET}

# Make the regular backup
# Will be a full backup if past the older-than parameter
duplicity --full-if-older-than 7D --encrypt-key=${GPG_KEY} --sign-key=${GPG_KEY} --exclude=/proc --exclude=/lost+found --exclude=/backups --exclude=/mnt --exclude=/sys --exclude=/opt/virtual /  s3+${YOUR_AWS_BUCKET}

export PASSPHRASE=
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=

