#!/bin/bash

# record start time
start=$SECONDS

# validate packer template
packer validate -var-file=variables/w2019gui.json ./w2019-09sysprep.json

# only virtualbox
packer build -force -var-file=variables/w2019gui.json -only=virtualbox ./w2019-09sysprep.json

# remove box from vagrant
vagrant box remove w2019gui-virtualbox-09sysprep

# add box to vagrant
vagrant box add --name w2019gui-virtualbox-09sysprep ~/Projects/packer/output/box-file-virtualbox/w2019gui-virtualbox-09sysprep.box

# record end time
end09sysprep=$SECONDS

# calculate and echo runtime
duration09sysprep=$((end09sysprep-start))
echo "runtime 09sysprep $(($duration09sysprep / 60))m $(($duration09sysprep % 60))s"
echo "completed $(date)"
