#Build your own Docker image

`Docker`中使用`Dockerfile`来描述`image`中的软件。我们需要在`Dockerfile`中描述软件运行的环境或者需要执行的指令。本文将扩展`docker/whalesay`,构建第一个`Docker image`。

##从Dockerfile开始

1. 创建一个文件夹: `mydockerbuild`
2. 创建Dockerfile

Dockerfile:  
```
FROM docker/whalesay:latest

RUN apt-get -y update && apt-get install -y fortunes

CMD /usr/games/fortune -a | cowsay
```

其中`FROM`, `RUN`, `CMD`都是`Dockerfile`中的关键字。

* FROM: 描述当前`image`基于哪个`image`
* RUN: 
* CMD:

##使用Dockerfile构建image

执行如下命令，在当前目录查找`Dockerfile`并构建`docker-whale` image: 
```
docker build -t docker-whale .
```


