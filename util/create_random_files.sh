#!/bin/bash
source ./logging.sh

# Creates random files 
ROOT_DIR="/home/${USER}/testfiles/"
mkdir -p $ROOT_DIR
for n in {1..10}; do
    RANDOM_PATH="${ROOT_DIR}${RANDOM}/"
    RANDOM_FILE="${RANDOM}"
    FILE_SIZE=$(( RANDOM + 1024 ))
    mkdir -p "${RANDOM_PATH}"
    log "Creating file ${RANDOM_PATH}${RANDOM_FILE} with ${FILE_SIZE} bytes"
    head -c $FILE_SIZE /dev/urandom > "${RANDOM_PATH}${RANDOM_FILE}"
done
