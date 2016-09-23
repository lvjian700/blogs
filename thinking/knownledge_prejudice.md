#知识的偏见 - 读暗时间思考

最近刚刚读了《暗时间》，这篇来自本书引发的思考：『知识的偏见』

在思考这个问题的时候，先用 `10s` 思考一下这个问题： 

『如何建一个网站卖化妆品？』    

对于这个问题没哟答案，如果你思考，把解决方案保留在你的脑海里。看完本片我们再回来思考这个问题。


##『如果你手里有把锤子，所有东西看上去都想钉子』  

再来看一个漫画: 


在真实世界里每人都会自己独特的经历，不同的经历会造成对一个问题产生不同的直觉，比如 Developer 和 Sales 基本不可能站在同一个视角思考问题。这个由经历不同产生 `偏见` 我们很好理解，由于成长经历不同，我们对事物的看法会不同。 

还有一种 `偏见` 可以归位 `知识偏见`。这类偏见由我们掌握的知识决定的。不同的知识给我们带来不同的解决问题的工具（锤子）。在程序员的世界中，这种偏见非常明显。   

先来看看我们掌握的锤子们：  

##编程语言

一下是不负责任的调侃：  

* 对于 Java 程序员来说，多数人会认为只有 Java 是最强大的语言，Java 可以解决编程中所见的所有问题，而且效率碾压其他语言（C++ 和 C Developer 笑了）。
* 对于 Ruby 程序员来说，Rails 是宇宙第一 Web 开发平台，Rails 应该统治 Web 世界（PHP 作为宇宙最好的编程语言估计会表示不服）。
* 对于 Javascript 程序员来说，Javascript 横跨 Front-End、Back-End、Mobile，掌握 Javascript 可以掌控三端。   

记得 6 年前刚参加工作的时候公司在使用 [GWT](http://www.gwtproject.org/overview.html) 编写前端应用。GWT 是 Google 推出的神奇的工具，它可以使用 Java 代替 Javascript，不但如此，在 GWT 中不用再担心浏览器兼容问题。Google 红极一时的 Google Wave 便是用 GWT 编写的。    

一切听起来都很美，当我真正的用它的时候，问题来了：  

* GWT 只用使用部分 Java 的库，比如 GWT 就不用了 `java.util.Date`
* 当我在 GWT 中用 jQuery 或者 Pushlet 这类 Javascript 库的时候我必须做一个 GWT 的 Wrapper
* GWT 会为每一个浏览器编译一份 Javascript，当时开发了一年的 SPA，编译一次 > 20mins
* 最可怕的是，GWT production 版本代码会被默认压缩混淆，一些在 production 莫名其妙的 bug 基本无法定位，debug 过程完全靠猜    

当然 GWT 也有它先进的地方： 

* 使用 Java 的包管理机制，解决了 Javascript 模块化问题
* 使用 Ant 构建项目，可以完全复用 Java 世界中的构建流程
* RPC 机制可以让无视前后端的差距，让开发 Web 应用如同写 GUI 一样。（比如 Java Swing）
* 使用 JUnit 做单元测试

现在看起来，当年 GWT 带来的优势，今天并没有那么吸引人。但是让 Java 程序员可以不用学 Javascript 也可以写 SPA 应用还是比较抢眼的特性。    
如果你同时掌握 Java 和 Javascript，如果强迫你用 Java 去写 Javascript 估计你会有什么感想？我是被虐了两年不像再回到用 Java 写前端的世界。	


##TDD

听听不同的声音: 

* [TDD并不是看上去的那么美](http://coolshell.cn/articles/3649.html)
* [Bob大叔和Jim Coplien对TDD的论战](http://coolshell.cn/articles/4891.html)
* [Richard Feynman, 挑战者号, 软件工程](http://coolshell.cn/articles/1654.html)

##OOP

听听不同的声音：    

* [如此理解面向对象编程](http://coolshell.cn/articles/8745.html)
* [面向对象编程的弊端是什么？](https://www.zhihu.com/question/20275578/answer/26577791)

如果你对面向对象还保持着`封装，继承，多态`，教条的遵循 `SOLID` 原则，可能仅对 OOP，可能还需要更多的思考。   

##Design Pattern  

四人帮的 Design Pattern 犹如圣经般存在于 OOP 的世界。估计每个采用 OOP 的都被它虐过。    

『Design Patter 是我们重构代码的依据，不是我们写代码的准则』    

有一个很搞笑的编程模式：`Design Pattern Driven Development`。


讲个故事:       

联合利华新换了一批自动香皂包装机以后,经常出现香皂盒子是空的情况,而 在装配线一头用人工检查因为效率问题不太可能而且不保险。这不,一个由自 动化、机械、机电一体化等专业博士组成的Solution小组来解决这个问题,没 多久他们在装配线的头上开发了全自动X光透射检查线,透射检查所有的装配 线尽头等待装箱单香皂盒,如果有空的就用机械臂取走。 

无独有偶,在中国一乡镇企业生产香皂也遇到了类似问题,老板吩咐线上小公务必想出对策解决之,小工拿了一个电风扇放在装配线的头上,对着最后的成 品吹,空盒子被吹走了,问题也解决了。



##『如果你想钉一颗钉子，所有东西看上去都像是锤子。』  

如果我们专注与问题，按照 `How，Why，Who did it？` 反复思考待解决的问题。可能会更容易的得到合适的解决方案。  

使用合适的语言解决合适的事情。  

使用 DSL 处理特定的领域 



##写在最后    

2009 我作为 Java 程序员从一个非计算机的专业转到了计算机领域。在 2012 年，我做了一个很有意思的回顾，自己平均每年都会学习一门新的语言或者新的技术领域：    

* 2009 精通CSS
* 2010 Groovy
* 2011 Ruby, node.js
* 2012 Objective C
* 2013 Shell， improve ruby
* 2014 Lisp ( SICP, Scheme )
* 2015 Swift，Clojure，Rails    

由于每个技术领域都能带来新的思维方法，这也让我不由自主的保持了`一年一门语言或者框架`的习惯。    

系统的学习CSS，让我懂得如何布局，如何使用CSS创建自己享用的 UI。做页面的时候也偏向于先用 HTML + CSS 构建原型，再完成实现。   

接触 Groovy 是由于 Grails 这个类 rails 的框架。Groovy 让我见识到了脚本语言的强大，之后使用 Groovy 作为胶水语言为项目设计了基于 Groovy 描述的工作流引擎。    

学习 Ruby 是因为 Rails。非常喜欢 Ruby 社区的气氛，非常活跃，时刻都能拥抱最新的技术。由于对 Ruby 的热情，让我买了第一台 Macbook， 同时也让我有幸参加了 ShanghaiOnRails 和 2012 RubyConfChina 聚会。也是由于 Ruby，让我有机会加入 Thoughtworks，有机会跟 Ruby 社区活跃的开源贡献者 FredWu 有共事的机会。  

学习 iOS 开发，让产品有机会跟上海的 SMG 广电集团有了一次合作，也让我步入了 iOS Developer 的行列。   

了解 Lisp 是从读 [《黑客与画家》](http://book.douban.com/subject/6021440/)开始，2014 在 Thoughtworks 和同事共同搞 [SICP](http://book.douban.com/subject/1148282/) Bookclub，这个活动让我刷新了对编程的认识，也让我了解到函数式思维的强大。    

2015 年初接触 Clojure，其中有一个 `Memorization` 的思想对函数运算进行缓存，这个思想激发了灵感。按照 `momorization` 思想对项目中的校验引擎做了优化，性能提升了近 100 倍。   

『软件开发没有银弹』    

在特定的场景使用合适的工具往往可以达到事半功倍的效果。对于编程方法论也适合，过于教条遵循某种编程模式也容易被束缚。  

听过不断的学习，不断的思考，我们

