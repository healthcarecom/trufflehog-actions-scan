#!/bin/bash

args="--regex --rules regexes.json --entropy=False"

if [ -n "${INPUT_BRANCH}" ]; then
  args="${args} --branch ${INPUT_BRANCH}"
fi

cp /regexes.json .
/usr/local/bin/trufflehog ${args} . > logs.txt
cat logs.txt
#status_code=$(echo ${PIPESTATUS[0]})
echo "::set-output name=result::$(cat logs.txt)"
#echo "::set-output name=status_code::$status_code"