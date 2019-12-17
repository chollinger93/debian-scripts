#!/bin/bash
# Prints log messages

# Constants
RED='\033[0;31m'
YELLOW='\033[0;33m'
DEF='\033[0m'
BLUE='\033[0;34m'

logErr(){
	local msg="$(date): ${1}"
	>&2 echo -e "${RED}${msg}${DEF}" 
}

logWarn(){
	local msg="$(date): ${1}"
	echo -e "${YELLOW}${msg}${DEF}"
}

log(){
	local msg="$(date): ${1}"
	echo -e "${NC}${msg}"
}

logCol(){
	local msg="$(date): ${1}"
	echo -e "${BLUE}${msg}${DEF}"
}
