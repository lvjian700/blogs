在[Mircroservices API]( http://martinfowler.com/articles/microservices.html)设计中,为了让错误信息更具有描述性，我们采用[Problem+json](http://tools.ietf.org/html/draft-nottingham-http-problem-07)的方式输出错误。  

##在problem+json之前,我们这么返回错误

采用Http Status Codes + Empty Response来返回错误数据:    

```
HTTP/1.1 400 Bad request
Content-Type: application/json
Response Body:
```

##problem+json中这么定义错误输出

```
HTTP/1.1 404 Not found
Content-Type: application/problem+json
Response Body:
{
    type: 'http://www.restapitutorial.com/httpstatuscodes.html',
    title: 'User data not found',
    detail: 'The user JO not found',
    status: 404,
    instance: 'http://localhost/users/JO'
}
```

* `type`: 提供一个描述问题的连接(required)
* `title`: 对错误做一个简短的描述(required)
* `status`: HTTP status code(required)
* `detail`: 详细描述错误信息(optional)
* `instance`: 返回错误产生的URL, 绝对地址(optional)

采用`problem+json`格式我们可以让错误输出更具有描述性，可以让`API Consumer`更好进行错误处理

##problem+json中也可以附加更多有意义的信息

例如采用如下信息描述订单问题:   

```
HTTP/1.1 403 Forbidden
Content-Type: application/problem+json
Response Body:
{
    type: 'http://yourhost/docs/api/problems/out-of-credit',
    title: 'You do not have enough credit',
    detail: 'Your current balance is 30, but that costs 50.',
    instance: 'http://yourhost/users/lvjian/orders/1002222',
    balance: 30,
    users: [
        'http://yourhost/users/lvjian',
        'http://yourhost/users/saler']
}
```

##参考资料

* [Problem+Json Specification](http://tools.ietf.org/html/draft-nottingham-http-problem-07)
* [Error reporting for creating RESTful JSON APIs](http://phlyrestfully.readthedocs.org/en/latest/problems.html)

