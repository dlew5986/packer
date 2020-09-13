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

# add box to vagrant
vagrant box add --name w2019_virtualbox --force ~/Projects/packer/output/box_files/w2019_virtualbox.box

# record end and calculate runtime duration
end=$SECONDS
durationTotal=$((end-start))

# echo runtime
echo "started        ${startDateTimeStamp}"
echo "finished       $(date +%FT%T)"
echo "total runtime  $(($durationTotal / 60))m $(($durationTotal % 60))s"
