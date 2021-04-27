#!/bin/bash

# exit immediately if a command returns a non-zero status
set -e

# record start
startDateTimeStamp=$(date +%FT%T)
start=$SECONDS

# export aws region
#export AWS_REGION=us-east-2

# export external ip in CIDR notation
export SOURCE_CIDR=$(curl -s ifconfig.co)/32

# echo
#echo "aws_region  = ${AWS_REGION}"
echo "source_cidr = ${SOURCE_CIDR}"

# validate
packer validate w2019_aws.json

# build
packer build w2019_aws.json

# record end and calculate runtime duration
end=$SECONDS
durationTotal=$((end-start))

# echo runtime
echo "started        ${startDateTimeStamp}"
echo "finished       $(date +%FT%T)"
echo "total runtime  $(($durationTotal / 60))m $(($durationTotal % 60))s"
