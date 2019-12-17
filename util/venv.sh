#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "${DIR}/logging.sh"

check_create_venv(){
    if [[ $# -ge 1 ]]; then
	    log "Using input path"
	    rel_path="${1}"
    else
	    log "Using standard relative path from utils"
	    rel_path=".."
    fi
    res=$(pip3 -V)
    pws=$(cd "${rel_path}" && pwd)

    # -z $(echo "${res}" | grep "${pws}")
    #logErr "Comparing ${res} ${pws}"
    #if [[ "${pws}" == *"${res}"*  ]]; then
    if [[ "${VIRTUAL_ENV}" != "" ]]; then
        log "Venv is active!"
    else
        log "Installing venv in ${rel_path}!"
        cd "${rel_path}"
        python3 -m venv env
        . env/bin/activate
        cd -
        return 1
    fi
    return 0
}

