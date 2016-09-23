最近做了一个Eclipse Plugin项目, 在各种文档摸爬滚打了近3个月, 走了不少弯路.本文将Google这间杂货铺中关于eclipse plugin开发最有效的资源这里出来, 制成"藏宝图", 希望你能在这里找到你需要的宝藏.		

本文内容涉及:		

* Eclipse核心架构OSGi
* Eclipse Plugin开发教程(推荐)
* 如何获取帮助文档
* 如何在Google/Bing/Baidu中搜索问题
* 如何获取实例代码 
* 如何进行UI Automation测试
* 如何使用maven搭建持续集成环境
* 如何发布plugin


##Eclipse Runtime 核心架构 OSGi

<http://www.osgi.org/Technology/WhatIsOSGi>  
至少先要知道:  
什么OSGi, 什么是Bundle, 在OSGi环境下jar包是如何组织的,这些是eclipse开发的前提.否则会被ClassLoader机制坑.	

##教程资源最全的地方

<http://www.vogella.com/tutorials/eclipse.html>  
最好的资源都在这里, 基本不需要去其他地方找.

##开发时如何获取文档	

####Eclipse for Plugin Deveopment -> Help Content.

* __Plug-in Development Environment(PDE) Overview__: PDE Overview必看
* __Platform Plug-in Developer Guide__: 开发文档, Sample Code优先在这里找.

####Eclipse for Plugin Deveopment -> Dynamic Help

开启动态帮助, 也是一个不错的选择

####如何在搜索引擎中获取帮助

如果使用eclipse + 问题, 搜索结果会被大量如何使用eclipse IDE的此条所淹没.	
搜索时推荐关键字: eclipse rcp + 你的问题,  eclipse pde + 你的问题.	


##SWT Sample
Eclipse UI 使用的是JFace + SWT, 在这个里可以找到几乎所有的UI Demo.	
<http://www.eclipse.org/swt/examples.php>	

##UIAutomation 测试方案

####SWTBot (推荐)

<http://eclipse.org/swtbot/>	
需要编写Java代码

####RCPTT ( 不推荐 )

* <https://www.eclipse.org/rcptt/>
* <https://www.eclipse.org/rcptt/documentation/userguide/getstarted/>	

可以录制脚本, 但是直行的时候不稳定. 如果使用它, 需要提前做好调研.

##自动化构建 － Maven Tycho plugin

* Tycho: <https://www.eclipse.org/tycho/documentation.php>
* Typcho Tutorials: <http://www.vogella.com/tutorials/EclipseTycho/article.html>
* Tycho FAQ(very useful): <http://wiki.eclipse.org/Tycho/FAQ>
* Demo: <https://github.com/jsievers/tycho-demo>


## CI环境	

如果需要将Test/Coverage report提交到Sonar, 参考这篇	

[Quality analysis on Eclipse plugins with Tycho, Sonar, Jacoco and SWTBot](http://mdwhatever.free.fr/index.php/2011/09/quality-analysis-on-eclipse-plugins-with-tycho-sonar-jacoco-and-swtbot/)

##如何搭建eclipse updatesite

将plugin build结果扔到一个目录， 然后将这个目录以HTTP的发布就OK. 使用python的SimpleHttpServer能够很好解决这个事情.

## Build时如何更新plugin的版本号?

tycho-package-plugin 可以配置版本策略, 该策略可以描述如何替换MANIFEST中的version号:	

	MANIFEST:
	Manifest-Version: 1.0
	Bundle-ManifestVersion: 2
	Bundle-Name: your plugin bundle name
	Bundle-SymbolicName: com.yourcompany.app.bundle
	Bundle-Version: 1.0.0.qualifier	

替换规则:  1.0.0.__qualifier__,  qualifier 部分被替换.	

	<plugin>
		<groupId>org.eclipse.tycho</groupId>
		<artifactId>tycho-packaging-plugin</artifactId>
		<version>${tycho.version}</version>
		<configuration>
			<format>yyyyMMddHHmm</format>
		</configuration>
	</plugin>	

打出来的plugin version是: 1.0.0.201503011210.  这里的version不会影响jar的version号.
