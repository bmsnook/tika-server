#!/bin/sh

## 
## Author: Brian Snook
## Version: 2018-07-31 01:49 EDT
## 
## PDFs and DOCX files in particular may have spaces in filenames; quote them when passing.
## 
## Tika usage:
##   Get filetype:
##     curl -s -X PUT --data-binary @"${INPUT_FILE}" http://${TIKAHOST}:9998/detect/stream
##   Get metadata:
##     curl -X PUT --data-ascii @${INPUT_FILE} http://${TIKAHOST}:9998/meta --header "Content-Type: ${FILE_TYPE}
##   Extract text:
##     curl -T "${INPUT_FILE}" http://${TIKAHOST}:9998/tika --header "Accept: text/plain"
## 

TIKAHOST=localhost
OUTPUT_FILE=""

usage() {
echo "    Usage:"
echo "      $0 -h"
echo "      $0 -i INPUT_FILE"
echo "      $0 INPUT_FILE"
}

while getopts "hi:" arg; do 
  case $arg in 
    h)
      usage
      exit 1
      ;;
    i)
      INPUT_FILE="${OPTARG}"
      ;;
    \?)
      echo "Invalid option: \""${OPTARG}"\" " >&2
      exit 2
      ;;
    :)
      echo "Option -${arg} requires an argument." >&2
      exit 2
      ;;
  esac
done


case "$#" in 
  0)
     usage
     exit 1
     ;;
  1)
     INPUT_FILE="${1}"
     ;;
esac


if [ -e "${INPUT_FILE}" ]; then
  :   # good to go
else
  echo "ERROR: \""${INPUT_FILE}"\" not found"
  exit 3
fi

# Determine the file type to use for extraction
FILE_TYPE=`curl -s -X PUT --data-binary @"${INPUT_FILE}" http://${TIKAHOST}:9998/detect/stream`

# Extract the text from the file
curl -T "${INPUT_FILE}" http://${TIKAHOST}:9998/tika --header "Accept: text/plain"
