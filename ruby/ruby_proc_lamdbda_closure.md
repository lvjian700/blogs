Ruby中的 Proc 和 Lambda 有些类似 high-order function。Proc 和 Lambda 的出现让 Ruby 具有 functional programming 的一些特性。 本文将介绍 Proc，Lambda 的基本使用。

Proc 和 Lambda 是两种创建 block 的方式。

下面是使用 block 的场景:  

```
[1, 2, 3].each { |n| puts n }
```

`each` 方法接受了一个 block. 当然还有一种使用 `do ... end` 的 block 形式:   

```
[1, 2, 3].each do |n|
    puts n
end
```

##使用 yield 调用 block

```
def run_yield
  yield if block_given?
end

run_yield do
  puts 'running yield'
end
#do nothing
run_yield
```

##使用 block.call 调用 Proc

```
#yield block variable lifecycle
class Array
  def random_each_yield
    shuffle.each do |el|
      yield el
    end
  end

  def random_each_block(&block)
    shuffle.each do |el|
      block.call el
    end
  end
end

puts 'random each yield'
[1,2,3,4,5].random_each_yield do |el|
  puts el
end

puts 'random each block'
[1,2,3,4,5].random_each_block do |el|
  puts el
end
```

##将 Proc 作为参数（high-order function）    

```
ef run_procs(p1, p2)
  p1.call
  p2.call
end
proc_one = proc { puts 'run proc one' }
proc_two = proc { puts 'run proc two' }

run_procs proc_one, proc_two
```

##调用 Proc 的方式

```
num_proc = proc { |num| puts "The number is #{num} " }
num_proc.call 10 # => The number is 10
num_proc.(20) # => The number is 20
num_proc[30] # => The number is 30
num_proc === 40 # => The number is 40
```

##在 case ... when 中使用 Proc

```
even = proc { |num| num.even? }
odd = proc { |num| num.odd? }

0.upto(10) do | num |
  case num
  when even
    puts "#{num} is even" # => 0, 2,4,6,8,10
  when odd
    puts "#{num} is odd" # => 1, 3, 5, 7, 9
  else 
    puts "Oops!"
  end
end
```

## Lambda 和 Proc 区别之一 return

```
#proc and lambda
def run_a_proc(p)
  puts 'start...'
  p.call
  puts 'end.'
end

#the lambda will be ignore
def run_couple
  run_a_proc proc { puts 'I am a proc'; return }
  run_a_proc lambda { puts 'I am a lambda'; return }
end

run_couple
```

lambda 将会被中断掉，输出：

```
start...
I am a proc
```

将 lambda 和 proc 位置互调

```
#the end will be ignore
def run_couple
  run_a_proc lambda { puts 'I am a lambda'; return }
  run_a_proc proc { puts 'I am a proc'; return }
end
```
输出:

```
start...
I am a lambda
end.
start...
I am a proc
```

##Lambda 和 Proc区别之二，参数约束不同 

###Lambda 强制约束参数

```
#lambda must be passed matched parameters
hello_proc = proc do |a, b|
  puts 'hello proc'
end
#hello_lambda.call # occure exception
hello_lambda.call 1, 2
```

###Proc 不约束参数，默认为nil

```
hello_lambda = lambda do |a, b|
  puts 'hello lambda'
end

hello_proc.call
```

##Ruby中的Closure保持变量的引用

```
puts 'ruby closure hold the variable reference'
def run_name_proc(p)
  p.call
end

name = 'Lv'
print_a_name = proc { puts name }
name = 'lvjian'
#it will output lvjian
run_name_proc print_a_name
```

##使用 lambda 和 closure 实现 high-order function 特性

（high-order function 特性之一：使用 function 创建 function）

```
#return a lambda, like high-order function
puts 'high-order lambda'
def multiple_gen(m)
  lambda do |n|
    n * m
  end
end

doubler = multiple_gen 2
tripler = multiple_gen 3

puts doubler[10] # => 20
puts tripler[10] # => 30
```

