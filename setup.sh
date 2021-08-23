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



#creat docker and previous work
docker pull $version_ubuntu
docker run -d --name $conName $version_ubuntu /bin/bash -c 'cd && ./install.sh'

version_images=$version_glibc
docker cp ./sources/$version_glibc/sources.list $conName:/etc/apt
docker cp ./install.sh $conName:/root/
docker cp ./soft/setuptools-36.6.0.zip $conName:/root/
docker cp ./soft/pip-9.0.1.tar.gz $conName:/root/

#start download
docker start $conName
docker logs -f $conName
docker commit -m "pwn" -a "PIG-007" $conName $version_images
docker stop $conName


#create dir and copy libc&ld file
mkdir -p $(pwd)/dockerLibc/$version_glibc/64
mkdir -p $(pwd)/dockerLibc/$version_glibc/32
docker cp $conName:/lib/x86_64-linux-gnu/libc-$version_glibc.so $(pwd)/dockerLibc/$version_glibc/64/
docker cp $conName:/lib/x86_64-linux-gnu/ld-$version_glibc.so $(pwd)/dockerLibc/$version_glibc/64/

docker cp $conName:/lib/i386-linux-gnu/libc-$version_glibc.so $(pwd)/dockerLibc/$version_glibc/32/
docker cp $conName:/lib/i386-linux-gnu/ld-$version_glibc.so $(pwd)/dockerLibc/$version_glibc/32/

#free space
docker rm $conName
docker rmi $version_ubuntu

#get command
chmod a+x dockerpwn_run
cp dockerpwn_run /usr/bin
