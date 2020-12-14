#!/bin/bash

args="--regex --rules regexes.json --entropy=False"

if [ -n "${INPUT_BRANCH}" ]; then
  args="${args} --branch ${INPUT_BRANCH}"
fi

cp /regexes.json .
/usr/local/bin/trufflehog ${args} . > logs.txt
#https://unix.stackexchange.com/questions/14684/removing-control-chars-including-console-codes-colours-from-script-output
sed -i -e "s/\x1b\[.\{1,5\}m//g" logs.txt #Removing bash color sequences
#status_code=$(echo ${PIPESTATUS[0]})
echo "::set-output name=result::$(cat logs.txt)"
#echo "::set-output name=status_code::$status_code"
