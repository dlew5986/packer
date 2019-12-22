#!/bin/zsh

# record start time
startDateTimeStamp=$(date +%FT%TE)
start=$SECONDS

# 01base
packer validate ./w2019-ami.json
packer build -force ./w2019-ami.json
end=$SECONDS

# calculate runtime
durationTotal=$((end-start))

# echo runtime
echo "started        ${startDateTimeStamp}"
echo "finished       $(date +%FT%TE)"
echo "total runtime  $(($durationTotal / 60))m $(($durationTotal % 60))s"
