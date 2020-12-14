#!/bin/bash

args="--regex --rules regexes.json --entropy=False"

if [ -n "${INPUT_BRANCH}" ]; then
  args="${args} --branch ${INPUT_BRANCH}"
fi

cp /regexes.json .
/usr/local/bin/trufflehog ${args} . > logs.txt
#https://unix.stackexchange.com/questions/14684/removing-control-chars-including-console-codes-colours-from-script-output
result="$(sed -e "s/\x1b\[.\{1,5\}m//g" logs.txt)"
echo $result
#https://github.community/t/set-output-truncates-multiline-strings/16852/3
result="${result//'%'/'%25'}"
result="${result//$'\n'/'%0A'}"
result="${result//$'\r'/'%0D'}"
echo "$result"
echo "::set-output name=result::$result"
#echo "::set-output name=status_code::$status_code"
