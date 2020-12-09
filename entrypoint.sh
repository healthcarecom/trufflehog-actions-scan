#!/bin/bash

args="--regex --rules regexes.json --entropy=False"

if [ -n "${INPUT_BRANCH}" ]; then
  args="${args} --branch ${INPUT_BRANCH}"
fi

cp /regexes.json .
/usr/local/bin/trufflehog ${args} . |tee > logs.txt
echo "::set-output name=output::$(cat logs.txt)"
echo "::set-output name=status_code::0"