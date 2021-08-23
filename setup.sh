#! /bin/bash

if [ $# != 1 ] ; then
echo "Usage:./setup.sh [glibc-version]"
echo "Example:./setup.sh 2.23"
exit 1;
fi

declare -A dic
dic=([2.23]="16.04"  [2.24]="17.04" [2.26]="17.10"
    [2.27]="18.04"  [2.28]="18.10" [2.29]="19.04"
    [2.30]="19.10"  [2.31]="20.04" [2.32]="20.10"
    [2.33]="21.04" [2.34]="22.04")

version_glibc="$1"
version_ubuntu="ubuntu:${dic["$1"]}"
conName="con$version_glibc"



docker pull $version_ubuntu
docker run -d --name $conName $version_ubuntu /bin/bash -c 'cd && ./install.sh'

version_images=$version_glibc
docker cp ./$version_glibc/sources.list $conName:/etc/apt
docker cp ./install.sh $conName:/root/
docker start $conName
docker logs -f $conName
docker commit -m "pwn" -a "PIG-007" $conName $version_images
docker stop $conName
docker rm $conName
docker rmi $version_ubuntu
chmod a+x dockerpwn_run
cp dockerpwn_run /usr/bin
