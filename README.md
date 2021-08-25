# pwnDockerAll

语言: [English](https://github.com/PIG-007/pwnDockerAll/blob/master/README_en-US.md) | [中文简体](https://github.com/PIG-007/pwnDockerAll/blob/master/README.md)

建立所有glibc版本的Pwn环境，只需要以下的几行命令和docker环境。

## Docker包含

+ `pwndbg`:[pwndbg/pwndbg: Exploit Development and Reverse Engineering with GDB Made Easy (github.com)](https://github.com/pwndbg/pwndbg)
+ `Pwngdb`:[scwuaptx/Pwngdb: gdb for pwn (github.com)](https://github.com/scwuaptx/Pwngdb)
+ `peda`:[longld/peda: PEDA - Python Exploit Development Assistance for GDB (github.com)](https://github.com/longld/peda)
+ `pwntools`:[Gallopsled/pwntools: CTF framework and exploit development library (github.com)](https://github.com/Gallopsled/pwntools)
+ `other essential`:ROPgadget..and so on

## 安装

安装之前，还需要下载`docker.io`。并且确保你的docker容器能够联网！

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

## 使用

终端上切换目录到pwn题处

```bash
dockerPwnRun [pwnfileDir] [docker_images_name]
dockerPwnRun [pwnfileDir] [docker_images_name] -g [port]
```

pwn题在启动容器之后位于根目录的/ctf/下

![Snipaste_2021-08-24_21-27-40](https://i.loli.net/2021/08/24/dCtDygz936Lmvbl.png)

由于容器启动是使用的映射关系启动，所有pwn题也是从主机映射到容器中的。所以你可以改变`exp.py`的内容在宿主机中，对应的容器中的`exp.py`也会相应改变，从而不需要在命令行中进行`exp.py`的修改。

此外，当你退出容器时，容器会自动删除，不会占据其他的空间。

安装之后可以使用以下命令检查安装的`docker`镜像

```bash
docker images
```

## 其他功能

### 查找Gadget

为了方便查找Gadget，在创建`docker`镜像的时候就将对应的`libc.so`和`ld.so`文件拷贝出来放在了`dockerLibc`中。

### 添加其他Libc版本

理论上来说，只要可以提供对应Libc版本的`ubuntu`的`sources.list`，并且`docker hub`中有对应版本的`ubuntu`，那么就能够安装其他版本Libc的`docker`。但是安装之前需要修改以下的相关配置：

```bash
#the configuration is in setup.sh

dic=([2.23]="16.04"  [2.24]="17.04" [2.26]="17.10"
    [2.27]="18.04"  [2.28]="18.10" [2.29]="19.04"
    [2.30]="19.10"  [2.31]="20.04" [2.32]="20.10"
    [2.33]="21.04" [2.34]="22.04")
```

添加对应版本的对应关系，如下：

```bash
#the configuration is in setup.sh

dic=([2.19]="14.04" [2.23]="16.04"  [2.24]="17.04" [2.26]="17.10"
    [2.27]="18.04"  [2.28]="18.10" [2.29]="19.04"
    [2.30]="19.10"  [2.31]="20.04" [2.32]="20.10"
    [2.33]="21.04" [2.34]="22.04")
```

比如新增的 `[2.19]="14.04"` 。

### 实现GDB attach功能

在启动容器时加入参数即可实现类似 `gdb.attach(p)`的功能！

```bash
dockerPwnRun [pwnfileDir] [docker_images_name] -g 30001
```

这个端口需要自己指定的。

```python
#In exp.py

def dockerDbg():
	myGdb = remote("127.0.0.1",30001)
	myGdb.close()
	pause()
```

这个功能是基于`docker`的`host`网络。

### 其他终端

默认的终端是`gnome-terminal`，但是可以设置自己对应的中断。终端修改的配置文件在`terminalConfig`中，可以修改成默认支持的其他终端。

默认支持的终端有以下几种：

+ `gnome-terminal`
+ `xterm`
+ `xfce4-terminal`

同样也可以添加其他的终端，只要该终端支持设置参数运行bash即可，比如`terminator`:

```bash
terminalList=(gnome-terminal xterm xfce4-terminal terminator)

if [ "${terminal}" == "terminator" ];then
	#echo "gnome-terminal"
	sudo terminator -x bash -c "~/pwnDockerAll/dockerGDBOut;exec bash" bash"
	exit 1;
fi
```

### 用Glibc源码调试

在创建`docker`镜像之前，在 `setup.sh` 中取消注释下列语句，就可以实现源码调试。

You could uncomment the follow statement in the file `setup.sh` before creating docker image.

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

### 自定义`Docker`镜像

在创建`docker`镜像之前，在 `setup.sh` 中对应位置添加相关语句即可加入自己的东西到`docker`镜像中。

```bash
##add your own thing here----------------------------
docker cp file $version_images:/root/
```

### 安装其他软件

同样在创建`docker`镜像之前，在 `install.sh` 中对应位置添加相关语句即可加入自己的东西到`docker`镜像中。

