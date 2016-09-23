#Find and run the whalesay image from Docker hub

[Docker Hub](https://hub.docker.com/)犹如Github一样，存放着丰富的`images`. 本文讲介绍如何在`Docker Hub`上查找并且运行[whalesay image](https://hub.docker.com/r/docker/whalesay/)


##查找whalesay image

1. 打开 <https://hub.docker.com/>
2. 查找`whalesay`
3. 找到`docker/whalesay`这个image
4. 打开image首页，可以看到image的详细信息

##让whalesay 跑起来

1. 启动container: `eval "$(docker-machine env dev)"`  
2. 运行image: `docker run docker/whale cowsay bobo`    

此时将会

```
➜  mydockerbuild  docker run docker/whalesay cowsay bo
 ____
< bobo >
 ----
    \
     \
      \
                    ##        .
              ## ## ##       ==
           ## ## ## ##      ===
       /""""""""""""""""___/ ===
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
       \______ o          __/
        \    \        __/
          \____\______/
```

尝试其它`command`,你将会发现更有趣的事情:   

```
docker run docker/whalesay cowsay hello, bobo
```

##发生了什么

当执行`docker run docker/whale cowsay boboo`时: 

1. docker检查本地是否有`docker/whale`
2. 如果没有`docker/whale`, 则从Docker Hub上下载最新的image
3. 运行`docker/whale`,并且调用image中的`cowsay`程序，并且传入`bobo`参数

此时查看本地`images`, 将多了一个`docker/whale`: 

```
➜  mydockerbuild  docker images
REPOSITORY               TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
docker/whalesay          latest              fb434121fc77        4 months ago        247 MB
ubuntu                   latest              91e54dfb1179        6 weeks ago         188.4 MB
hello-world              latest              af340544ed62        8 weeks ago         960 B
```

##参考

* Find & run the whalesay image: <http://docs.docker.com/mac/step_three/>
* Docker Hub Home page: <https://hub.docker.com/>
* docker whalesay repo: <https://hub.docker.com/r/docker/whalesay/>

