#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/logging.sh"

if [[ $# -ge 2 ]]; then
    THRESHOLD=$1
    ROOT_DIR=$2
else
    logErr "Arguments: \$threshold \$output_dir"
    exit 1
fi

# Creates random files 
#ROOT_DIR="/home/${USER}/testfiles/"
mkdir -p $ROOT_DIR
for ((i=0; i<=THRESHOLD; i++)); do
    RANDOM_PATH="${ROOT_DIR}${RANDOM}/"
    RANDOM_FILE="${RANDOM}"
    FILE_SIZE=$(( RANDOM + 1024 ))
    mkdir -p "${RANDOM_PATH}"
    log "Creating file ${RANDOM_PATH}${RANDOM_FILE} with ${FILE_SIZE} bytes"
    head -c $FILE_SIZE /dev/urandom > "${RANDOM_PATH}${RANDOM_FILE}"
done
