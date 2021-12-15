#!/bin/bash

generateFile() {
    local threshold=$1
    logWarn "Starting thread, will create $threshold files"
    for ((i=0; i<=threshold; i++)); do 
        rPath="${ROOT_DIR}${RANDOM}/"
        rFile="${RANDOM}"
        rFileSize=$(( RANDOM + 1024 ))
        mkdir -p "${rPath}"
        log "Creating file ${rPath}${rFile} with ${rFileSize} bytes"
        head -c $rFileSize /dev/urandom > "${rPath}${rFile}"
    done
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/logging.sh"

if [[ $# -ge 2 ]]; then
    THRESHOLD=$1
    ROOT_DIR=$2
else
    logErr "Arguments: \$threshold \$output_dir"
    exit 1
fi

# Creates random files in parallel
mkdir -p $ROOT_DIR
NUM_CPUS=$(nproc --all)
THRES_PER_LOOP=$(($THRESHOLD / $NUM_CPUS))
for ((i=0; i<=NUM_CPUS; i++)); do
    generateFile $THRES_PER_LOOP &
done
# Start remainder 
generateFile $(($THRESHOLD - $(($THRES_PER_LOOP * $NUM_CPUS)))) &

# Wait for all
wait 
# Check
total_size=$(du -hs $ROOT_DIR | cut -d'/' -f1)
num_files=$(find $ROOT_DIR -type f | wc -l)
echo "Generated $total_size in $num_files files in $ROOT_DIR"