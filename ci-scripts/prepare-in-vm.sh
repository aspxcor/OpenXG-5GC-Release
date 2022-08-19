#!/bin/bash
sudo apt install git -y --force-yes
echo "successfully installed git..."
if [ -d "openxg-5gcs-release" ]; then
        rm -rf openxg-5gcs-release
fi

git clone --branch master http://luhan:wangarafat@git.opensource5g.org/openxg/openxg-5gcs-release.git
echo "successfully cloned project"

sudo -i
echo -e " \
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse \n \
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse \n \
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse \n \
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse \n \
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse \n \
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse \n \
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse \n \
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse \n \
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse \n \
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse \n \
" > /etc/apt/sources.list
sudo apt update
cd /home/ubuntu/openxg-5gcs-release
sudo ./scripts/install.sh -I 

sudo echo -e "{ \n \
    \"registry-mirrors\": [ \n  \
            \"https://docker.mirrors.ustc.edu.cn\" \n \
                ] \n  \
}  \n \
"  >  /etc/docker/daemon.json
exit
sudo service docker restart

sudo docker network create docker-openxg --subnet=172.11.200.0/24 -o com.docker.network.bridge.name=docker-openxg