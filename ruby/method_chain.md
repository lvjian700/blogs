第一次接触[Chaining Method](https://en.wikipedia.org/wiki/Method_chaining)概念是在使用jQuery时，jQuery中的`Chaining Method`，让代码变得非常简洁。Ruby中的`Active Record`也是基于`Chaining Method`设计的。基于`Chaining Method`机制设计的API, 可以称之为`Chaining API`.

##什么是Chaining Method

###jQuery中

```
$("#person").slideDown('slow')
   .addClass('grouped')
   .css('margin-left', '11px');
```

如果不使用chaining:	

```
var p = $('#person');
p.slideDown('slow');
p.addClass('grouped');
p.css('margin-left', '11px');
```

###Active Record中
```
User.all.order(created_at: :desc)
```

如果不使用chain	

```
users = User.all
ordered_users = users.order(created_at: :desc)
```

##最简单的Chaining Method实现
每次方法调用都返回当前对象本身

```
class Person
  def name(value)
    @name = value
    self
  end

  def age(value)
    @age = value
    self
  end

  def introduce
    puts "Hello, my name is #{@name} and I am #{@age} years old."
  end
end

person = Person.new
person.name("Peter").age(21).introduce
# => Hello, my name is Peter and I am 21 years old.
```

##使用Chaining API处理数据

在Functional Programming世界中，数据处理一般需要遵循[data pipeline](http://martinfowler.com/articles/collection-pipeline/)的原则,即: 

* 数据从右向左流动(Functional Programming Way)
* 或者数据从左向右流动(OOP Way)

###从右向左流动

```
sum(even(plus(1, [1,2,3,4,5])))
# => 12
```

###从左向右流动

```
Processor.new([1,2,3,4,5]).plus(1).even().sum()
# => 6
```

###OOP中的Chaining API的设计准则

1. 使用数据构建`Processor`对象, `Processor`对象保存数据状态
2. 调用`Processor`对象中的方法改变数据状态, 并且每个方法都返回`Processor`本身
3. 最后一次调用返回处理后的结果, 此处不在返回`Processor`对象本身
4. 由于`Processor`中的每一次方法调用都会改变数据状态，所有不要重复使用`Processor`对象。`Processor`对象用完立即销毁

```
class DataProcessor
  def initialize(datas)
    @datas = datas
  end

  def plus(num)
    @datas.map! { |n| n + num }
    self
  end

  def even
    @datas.select! { |n| n.even? }
    self
  end

  def sum()
    @datas.reduce(:+)
  end
end

DataProcessor.new([1,2,3,4,5]).plus(1).even().sum()
#=> 12
```

##总结

[Chaining Method](https://en.wikipedia.org/wiki/Method_chaining)是一个非常优雅的API设计方式，采用Chaining Method方式设计API可以使代码变得非常简洁。在数据处理方面，Chaining Method Way可以让数据保持单项流动，在OOP中轻松实现Functional Programming中的Data Pipeline 思想。
