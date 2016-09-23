#UI Automation Test using Zombie.js

[Zombie.js][zombie] 是一个[node.js][node]环境下，非常小巧高效率的Web UI Automation Test库.本文将介绍如何使用[Zombie.js][zombie]对Web UI进行自动化测试.    

本文使用到的环境:   

* [node.js][node] + [coffeescript][coffee]
* [mocha][mocha]
* [gulp.js][gulp]
* [express.js][express]    

##快速预览Zombie.js测试

```
const Browser = require('zombie');
Browser.localhost('example.com', 3000);
describe('User visits signup page', function() {

  const browser = new Browser();

  before(function(done) {
    browser.visit('/signup', done);
  });

  describe('submits form', function() {

    before(function(done) {
      browser
        .fill('email',    'zombie@underworld.dead')
        .fill('password', 'eat-the-living')
        .pressButton('Sign Me Up!', done);
    });

    it('should be successful', function() {
      browser.assert.success();
    });

    it('should see welcome page', function() {
      browser.assert.text('title', 'Welcome To Brains Depot');
    });
  });
});
```

##Zombie.js适用场景

###好的方面

[Zombie.js][zombie]与传统的Selenium和PhandomJS不同，它不会启动真正的浏览器，使得测试运行效率媲美单元测试。 Zombile.js默认采用[mocha][mocha]风格编写测试，无需再为WebDriver做额外的配置,如果你熟悉[mocha][mocha], [Zombie.js][zombie]将是开箱即用的库. 

###Features

* 模拟浏览器行为
* Assertions, 可以采用jQuery的Selector对dom进行assert
* Cookies
* Ajax & WebSocket

###限制

由于[Zombie.js][zombie]没有真正启动传统的WebDriver, 因此过于复杂的场景将会无法测试. 例如，如何对高德地图经测试，我还没有找到好的方法.    


##安装Zombie.js

```
npm install -g mocha
npm install zombie --save-dev
```

由于本文使用[coffeescript][coffee]代替javascript, 还需要安装[coffeescript][coffee]环境

```
npm install -g coffee-script
```

##编写第一个测试

```
Brower = require 'zombie'

Brower.localhost('yourdomain.com', 5000)

describe 'User visits login page', () ->
  browser = new Brower()
  before (done) ->
    browser.visit '/login', done

  describe 'submits login form', () ->
    before (done) ->
      browser
      .fill 'username', 'xxxx@mail.com'
      .fill 'password', 'password'
      .pressButton('登录', done)

    it 'should be successful', () ->
      browser.assert.success()

    it 'should visit admin page', () ->
      browser.assert.url /^http:\/\/yourdomain\.com\/users\/\d\/admin/

    it 'should see profile button with email', () ->
      browser.assert.link('#profile-button', 'xxxx@mail.com', '#')
```

运行测试:   

1. 开启你的web server
2. 运行测试

```
mocha --harmony --compilers coffee:coffee-script/register login_spec.coffee
```

由于[Zombie.js][zombie]使用到了[ECMA 6][js6],需要使用 __--harmony__ 参数开启 [node.js][node] 对[ECMA 6][js6]语法支持.


##使用Gulp.js构建Build Pipeline

通常我们会讲自动化测试加入到build pipeline中. 这里将介绍将 [Express.js][express] + [Zombie.js][zombie] + [gulp.js][gulp]的配置方法.

###Build pipeline策略

1. checkstyle, 检查代码格式
2. 运行unit test
3. compile coffeescript -> javascript 
4. 启动server
5. 运行automation test
6. 出错或者结束测试，停止server

由于gulp-develop-server无法用[coffeescript][coffee]启动server,所以需要添加compile步骤.    

###express.js项目结构组织

```
├── acceptence-test // automation test代码
│   ├── admin_spec.coffee
│   └── login_spec.coffee
├── app //后台app代码 coffeescript
├── bin
├── config
├── dist //coffeescript编译后的js代码
├── gulpfile.coffee
├── gulpfile.js
├── node_modules
├── package.json
├── public
├── spec // unit test代码
│   ├── activities_spec.coffee
│   ├── auth_spec.coffee
│   └── projects_spec.coffee
└── views
```



###安装依赖

```
npm install -g gulp
npm install gulp-mocha gulp-coffee gulp-coffeelint gulp-sync gulp-task-listing gulp-develop-server harmonize --save-dev
```

* harmonize: 使gulp支持[ECMA 6][js6]
* gulp-develop-server: 用于启动[node.js][node] connect based Web Server
* gulp-sync: 用于同步运行tasks
* gulp-task-listing: 为[gulp.js][gulp]添加help支持， 可以列出gulpfile中的所有tasks.

###配置gulpfile

```
require("harmonize")()
gulp = require 'gulp'
gulpsync = require('gulp-sync')(gulp)
server = require 'gulp-develop-server'

coffeelint = require 'gulp-coffeelint'
mocha = require 'gulp-mocha'
karma = require 'gulp-karma'
coffee = require 'gulp-coffee'
task_listing = require('gulp-task-listing')

gulp.task 'help', task_listing.withFilters null, 'sync'

gulp.task 'coffee:lint', ->
  gulp.src(['app/**/*.coffee', './*.coffee'])
    .pipe(coffeelint('config/coffeelint.json'))
    .pipe(coffeelint.reporter())
    .pipe(coffeelint.reporter('fail'))

gulp.task 'coffee:compile', ['coffee:lint'], ->
  gulp.src ['app.coffee', './app/**/*.coffee']
    .pipe coffee()
    .pipe gulp.dest('./dist')

gulp.task 'test:unit', ['coffee:lint'], ->
  gulp.src('spec/**/*.coffee')
    .pipe(mocha(reporter: 'spec'))


gulp.task 'test:ui', ['coffee:compile'],  ->
  server.listen path: './dist/app.js'
  gulp.src('acceptence-test/**/*.coffee')
    .pipe(mocha(reporter: 'spec'))
    .on 'error', () -> server.kill()
    .on 'end', () -> server.kill()

gulp.task 'test', gulpsync.sync(['test:unit', 'test:ui']), ->

gulp.task 'clean', ->
  console.log 'clean task...'

gulp.task 'default', ['clean'], ->
  gulp.start 'test'

```

###运行测试

```
gulp test:ui
```

###运行结果

```
[11:03:21] Starting 'coffee:lint'...
[11:03:22] Finished 'coffee:lint' after 184 ms
[11:03:22] Starting 'coffee:compile'...
[11:03:22] Finished 'coffee:compile' after 114 ms
[11:03:22] Starting 'test:ui'...
server listening on 5000
[11:03:22] Development server listening. (PID:6427)

  User visit admin projects page
    and has login
      when click profile button
        ✓ should see dropdown menu
        ✓ should see project admin item
        ✓ should see logout item
        when click project admin link
          ✓ should visit to admin page
        when click logout link
          ✓ should logout
          ✓ should redirect to login page

  User visits login page
    submits login form
      ✓ should be successful
      ✓ should visit admin page
      ✓ should see profile button with email


  9 passing (6s)

[11:03:28] Finished 'test:ui' after 6.08 s
[11:03:28] Development server was stopped. (PID:6427)
```

由于已经将test:ui加入到default task中. 直接运行 ```gulp``` 便可运行所有测试.    

##参考资料

* [使用coffeescript编写gulp task.](http://www.jianshu.com/p/b77e1a55b722)
* [使用coffeescript写mocha测试](http://code.tutsplus.com/tutorials/better-coffeescript-testing-with-mocha--net-24696 "Better coffeescript testing with mochat")
* [Zombie.js and gulp.js](http://www.iainjmitchell.com/blog/full-stack-testing/)



[node]: https://nodejs.org/ "nodejs.org"
[coffee]: http://coffeescript.org/ "coffee script"
[gulp]: http://gulpjs.com/ "gulp.js"
[mocha]: http://mochajs.org/ "mocha BDD for javascript"
[express]: http://expressjs.com/ "express.js"
[js6]: http://es6.ruanyifeng.com/ "ECMA 6 入门"
[zombie]: http://zombie.js.org/ "Zombie.js"
