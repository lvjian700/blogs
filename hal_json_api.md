#Micro Service中的API设计 - HAL+Json API

HAL(Hypertext Application Language)是一个简单的API数据格式.它以xml和json为基础，让API变的可读性更高，并且具有discoverable的特性.当我们拿到HAL API返回的数据时，我们将会很容易根据当前数据查找与其相关的数据。在Micro Service API

HAL支持xml和json两种格式，本文将讨论HAL+json格式.


##HAL是什么样 ?

举个栗子, 我们设计一个获取user信息的api接口:    

###不出意外，我们会将API设计成这样:

####获取用户详情

```
GET - /users/lvjian700
Content-Type: application/json

{
    id: 'lvjian700',
    name: 'lvjian',
    email: 'useremail@email.com',
    twitter: '@lvjian700'
}
```


####获取用户列表    

```
GET - /users
Content-Type: application/json

{
    total: 10
    page: 2
    page_size: 2
    rows: [{
        id: 'lvjian700',
        name: 'lvjian'
    }, {
        id: 'meimei',
        name: 'meimei'
    }]
}
```


###为了让api resouce更具有关联性,我们使用HAL+json格式

####获取用户详情

```
GET - /users/lvjian700
Content-Type: application/hal+json

{
    _links: {
        self: {
            href: '/users/lvjian700'
        }
    }
    id: 'lvjian700'
    name: 'lvjian',
    email: 'useremail@email.com',
    twitter: '@lvjian700'
}
```

这里多了__\_links__属性，其中有一个__self.href__其中的连接指向当前user resouce.  

####获取用户列表

```
GET - /users
Content-Type: application/hal+json

{
    _links: {
        self: {
            href: '/users?page=2'
        },
        first: {
            href: '/users'
        },
        prev: {
            href: '/users?page=1'
        }
        next: {
            href: '/users?page=3'
        },
        last: {
            href: '/users?page=5'
        }
    },
    count: 2
    totoal: 10
    _embedded: { //用于描述依赖资源。users提供了当前我们想要的列表信息。
        users: [{
            _links: {
                self: {
                    href: '/users/lvjian700' //访问这个link我们可以获取用户详情
                }
            }
            id: 'lvjian700'
            name: 'lvjian',
        },{
            _links: {
                self: {
                    href: '/users/meimei'
                }
            }
            id: 'meimei'
            name: 'meimei',
        }]
    }
}
```

##为什么我们需要采用HAL这种格式描述api

回想一下Web Service的发展:

* 刚开始我们采用SOAP协议提供web service, action和data使用xml包装起来，采用HTTP POST发送请求。这种API非常笨重，已经不再是首选的Web Service技术.
* 之后REST-ful Web Service横空出世，将数据描述为resource(URI)，采用最基本HTTP动作(GET POST PUT DELETE)进行访问，大多数时候采用json格式进行数据交互，这种易读，轻便的方式几乎统治了互联网API的架构方式。
* 基于REST-ful Web Service发展出来的Micro Service, 又给架构方式提出了新的挑战。 

在REST-ful Web Service的世界里: 

* 我们使用resource(URI)描述API接口
* 我们使用Http verbs(GET, POST, PUT, DELETE)访问API
* 采用plain json作为数据交互格式

HAL的出现，主要弥补plain json在API交互中的不足.让plain json更具有描述性，更具有导航行.  
在Micro Service的世界里，我们将大的系统拆分成小微小的API, 在将API组合起来为系统提供服务。 

![Micro services](micro_services.png "Micro services")

 
(关于mirco service的可以在[《Microservices》](http://martinfowler.com/articles/microservices.html)中了解更多.)

在组合API时， plain json这种缺乏描述性的json格式缺陷险的非常明显。我们要为api编写文档，要为api之间的数据关系，交互方式编写文档.    

如果我们用HAL+json描述一个带location属性的user信息  

```
{
    _links: {
        self: {
            href: 'http://userservices_host/users/lvjian700'
        }
    }
    id: 'lvjian700'
    name: 'lvjian',
    email: 'useremail@email.com',
    twitter: '@lvjian700',
    _embedded: {
        location: {
            _links: {
                self: {
                    href: 'http://locationservices_host/locations/1'
                }
            },
            id: 1,
            state: 'shaanxi',
            city: 'xi\'an'
        }
    }
}
``` 

我们可以很清楚的知道user信息从哪来，location信息从哪里来. 很清楚的知道location embedded in user.

	

关于描述API model模型在[《Richardson Maturity Model》](http://martinfowler.com/articles/richardsonMaturityModel.html)中有更深入的讨论

##如何使用HAL+json描述常见API

###获取单条数据

```
{
    _links: {
        self: {
            href: 'http://userservices_host/users/lvjian700'
        }
    }
    id: 'lvjian700'
    name: 'lvjian',
    email: 'useremail@email.com',
    twitter: '@lvjian700'
}
``` 


###获取复杂数据

```
{
    _links: {
        self: {
            href: 'http://userservices_host/users/lvjian700'
        }
    }
    id: 'lvjian700'
    name: 'lvjian',
    email: 'useremail@email.com',
    twitter: '@lvjian700',
    _embedded: {
        location: {
            _links: {
                self: {
                    href: 'http://locationservices_host/locations/1'
                }
            }
            id: 1,
            state: 'shaanxi',
            city: 'xi\'an'
        },
        contacts: [{
            _links: {
                self: {
                    href: 'http://userservices_host/users/meimei'
                }
            },
            id: 'meimei',
            name: 'meimei
        }, {
            _links: {
                self: {
                    href: 'http://userservices_host/users/jay'
                }
            },
            id: 'jay',
            name: 'jay'
        }]
    }
}
```


###返回集合数据 

```
{
    _links: {
        self: {
            href: '/users?page=2'
        },
        first: {
            href: '/users'
        },
        prev: {
            href: '/users?page=1'
        }
        next: {
            href: '/users?page=3'
        },
        last: {
            href: '/users?page=5'
        }
    },
    count: 2
    totoal: 10
    _embedded: { //用于描述依赖资源。users提供了当前我们想要的列表信息。
        users: [{
            _links: {
                self: {
                    href: '/users/lvjian700' //访问这个link我们可以获取用户详情
                }
            }
            id: 'lvjian700'
            name: 'lvjian'
        },{
            _links: {
                self: {
                    href: '/users/meimei'
                }
            }
            id: 'meimei'
            name: 'meimei'
        }]
    }
}
```


##参考资料

* [Microservices](http://martinfowler.com/articles/microservices.html)
* [Richardson Maturity Model](http://martinfowler.com/articles/richardsonMaturityModel.html)
* [HAL Primer](http://phlyrestfully.readthedocs.org/en/latest/halprimer.html)
* [HAL Specification](http://stateless.co/hal_specification.html)
* [HAL format specification](http://tools.ietf.org/html/draft-kelly-json-hal)


