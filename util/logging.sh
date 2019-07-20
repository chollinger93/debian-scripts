#!/bin/bash
# Prints log messages

# Constants
RED='\033[0;31m'
YELLOW='\033[0;33m'
DEF='\033[0m'

logErr(){
	local msg="${1}"
	>&2 echo -e "${RED}${msg}${DEF}" 
}

logWarn(){
	local msg="${1}"
	echo -e "${YELLOW}${msg}${DEF}"
}

log(){
	local msg="${1}"
	echo -e "${NC}${msg}"
}
