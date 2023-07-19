#!/bin/bash

export TMP_DIR="/tmp"
export TEMP_LOG="/tmp/script-log.log"

if [ -z "$SCRIPT_NAME" ]; then
  export SCRIPT_NAME="unknown"
  >&2 printf "Warning: Script name not set! You won't be able to distinguish script logs properly \n Setting default script name: $SCRIPT_NAME \n"
fi

export SCRIPT_LOG="$SCRIPT_NAME.log"
log_files="$TEMP_LOG $SCRIPT_LOG"

date=$(date +"%Y-%m-%d %T")

echo "###############################$date##############################" >> $SCRIPT_LOG
echo "###############################$date##############################" >> $TEMP_LOG

# Zipping old log files
find $TMP_DIR -type f -name "$SCRIPT_NAME.*.log" -mtime +7 -exec gzip {} \;

log(){
    printf "$(date +"%Y-%m-%d %T") - INFO - $1 \n" | tee -a $log_files
}

error(){
    >&2 printf "$(date +"%Y-%m-%d %T") - ERROR - $1 \n" | tee -a $log_files
}

warning(){
    >&2 printf "$(date +"%Y-%m-%d %T") - WARN - $1 \n" | tee -a $log_files
}