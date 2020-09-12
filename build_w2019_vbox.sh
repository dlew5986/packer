#!/bin/bash

# exit immediately if a command returns a non-zero status
set -e

# record start
startDateTimeStamp=$(date +%FT%T)
start=$SECONDS

# validate
packer validate ./w2019_vbox.json

# build
packer build -force ./w2019_vbox.json

# remove box from vagrant
#vagrant box remove w2019gui-virtualbox-01base

# add box to vagrant
#vagrant box add --name w2019gui-virtualbox-01base ~/Projects/packer/output/box-file-virtualbox/w2019gui-virtualbox-01base.box

# record end and calculate runtime duration
end=$SECONDS
durationTotal=$((end-start))

# echo runtime
echo "started        ${startDateTimeStamp}"
echo "finished       $(date +%FT%T)"
echo "total runtime  $(($durationTotal / 60))m $(($durationTotal % 60))s"
