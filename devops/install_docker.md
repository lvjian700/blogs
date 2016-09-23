#Run docker on your mac

这些年对Ops产生重大影响的工具应属[Docker][docker]了。Docker基于Golang的实现横空出世，让应用部署产生了革命性的变革。Docker的存在让部署变得如此的容易，这也让microservices这种架构方式得到了良好的实施。

关于Docker, 它解决了三个问题:

* Build
* Ship
* Run

本文讲讨论迈入Docker世界的第一步: `如何将Docker装在你的Mac OS上`

##在Mac OS上安装Docker

由于Docker底层基于linux, 在Mac OS上运行起来需要一个虚拟的linux环境，它需要价格工具:

* virtualbox: 虚拟机，用来跑linux
* docker-machine: 用来管理虚拟机，之前用过的boot2docker已经合并到这个工具中
* docker: docker本身
* docker-compose(Mac OS only): 用来管理多个docker container, 如果你想做DB和App分离将会用到这个工具
* Kitematic: 用来管理远程Docker Hub, 自己构建的Docker Image可以用它管理

如果你想直接All in one安装，直接到这里下载安装即可安装好上述工具:	
<https://www.docker.com/toolbox>    

个人倾向使用[Homebrew](http://brew.sh/)安装上述工具:

1. 安装virtualbox
2. 使用homebrew安装其他工具

```
brew install docker docker-machine docker-compose
brew cash install kitematic
```

##验证自己的环境

###使用`docker-machine`创建`docker host`

```
docker-machine create --driver virtualbox dev
```

`dev`是当前`docker host`名字

###配置当前docker host环境   

使用`docker-machine env dev`查看刚刚创建的`dev`的信息:

```
➜  devops  docker-machine env dev
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/lvjian/.docker/machine/machines/dev"
export DOCKER_MACHINE_NAME="dev"
# Run this command to configure your shell:
# eval "$(docker-machine env dev)"
```

将`dev`信息添加到环境变量中,这些环境变量将被`docker`使用.

```
eval "$(docker-machine env dev)"
```

###运行docker run

```
docker run helloworld
```

此时`docker`会从`docker hub`上将`hello-world:last` image pull 下来，然后运行对应的`Dockerfile`. 如果运行成功将会看到如下信息:

```
Hello from Docker.
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker Hub account:
 https://hub.docker.com

For more examples and ideas, visit:
 https://docs.docker.com/userguide/
```

除此之外我们还可以运行其他image: `docker run -it ubuntu bash `

到这里已经成功在mac os上安装了Docker.


##更多参考

* install docker: <http://docs.docker.com/mac/step_one/>
* docker hub: <https://hub.docker.com>
* docker user guide:  <https://docs.docker.com/userguide/>

[docker]: http://www.docker.com "Docker Home Page"
