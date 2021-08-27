#! /bin/bash

apt-get -y update
apt-get -y install tzdata
apt-get -y install vim
apt-get -y install libxml2-dev
apt-get -y install libxslt-dev
apt-get -y install libmysqlclient-dev
apt-get -y install libsqlite3-dev
apt-get -y install zlib1g-dev
apt-get -y install python-dev
apt-get -y install libffi-dev
apt-get -y install libssl-dev
apt-get -y install wget
apt-get -y install gcc
apt-get -y install make
apt-get -y install zip
apt-get -y install build-essential python-setuptools python-pip python-smbus
apt-get -y install libncursesw5-dev libgdbm-dev libc6-dev
apt-get -y install tk-dev
apt-get -y install openssl
apt-get -y install virtualenv



unzip setuptools-36.6.0.zip
cd setuptools-36.6.0
python2 setup.py install
python3 setup.py install
cd ../
tar -zxvf pip-9.0.1.tar.gz
cd pip-9.0.1
python2 setup.py install
python3 setup.py install

python2 -m pip install --upgrade pip
python3 setup.py install
python3 -m pip install --upgrade pip
pip2 config set global.index-url https://pypi.douban.com/simple/
pip3 config set global.index-url https://pypi.douban.com/simple/

cd ../
pip2 install pathlib2
pip2 install pwntools
pip3 install pwntools



cat >> ~/.vimrc << EOF
syntax on
set number
set scrolloff=6
EOF

apt-get -y install git
git clone https://gitee.com/Piggy007/pwndbg.git
cd pwndbg
./setup.sh
cd ../
git clone https://gitee.com/Piggy007/Pwngdb.git
cp ~/Pwngdb/.gdbinit ~/
sed -i 'N;2 i source ~/pwndbg/gdbinit.py' ~/.gdbinit
#git clone https://gitee.com/Piggy007/peda.git
apt -y autoremove