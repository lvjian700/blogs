#iOS开发中使用FMDB解决数据存储问题

##前言

近期一个项目中需要实现离线存储，在线同步的功能。调研了两种实现方案:

* __CoreData__: iOS 技术栈中提供的对象管理技术。对象关系，内存管理，undo/redo,本地存储等功能。
* __FMDB__(<https://github.com/ccgus/fmdb>)： 仅专注于Database层, 对iOS SDK中的SQLite接口做了封装。使用FMDB操作SQLite非常方便,在API方面跟跟JDBC非常类似。

这里先给一个FMDB的showcase:
    

    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbpath = [docsdir stringByAppendingPathComponent:@"dyobv.sqlite"];    
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbpath];  
    [db open];    
    
    FMResultSet *rs = [db executeQuery:@"select * from log_keepers"];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:32];
    while([rs next]) {
        DYLogKeeper *obj = [[DYLogKeeper alloc] init];	
    	obj.localId = [rs stringForColumn:@"local_id"];
    	// … 省略赋值操作
        
        [array addObject: obj];
    }
    [db close];    
        
从代码中看，FMDB更适合平时编程习惯。 FMDB有ARC，非ARC，使用方面回不有任何阻碍。

##使用说明    

FMDB技术使用已经有非常优秀的教程，这里提供两个传送门：    

1. 《在iOS开发中使用FMDB》: <http://blog.devtang.com/blog/2012/04/22/use-fmdb/>    
2. 官方文档: <https://github.com/ccgus/fmdb>    

##推荐工具    

__MesaSQLite__(<http://www.desertsandsoftware.com/wordpress/?page_id=17>)，这个工具是Mac OS X上的原生App，支持文件拖拽操作, 比FireFox Sql Manager插件好用很多。    

##如何调试

调试sqlite时需要在Simulator环境下进行。启动项目后，使用MesaSQLite打开Mac OS X上的sqlite文件。    
  
具体步骤如下:    

1. 创建数据库时将路径输出:    


        NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbpath = [docsdir stringByAppendingPathComponent:@"dyobv.sqlite"];  
        NSLog("--databasePath: %@", dbpath); //输出的地址就是dyobv.sqlite的路径    
    
    
2. 在Console中找到sqlite文件路径(路径是隐藏文件夹)，然后后在Terminal中使用open指令打开。


##实战中的问题

###创建数据库表    

1. 在MesaSQLite设计器中创建表结构，然后将生成的sql复制出来使用。这样可以避免手敲代码产生的错误。
2. 将sql保存成文件，然后放到xcode工程中。 这里我会在Supportting files创建一个sql分组，将所有sql文件放到这里。
3. 使用下面语句将sql语句读入到NSString中:        

 
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"log_keepers_table" ofType:@"sql"];
        NSError *error;
        NSString *sql = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];       
	
4. 调用 __[db executeupdate:sql]__ 建表

为什么要将sql放到文件中? 先看一段建表的sql:    

    CREATE TABLE "log_keepers" (
        "local_id" varchar(36) PRIMARY KEY NOT NULL  UNIQUE ,
        "logkeeper_id" varchar(36),
        "add_time" DATETIME NOT NULL ,
        "content" VARCHAR(256),
        "device_id" VARCHAR(36) NOT NULL ,
        "device_type" INTEGER NOT NULL ,
        "channel" INTEGER NOT NULL
    )    
    
将这段sql直接放到NSString中，代码将非常难阅读。将sql放到文件中，然后用带代码高亮的工具进行编辑，出了方便阅读，还可以解决xcode不支持sql语法高亮的问题。    

###如何判断表是否已经存在?

SQLite中没有 _if exists_ 语句, 需要使用如下代码判断:    

    FMDatabase *db = [[DYDB sharedDB] connect];//DYDB是我自己封装的工具类
    
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", @"log_keepers" ];
    NSLog(@"%@", existsSql);
    
    FMResultSet *rs = [db executeQuery:existsSql];
    
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];
        NSLog(@"The table count: %d", count);
        if (count == 1) {
        	NSLog(@"log_keepers table is existed.");
        	return;
        }
        
        NSLog(@"log_keepers is not existed.");
    }
    
    [rs close];

###什么时候创建表?    

建表操作放到AppDelegate中，在程序启动时先检测表是否存在，如果不存在则创建表结构：    

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
    //	RKLogConfigureByName("RestKit", RKLogLevelWarning);
    //  RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
        RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    	
    	DLog(@"initialize database... ");
    	[DYLogKeeper createSqliteTable];
    	[DYSyncItem createSqliteTable];
    	
    	return YES;
    }    
    
    
##本文中涉及的代码段

FMDB基本使用: <https://gist.github.com/lvjian700/6113564>    

     
       






      
        


