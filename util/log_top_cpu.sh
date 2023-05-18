#!/bin/bash

set -eou pipefail

# Modified from: https://stackoverflow.com/questions/34992167/how-to-capture-unix-top-command-output-to-a-csv-file
# Every 5 mins:
# */5 * * * * > /var/log/cpu.log 2>&1
# Format:
# DATE,PID,USER,PR,NI,VIRT,RES,SHR,S,%CPU,%MEM,TIME+,COMMAND
top -b -n 3 | sed -n '8, 12{s/^ *//;s/ *$//;s/  */,/gp;};12q' | sed -e "s/^/$(date +"%Y-%m-%dT%H:%M:%S%z"),/"
