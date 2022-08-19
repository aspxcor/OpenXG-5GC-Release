#/bin/bash

ALL_VMS=$(sudo uvt-kvm list)
VM_NAME="vmtest"
echo $ALL_VMS
result=$(echo $ALL_VMS | grep "${VM_NAME}")
echo $result
if [ "$result" != "" ];then
    uvt-kvm destroy $VM_NAME  ## if exist testing vm, then remove it
fi
##创建一个虚拟机用于承载测试；
uvt-kvm create vmtest release=bionic --memory 8192 --disk 80 --cpu 4 --ssh-public-key-file ~/.ssh/id_rsa.pub
uvt-kvm wait $VM_NAME
echo "successfully created VM, name is vmtest"
