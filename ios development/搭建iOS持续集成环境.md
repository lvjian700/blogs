#搭建iOS持续集成环境

本文将讲解如何使用Vagrant, Jenkins, xcodebuild搭建iOS持续集成环境.

* Vagrant用于虚拟机管理, 本文使用Vagrant创建ubuntu虚拟机
* Jenkins为当前流行的持续集成服务器, 本文将Jenkins部署到ubuntu上
* xcodebuild为XCode的command line tools用于编译iOS项目

##Vagrant

Vagrant运行依赖VirtualBox, 需要在这里先下载安装最新的Virtualbox:  
<https://www.virtualbox.org/>	

###安装Vagrant	

有两种方式安装Vagrant:
1.下载安装包安装	
<https://www.vagrantup.com/downloads>	

2.使用gems安装		

	gem install vagrant 

选择一个你习惯的方式即可.

###安装Ubuntu	

Vagrant中安装虚拟机不再需要在ISO文件, 在下面地址找到合适的虚拟机便可:
<http://www.vagrantbox.es/>	

(Vagrant中的虚拟都是用配置文件进行管理, 建议在安装虚拟机前,先创建好工作目录.我的目录是_~/vmos/_.__本文之后的工作root目录即为这个目录__.	)

选择一个合适的你的虚拟机box, 执行如下指令进行安装:	

	mkdir -p ~/vmos/ubuntu_14/
	cd ~/vmos/ubuntu_14/
	vagrant add ubuntu_14 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
	vagrant init ubuntu_14	

此时在 ~/vmos/ubuntu_14/ 目录下会生成_Vagrantfile_文件. 该文件为ubuntu_14这台虚拟机的配置文件.	

	vagrant up	

此时将会在默认配置下运行虚拟机. 之后可以使用ssh连接上虚拟机:

	vagrant ssh		

在默认环境下, 主机是无法直接访问虚拟机. 之能做一些文件共享. 关于如何共享和Vagrant使用将不在本文讨论.

###配置虚拟机	

在配置之前需要先了解一些Vagrant常用指令:	

	vagrant up #自动虚拟机
	vagrant ssh #连接虚拟机
	vagrant halt #彻底关闭虚拟机
	vagrant reload #重新加载Vagrantfile配置	
	vagrant box add [name] [url] #添加一个新虚拟机
	vagrant init [name] #初始化虚拟机,生成Vagrant配置文件		

由于我们需要主机能够访问虚拟机中的web服务, 我们需要为虚拟机配置网络:	
在Vagrantfile中找到如下行:
	
	#config.vm.network "private_network", ip: "192.168.33.10"	

将其改为:	

	config.vm.network "private_network", ip: "192.168.33.10"	

此时,Vagrant创建了一个主机到虚拟机的私有网络, 主机可以通过192.168.33.10访问虚拟机.	
执行reload指令使配置生效:	

	vagrant reload	

在主机中使用ping指令检测一下网络环境:	

	ping 192.168.33.10	

配置好网络之后,我们开始搭建Jenkins持续集成服务器

##Jenkins

##创建iOS项目构建脚本

