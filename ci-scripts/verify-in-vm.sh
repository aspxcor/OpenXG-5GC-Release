#!/bin/bash

cd openxg-5gcs-release/ci-scripts
sudo docker pull hogostan/ueransim:1.0
sudo docker run -d -ti -v /home/ubuntu/openxg-5gcs-release/ci-scripts/etc:/etc/openxg/ --privileged=true --net=docker-openxg --name=openxg-ueransim --ip=172.11.200.2 hogostan/ueransim:1.0 /UERANSIM/build/nr-gnb -c /etc/openxg/gnb.yaml
echo "started gNB"
sleep 1
sudo docker exec -ti -d openxg-ueransim  /UERANSIM/build/nr-ue -c /etc/openxg/ue.yaml
echo "started UE"
sleep 10
line=`sudo docker exec openxg-ueransim ping www.baidu.com -c 1 -s 1 -W 1 -I uesimtun0| grep "0% packet loss" | wc -l`
if [ $line == "1" ];then
    echo "successfully ping"
else
    echo "cannot ping"
    exit 1 ## cannot ping, through an error
fi