#!/bin/bash

# record start time
start=$SECONDS

# validate packer template
packer validate -var-file=variables/w2019gui.json ./w2019-01base.json

# only virtualbox
packer build -force -var-file=variables/w2019gui.json -only=virtualbox ./w2019-01base.json

# remove box from vagrant
vagrant box remove w2019gui-virtualbox-01base

# add box to vagrant
vagrant box add --name w2019gui-virtualbox-01base ~/Projects/packer/output/box-file-virtualbox/w2019gui-virtualbox-01base.box

# record end time
end01base=$SECONDS

# calculate and echo runtime
duration01base=$((end01base-start))
echo "runtime 01base $(($duration01base / 60))m $(($duration01base % 60))s"
echo "completed $(date)"
