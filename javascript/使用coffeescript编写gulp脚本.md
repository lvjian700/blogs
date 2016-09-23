[gulp.js][gulp]是javascript中非常优秀的构建工具, [coffee-script][coffeescript]是众多js代替方案中非常优秀的语言.本文将讲述如何使用coffeescript编写gulp构建脚本.

安装依赖	

	npm install gulp -g
	npm install gulp --save-dev
	npm install coffee-script --save-dev
	

由于gulp不能直接运行coffeescript, 需要修改gulpfile.js, 在gulfile.js中显示加载gulpfile.coffee:	

	require('coffee-script/register');
	require('./gulpfile.coffee');
	
在gulpfile.js同级目录下创建 gulpfile.coffee, 并且将原有的gulpfile.js中的task转换成coffee-script:

	gulp = require('gulp')
	
	gulp.task 'clean', ->
	  console.log 'clean task...'
	
	gulp.task 'default', ['clean'], ->
	  console.log 'run default task'

运行gulp,如果成功,可以看到如下输出:	

	[20:07:15] Starting 'clean'...
	clean task...
	[20:07:15] Finished 'clean' after 143 μs
	[20:07:15] Starting 'default'...
	run default task
	[20:07:15] Finished 'default' after 51 μs

[gulp]: http://gulpjs.com/
[coffeescript]: http://coffeescript.org/