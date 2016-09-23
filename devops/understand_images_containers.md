在使用Docker之前我们通常会使用[Vagrant](https://www.vagrantup.com/)来`build & share`一个开发环境。每个`Vagrant package`都是一个完整的虚拟主机，一个`package`通常有几个G。共享和更新几个G的package是很一件昂贵的事情。

在Docker世界中将`Vagrant`中的`package`拆成`containers` & `images`, 这两个概念支撑这整个Docker世界.	

* container: 一个剥掉壳的最小化linux
* image: 一个software, 它将会被加载到`container`中.

当运行`docker run helloworld`时，`docker`会做如下三件事情:

1. 在本地查找`hello-world` software image
2. 如果找不到，从Docker Hub上下载image
3. 将`image`加载到``container``中并`ran`

通常我们使用`docker-machine`管理`container`, 使用`docker`来运行`image`。`images`通过[DockerHub](https://hub.docker.com/)来共享。	

(如果你是[Github](http://github.com/)的使用者，你将会很轻松的上手`DockerHub`。关于`DockerHub`本文暂不做介绍)


##Docker中的container在哪?

`container`是一个剥了壳的，最基础的linux。在mac os中我们使用`docker-machine`来管理`container`。

###创建container

创建一个名为`dev`的`container`: `docker-machine create --driver virtualbox dev`

###查看本地的containers

```
➜  mydockerbuild  docker-machine ls
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM
default            virtualbox   Running   tcp://192.168.99.101:2376
dev                virtualbox   Running   tcp://192.168.99.100:2376
```

###查看container状态

```
➜  mydockerbuild  docker-machine active
dev
➜  mydockerbuild  docker-machine status dev
Running
```

###连接到container

```
➜  mydockerbuild  docker-machine ssh dev
                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/
 _                 _   ____     _            _
| |__   ___   ___ | |_|___ \ __| | ___   ___| | _____ _ __
| '_ \ / _ \ / _ \| __| __) / _` |/ _ \ / __| |/ / _ \ '__|
| |_) | (_) | (_) | |_ / __/ (_| | (_) | (__|   <  __/ |
|_.__/ \___/ \___/ \__|_____\__,_|\___/ \___|_|\_\___|_|
Boot2Docker version 1.8.2, build master : aba6192 - Thu Sep 10 20:58:17 UTC 2015
Docker version 1.8.2, build 0a8c2e3
er@dev:~$ uname -a
Linux dev 4.0.9-boot2docker #1 SMP Thu Sep 10 20:39:20 UTC 2015 x86_64 GNU/Linux
```


##Docker中的image是什么?

###docker run helloworld 运行一个image 

此时docker正在`run`一个名为`hello-world`的应用程序,它将会打印如下结果:

```
➜  sts  docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world

535020c3e8ad: Pull complete
af340544ed62: Pull complete
Digest: sha256:a68868bfe696c00866942e8f5ca39e3e31b79c1e50feaee4ce5e28df2f051d5c
Status: Downloaded newer image for hello-world:latest

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
```

此时的`hello-world`程序在docker中成为一个`image`, 它被docker放在`container`上面运行。


###docker images 查看本地的images

```
➜  mydockerbuild  docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
docker-whale        latest              1935900e3705        5 hours ago         274 MB
ubuntu              latest              91e54dfb1179        6 weeks ago         188.4 MB
hello-world         latest              af340544ed62        8 weeks ago         960 B
docker/whalesay     latest              fb434121fc77        4 months ago        247 MB
```



##总结

`images` & `containers`是Docker世界中最基本的概念。`image`即software, `container`即运行software用的操作系统。   
在Docker世界中，我们大部分时间都在和Docker中的`images`打交道。`docker`采用类似`git`的机制来管理和分享`images`, 当我们使用`docker`创建分享`images`时，如同使用`git`一样。    
`DockerHub`的存在，如同`github`对`git`的存在一样，让`docker images`分享变得非常容易。
