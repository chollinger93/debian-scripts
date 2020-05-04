#/bin/bash

COLS=
parseInput(){
	
	local col="${1}"
	local type=$(echo "${2}" | awk '{print tolower($0)}')
	
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/logging.sh"

if [[ $# -ge 2 ]]; then
    THRESHOLD=$1
    OUTPATH="${2}"
else
    logErr "Arguments: \$threshold \$outpath"
    exit 1
fi

# Parse columns
col="y"
cols=()
while ! [ "${col}" == "n" ]; do
	log "Please enter a column as <name,type>, whereas type should be either \"string\" or \"number\". Once you are done, type 'n'"
	read col
	if ! [ "${col}" == "n" ]; then
		cols+=( "${col}" )
	fi
done

# Generate
header="id"
for i in $(seq 1 $THRESHOLD); do
	line="${i}"
	for var in "${cols[@]}"; do
		col=$(echo "${var}" | cut -d, -f1)
		ttype=$(echo "${var}" | cut -d, -f2 | awk '{print tolower($0)}')
		# header
		if [ "${i}" == "1" ]; then
			header=$(echo "${header},${col}")
			echo "${header}" > "${OUTPATH}"
		fi
		# data
		if [ "${ttype}" == "string" ]; then
			rlen=$(echo $((1 + RANDOM % 10)))
			rcol=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $rlen | head -n 1)
			rcol="\"${rcol}\""
		elif [ "${ttype}" == "number" ]; then
			rcol=$(echo $((1 + RANDOM % 10000)))
		else
			logErr "Invalid type $ttype"
			continue
		fi
		# Add col
		line=$(echo "${line},${rcol}")
	done
	echo "${line}" >> "${OUTPATH}"
done

log "Done, wrote to ${OUTPATH}"
head "${OUTPATH}"
