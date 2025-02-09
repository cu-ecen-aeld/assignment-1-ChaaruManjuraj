#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Error: Usage: finder.sh <filesdir> <searchstr>"
    exit 1
fi

filesdir="$1"
searchstr="$2"

if [ ! -d "$filesdir" ]; then
    echo "Error: $filesdir is not a directory"
    exit 1
fi

count_files_and_lines() {
    local dir="$1"
    local search="$2"
    local file_count=0
    local line_count=0

    while IFS= read -r -d $'\0' file; do
        ((file_count++))
        local matching_lines
        matching_lines=$(grep -c "$search" "$file" || true)
        ((line_count+=matching_lines))
    done < <(find "$dir" -type f -print0)

    echo "FILES=$file_count"
    echo "LINES=$line_count"
}

output=$(count_files_and_lines "$filesdir" "$searchstr")

num_files=0
num_lines=0

while IFS= read -r line; do
    case $line in
    FILES=*)
      num_files="${line#FILES=}"
      ;;
    LINES=*)
      num_lines="${line#LINES=}"
      ;;
    esac
done <<< "$output"

echo "The number of files are $num_files and the number of matching lines are $num_lines"
exit 0