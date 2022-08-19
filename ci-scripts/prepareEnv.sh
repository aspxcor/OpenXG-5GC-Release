#!/bin/bash
ALL_VMS=$(sudo uvt-kvm list)
VM_NAME="vmtest"
CURRENT_PATH=`pwd`
echo $ALL_VMS
result=$(echo $ALL_VMS | grep "${VM_NAME}")
if [ "$result" == "" ];then
    echo "target VM doesn't exist.."
    exit 1 ## VM doesn't exist
fi
VM_IP=`sudo uvt-kvm ip ${VM_NAME}`

ssh -T -o StrictHostKeyChecking=no ubuntu@${VM_IP} < $CURRENT_PATH/ci-scripts/prepare-in-vm.sh