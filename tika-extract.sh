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
echo "      $0 -i INPUT_FILE [-o OUTPUT_FILE]"
echo "      $0 INPUT_FILE"
}

while getopts "hi:o" arg; do 
  case $arg in 
    h)
      #echo "Usage: $0 -i INPUT_FILE [-o OUTPUT_FILE]"
      usage
      exit 1
      ;;
    i)
      INPUT_FILE="$OPTARG"
      ;;
    o)
      OUTPUT_FILE="${OPTARG}"
      ODIR=`dirname "${OUTPUT_FILE}"`
      OFILE=`basename "${OUTPUT_FILE}"`
      ;;
    \?)
#      echo "Invalid option: -$OPTARG" >&2
      echo "Invalid option: $OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -${arg} requires an argument." >&2
      exit 1
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

echo "Using INPUT_FILE = \"$INPUT_FILE\""

if [ -e "${INPUT_FILE}" ]; then
  :   # good to go
else
  echo "ERROR: \""${INPUT_FILE}"\" not found"
  exit 2
fi

if [ -e "${OUTPUT_FILE}" ]; then
  if [ -w "${OUTPUT_FILE}" ]; then 
    :
  else
    echo "WARN: \""${OUTPUT_FILE}"\" is not writable"
    echo "WARN: falling back to standard out"
  fi
else
  if [ -d "${ODIR}" ]; then
    if [ -w "${ODIR}" ]; then 
      :
    else
      echo "WARN: cannot write to \""${ODIR}"\" "
    fi
  else
    echo "WARN: output directory \""${ODIR}"\" does not exist"
  fi
fi


# Determine the file type to use for extraction
FILE_TYPE=`curl -s -X PUT --data-binary @"${INPUT_FILE}" http://${TIKAHOST}:9998/detect/stream`
echo ${FILE_TYPE}

# Extract the text from the file
curl -s -T "${INPUT_FILE}" http://${TIKAHOST}:9998/tika --header "Accept: text/plain"
