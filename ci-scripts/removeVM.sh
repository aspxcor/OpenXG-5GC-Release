#/bin/bash

ALL_VMS=$(sudo uvt-kvm list)
VM_NAME="vmtest"
echo $ALL_VMS
result=$(echo $ALL_VMS | grep "${VM_NAME}")
echo $result
if [ "$result" != "" ];then
    echo "Found target VM"
    uvt-kvm destroy $VM_NAME  ## if exist testing vm, then remove it
fi
echo "VM removed, clean up"