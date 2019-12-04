#!/bin/bash

# record start time
start=$SECONDS

# 01base
packer validate -var-file=variables/w2019gui.json ./w2019-01base.json
packer build -force -var-file=variables/w2019gui.json -only=virtualbox ./w2019-01base.json
vagrant box remove w2019gui-virtualbox-01base
vagrant box add --name w2019gui-virtualbox-01base ~/Projects/packer/output/box-file-virtualbox/w2019gui-virtualbox-01base.box
end01base=$SECONDS

# 09sysprep
packer validate -var-file=variables/w2019gui.json ./w2019-09sysprep.json
packer build -force -var-file=variables/w2019gui.json -only=virtualbox ./w2019-09sysprep.json
vagrant box remove w2019gui-virtualbox-09sysprep
vagrant box add --name w2019gui-virtualbox-09sysprep ~/Projects/packer/output/box-file-virtualbox/w2019gui-virtualbox-09sysprep.box
end09sysprep=$SECONDS

# calculate runtime
duration01base=$((end01base-start))
duration09sysprep=$((end09sysprep-end01base))
durationTotal=$((end09sysprep-start))

# echo runtime
echo "runtime 01base    $(($duration01base / 60))m $(($duration01base % 60))s"
echo "runtime 09sysprep $(($duration09sysprep / 60))m $(($duration09sysprep % 60))s"
echo "runtime total     $(($durationTotal / 60))m $(($durationTotal % 60))s"
echo "completed $(date)"
