#Objective C手动内存管理

Objective C中没有像Java这样的运行时自动内存管理的技术。它采用"引用计数"(Reference Count)的方式进行内存管理。在iOS 5.0之前开发iOS应用需要对内存手动管理(Manual Retain-Release, 简称 MRR)。
从iOS 5.0开始，苹果将Mac上使用多时的自动内存管理技术Auto Reference Count(简称ARC)引入到iOS平台，包括最新的Swift语言也使用ARC的方式进行内存管理。

ARC是一种编译器期间生效的内存管理技术，即在编译器期间插入手动管理内存需要编写的代码[关于流行的GC方式，请参看《代码未来》的内存管理章节](http://www.cppblog.com/TianShiDeBaiGu/archive/2014/01/17/205450.html)。

ARC引入简化了大量内存管理操作，但是从理解ObjC内存管理方面讲，MRR更有助于理解内存管理。本文将探讨MRU的使用，以便更好的理解ObjC中的内存管理。

##MRR原理

NSObject中与内存管理操作相关的方法:

* 生成持有对象： alloc/new/copy/mutableCopy等
* 持有对象: retain
* 记录引用计数: retainCount
* 释放对象: release方法
* 废弃对象: dealloc

如何进行内存管理:

1. 在对象创建时，引用计数(retainCount)为1。
2. 如果对象被其他对象持有(retain)，retainCount＋1。
3. 在用完之后释放(release),retainCount-1。
4. 当retainCount为0时，自动调用dealloc方法释放对象。

基本使用:

	NSObject *obj = [[NSObject alloc] init];
    //使用对象obj...
    NSObject *ref = [obj retain];//引用计数+1
    NSLog(@"retainCount: %d", [obj retainCount]); //=> retainCount: 2
    //使用ref
    [ref release];
    NSLog(@"retainCount: %d", [obj retainCount]); //=> retainCount: 1
    [obj release];//使用完释放

##MRR原则

* 如果使用new, alloc, copy操作获取一个对象，需要手动释放(调用release/autorelease方法)
* 如果使用其他方法获取一个对象，假设其retainCount为1, 并且已经被标记为autorelease
* 谁持有，谁负责释放

###获取对象

    // new, alloc, copy操作获取一个对象，需要手动释放
    NSString *manualReleaseString = [[NSString alloc] initWithFormat:@"manual release"];
    // 使用...
    [manualReleaseString release];

    //使用其他方法获取一个对象, 不用手动释放
    NSString *autoReleaseString = [NSString stringWithFormat:@"autorelease"];
    // 使用，会自动释放

    //使用alloc的等价方法
    NSString *sameAutoReleaseString = [[[NSString alloc] initWithFormat:@"auto release string"] autorelease];
    // 使用，会自动释放

###创建对象

	@interface MyObject : NSObject
	- (instancetype)initWithOptions;
	
	+ (instancetype)objectWithOptions;
	@end
	
	/*
	    通过alloc构建对象
	 */
	@implementation MyObject
	- (instancetype)initWithOptions {
	    self = [super init];
	    if (self) {
	
	    }
	
	    return self;
	}
	
	/*
	不通过alloc/new/copy构造对象
	 */
	+ (instancetype) objectWithOptions {
	    return [[[MyObject alloc] init] autorelease];
	}
	
	@end

使用:

	MyObject *myObject = [[MyObject alloc] initWithOptions];
    [myObject release];

    MyObject *autoReleaseMyObject = [MyObject objectWithOptions];

###谁持有，谁负责释放


	@interface MyObject : NSObject {
	    NSMutableArray *_datasource;
	}
	- (instancetype)initWithOptions;
	
	+ (instancetype)objectWithOptions;
	@end
	
	/*
	    通过alloc构建对象
	 */
	@implementation MyObject
	- (instancetype)initWithOptions {
	    self = [super init];
	    if (self) {
	    	//持有NSMutable对象
	        _datasource = [[NSMutableArray alloc] initWithCapacity:12];
	    }
	
	    return self;
	}
	
	- (void)dealloc {
		// 必须在dealloc方法中手动释放
	    [_datasource release];
	    _datasource = nil;
	
	    [super dealloc];
	}


##NSArray/NSDictionary相关的操作

###NSArray中添加，获取对象	

	NSString *string = [[NSString alloc] initWithFormat:@"manual release string"];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:12];
    [mutableArray addObject:string];
    NSLog(@"string retainCount: %d", [string retainCount]); //=> retainCount = 2
    [string release];

    NSString *fromArrayString = [mutableArray objectAtIndex:0];
    NSLog(@"%@", fromArrayString);//=> manual release string
    [mutableArray release];// 会释放容器内所有对象
    
	//NSLog(@"%@", fromArrayString);  //访问已dealloc对象会crash


###NSDictionary中添加，获取对象
	
    NSString *allocString = [[NSString alloc] initWithFormat:@"manual release allocString"];
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithCapacity:12];
    [mutableDictionary setObject:allocString forKey:@"text"];
    NSLog(@"string retainCount: %d", [allocString retainCount]); // => 2
    [allocString release];

    NSString *stringFromDict = [mutableDictionary objectForKey:@"text"];
    NSLog(@"%@", stringFromDict);

    [mutableDictionary release];//释放容器内所有对象

	//NSLog(@"%@", stringFromDict); // crash

###AutoRelasePool自动回收对象

在内存管理时使用到autorelease方法，该方法标示当前对象会被自动回收。实质上这些对象都被放倒AutoReleasePool进行管理，当AutoReleasePool释放时，autorelease对象将被释放。

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *string = [[NSString alloc] initWithFormat:@"automatic released"];
    [string autorelease];
    [pool release];

##@property中的内存管理

@property中涉及内存管理的标示:

* retain
* assign, 用于标记int/float等C中原始的，非引用类型。
* copy	

```
	@interface ViewController : UIViewController
	@property (nonatomic, retain) UITextField *nameField;
	@property (nonatomic, assign) int pageNumber;
	@property (nonatomic, copy) NSString *inputName; //从UITextField中获取可变的text
	@end
```

关于，MRR中的retina,assign, ARC中的strong, weak。StackOverflow上有篇很好的解释:
<http://stackoverflow.com/questions/8927727/objective-c-arc-strong-vs-retain-and-weak-vs-assign>

##如何发现内存问题

1. 在XCode Navigators->Debug 中观察内存增长情况(ShortCut, Cmd + 6)
2. Cmd + i 开启instrument tools, 使用memory leaks工具查看内存情况。

##资料


* [Objective C中常见内存问题](http://qing.blog.sina.com.cn/1265251874/4b6a362233004gu8.html?sudaref=www.google.com.hk)
* [GC的三种方式，读RUBY之父写的《编程语言的过去、现在和未来》笔记](http://www.cppblog.com/TianShiDeBaiGu/archive/2014/01/17/205450.html)
 




