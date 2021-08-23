# pwnDockerAll

Construct all pwn enviroment for just one command，only need docker!

## All docker include:

+ `pwndbg`:[pwndbg/pwndbg: Exploit Development and Reverse Engineering with GDB Made Easy (github.com)](https://github.com/pwndbg/pwndbg)
+ `Pwngdb`:[scwuaptx/Pwngdb: gdb for pwn (github.com)](https://github.com/scwuaptx/Pwngdb)
+ `peda`:[longld/peda: PEDA - Python Exploit Development Assistance for GDB (github.com)](https://github.com/longld/peda)
+ `pwntools`:[Gallopsled/pwntools: CTF framework and exploit development library (github.com)](https://github.com/Gallopsled/pwntools)
+ `other essential`:ROPgadget..and so on

## Installation

```bash
cd ~/
git clone https://github.com/PIG-007/pwnDockerAll.git 
#git clone https://gitee.com/Piggy007/pwnDockerAll.git
cd pwnDockerAll
sudo ./setup.sh
```

## Usages

Change path to the pwn topic

```bash
dockerpwn_run [docker_images_name] [pwnfileDir]
```

And the pwnfileDir is on /ctf/

![Snipaste_2021-08-23_20-03-45](https://i.loli.net/2021/08/23/MzBWvaetGQnOJDw.png)

The pwnfileDir is mapped to the docker from host machine.So,you could change it just under the host machine.

Besides,when you exit from the docker,the container will be removed,it won't occupy the space.

You could check the images:

```bash
docker images
```

