#!/bin/bash

args="--regex --rules regexes.json --entropy=False"

if [ -n "${INPUT_BRANCH}" ]; then
  args="${args} --branch ${INPUT_BRANCH}"
fi

cp /regexes.json .
/usr/local/bin/trufflehog ${args} . > logs.txt
sed -i -r 's/\\033\[.+m//' logs.txt #Removing bash color sequences
#status_code=$(echo ${PIPESTATUS[0]})
echo "::set-output name=result::$(cat logs.txt)"
#echo "::set-output name=status_code::$status_code"