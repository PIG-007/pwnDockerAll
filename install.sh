apt-get -y update
apt-get -y  install vim
apt-get -y  install libxml2-dev
apt-get -y  install libxslt-dev
apt-get -y  install libterm-readkey-perl
apt-get -y  install python-dev
apt-get -y  install wget
apt-get -y  install gcc
apt-get -y  install make
apt-get -y  install zip
apt-get -y install python-setuptools python-pip python-smbus
apt-get -y install build-essential libncursesw5-dev libgdbm-dev libc6-dev
apt-get -y install zlib1g-dev libsqlite3-dev tk-dev
apt-get -y install libssl-dev openssl
apt-get -y install libffi-dev
apt-get -y install virtualenv
apt-get -y install libmysqlclient-dev


wget https://pypi.python.org/packages/45/29/8814bf414e7cd1031e1a3c8a4169218376e284ea2553cc0822a6ea1c2d78/setuptools-36.6.0.zip#md5=74663b15117d9a2cc5295d76011e6fd1
unzip setuptools-36.6.0.zip
cd setuptools-36.6.0
python2 setup.py install
cd ../
wget https://pypi.python.org/packages/11/b6/abcb525026a4be042b486df43905d6893fb04f05aac21c32c638e939e447/pip-9.0.1.tar.gz#md5=35f01da33009719497f01a4ba69d63c9
tar -zxvf pip-9.0.1.tar.gz
cd pip-9.0.1
python2 setup.py install
python2 -m pip install --upgrade pip
python3 setup.py install
python3 -m pip install --upgrade pip
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
git clone https://gitee.com/Piggy007/peda.git


