#!/bin/bash

# Functions to generate neat badges using `anybadge` for `Python`

createCoverageBadge(){
    local covxml="${1}"
    local out="${2}"
    coverage=$(sed -n 2p $covxml | egrep -o "line-rate=\"0.([0-9]){1,4}\"" | egrep -o "[+-]?([0-9]*[.])?[0-9]+")
    coverage=$(echo "$coverage*100" | bc)
    anybadge -o --value=$coverage --file=$out coverage
}

createTestBadge(){
    local pytestStatus=$1
    local out="${2}"
    if [ $pytestStatus -eq 0 ]; then
        anybadge -o --label=pytest --value=pass --file=$out pass=green fail=red
    else
        anybadge -o --label=pytest --value=fail --file=$out pass=green fail=red
    fi 
}