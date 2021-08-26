# pwnDockerAll

Language: [English](https://github.com/PIG-007/pwnDockerAll/blob/master/README_en-US.md) | [中文简体](https://github.com/PIG-007/pwnDockerAll/blob/master/README.md)

只用几个命令建立PWN环境，只需要Docker!

## Docker镜像包含

+ `pwndbg`:[pwndbg/pwndbg: Exploit Development and Reverse Engineering with GDB Made Easy (github.com)](https://github.com/pwndbg/pwndbg)
+ `Pwngdb`:[scwuaptx/Pwngdb: gdb for pwn (github.com)](https://github.com/scwuaptx/Pwngdb)
+ `peda`:[longld/peda: PEDA - Python Exploit Development Assistance for GDB (github.com)](https://github.com/longld/peda)
+ `pwntools`:[Gallopsled/pwntools: CTF framework and exploit development library (github.com)](https://github.com/Gallopsled/pwntools)
+ `other essential`:ROPgadget..and so on

## 安装

需要先安装 `docker.io`，并且确保你的容器能够连上网络。

```bash
cd ~/
git clone https://github.com/PIG-007/pwnDockerAll.git 
#git clone https://gitee.com/Piggy007/pwnDockerAll.git
cd pwnDockerAll
chmod a+x setup.sh
sudo ./setup.sh [libc_version]
#such as this:
#sudo ./setup.sh 2.33
```

## 使用方法

终端改变路径到需要的PWN题处

```bash
dockerPwnRun [pwnfileDir] [docker_images_name]
dockerPwnRun [pwnfileDir] [docker_images_name] -g [port]
```

映射的PWN文件目录在/ctf/下

![Snipaste_2021-08-24_21-27-40](https://i.loli.net/2021/08/24/dCtDygz936Lmvbl.png)

由于PWN文件目录是从宿主机映射到容器中的，所以你可以在宿主机中修改文件`exp.py`。

除此之外，当从容器中退出时，容器会自动删除，不会占用空间，即开即用。

可以用以下命令查看`Docker`镜像：

```bash
docker images
```

## 其他功能

### 获取其他版本Libc环境

理论上，只要提供了该Libc版本对应ubuntu的`sources.list `，并且`Docker hub`也有该版本的ubuntu就可以创建。但是需要修改以下配置文件：

```bash
#the configuration is in setup.sh

dic=([2.23]="16.04"  [2.24]="17.04" [2.26]="17.10"
    [2.27]="18.04"  [2.28]="18.10" [2.29]="19.04"
    [2.30]="19.10"  [2.31]="20.04" [2.32]="20.10"
    [2.33]="21.04" [2.34]="22.04")
```

添加对应Libc版本的ubuntu，如下：

```bash
#the configuration is in setup.sh

dic=([2.19]="14.04" [2.23]="16.04"  [2.24]="17.04" [2.26]="17.10"
    [2.27]="18.04"  [2.28]="18.10" [2.29]="19.04"
    [2.30]="19.10"  [2.31]="20.04" [2.32]="20.10"
    [2.33]="21.04" [2.34]="22.04")
```

比如这里新建 `[2.19]="14.04"` 

### 支持GDB attach功能

使用时加入-g参数，并指定端口即可使用类似 `gdb.attach(p)` 的功能，这个功能需要安装`socat`

```
apt-get install socat
```

然后就类似如下启动语句：

```bash
dockerPwnRun [pwnfileDir] [docker_images_name] -g 30001
```

`exp.py`中设置如下：

```python
#In exp.py

def dockerDbg():
	myGdb = remote("127.0.0.1",30001)
	myGdb.close()
	pause()
```

这个功能是基于Docker的host网络的

### 其他终端添加

默认的终端是`gnome-terminal`。但是可以自己设置自己的终端，在`terminalConfig`文件下设置，默认支持的终端如下：

+ `gnome-terminal`
+ `xterm`
+ `xfce4-terminal`

同样可以添加其他终端，在文件`dockerTerm`中设置，添加对应语句，比如添加`terminator` :

```bash
terminalList=(gnome-terminal xterm xfce4-terminal terminator)

if [ "${terminal}" == "terminator" ];then
	#echo "gnome-terminal"
	sudo terminator -x bash -c "~/pwnDockerAll/dockerGDBOut;exec bash" bash"
	exit 1;
fi
```

### 用Glibc源码来调试

在安装对应版本的Docker镜像之前可以去掉在文件 `setup.sh` 中以下语句的注释来获得源码调试功能。

```bash
##gdb sources----------------------------------------

wget -P ./glibcFile/$version_images/ http://ftp.gnu.org/gnu/glibc/glibc-$version_images.tar.gz
tar -zxvf ./glibcFile/$version_images/glibc-$version_images.tar.gz -C ./glibcFile/$version_images/
docker cp ./glibcFile/$version_images/glibc-$version_images/ $conName:/root/glibc-src/
```

```bash
##add your own thing here----------------------------

docker exec $conName /bin/bash -c "sed -i 'N;6 i dir ~/glibc-src/malloc' ~/.gdbinit"
```

### 添加自己的东西

创建镜像之前可以在文件 `setup.sh`下列语句中添加自己的东西

```bash
##add your own thing here----------------------------
docker cp file $version_images:/root/
```

### 安装其他软件

可以在文件`install.sh`安装其他软件来实现其他功能

