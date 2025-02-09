#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Error: Usage: writer.sh <writefile> <writestr>"
  exit 1
fi

writefile="$1"
writestr="$2"

mkdir -p "$(dirname "$writefile")"

echo "$writestr" > "$writefile"

if [ $? -ne 0 ]; then
  echo "Error: Could not write to file $writefile"
  exit 1
fi

exit 0