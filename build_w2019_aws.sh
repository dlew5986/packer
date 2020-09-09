#!/bin/bash

# record start
startDateTimeStamp=$(date +%FT%T)
start=$SECONDS

# get external ip in CIDR notation
ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
cidr=$ip/32
echo "cidr = ${cidr}"

# validate
packer validate -var "source_cidr=${cidr}" ./w2019-ami.json

# build
packer build -var "source_cidr=${cidr}" -force ./w2019-ami.json

# record end and calculate runtime duration
end=$SECONDS
durationTotal=$((end-start))

# echo runtime
echo "started        ${startDateTimeStamp}"
echo "finished       $(date +%FT%T)"
echo "total runtime  $(($durationTotal / 60))m $(($durationTotal % 60))s"
