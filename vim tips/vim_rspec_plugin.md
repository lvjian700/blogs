自从转到 Ruby，Vim 已成为平时主要的开发工具。Vim 配合 [iTerm 2](https://www.iterm2.com/) 能很好的满足平时的开发需求。但是在运行 RSpec 的时候总是需要切换到 iTerm，尤其是在运行单个测试时，总是感觉不方便。	

本文介绍插件 [vim-rspec](https://github.com/thoughtbot/vim-rspec) 插件，它可以直接从 Vim 中直接运行 RSpec：  

![vim-rspec.gif](http://upload-images.jianshu.io/upload_images/14174-4f72f60571f3ae12.gif?imageMogr2/auto-orient/strip)

##安装

`vim-rspec` 需要使用 [vundle]()：   

```
Plugin 'thoughtbot/vim-rspec'
```

##配置和使用

将如下配置添加到 `.vimrc` 中:   

```
" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Link to current terminal app
let g:rspec_runner = "os_x_iterm"
```

在我的 `Vim` 中，`<Leader>` 键直接使用默认的 `/`。  

上述配置等同：    

* `/t`，运行当前测试
* `/s`，运行当前的 `it`
* `/l`，运行上一次测试
* `/a`，运行所有测试


##写在最后  

Vim 是一个非常强大的工具，它可以让 Developer 双手保持的键盘上，熟练的使用 Vim 可以让我们保持专注，达到眼到手到的境界。对于如何学习 Vim，唯有大量的使用才能提升 Vim 的能力。 经过 10000 小时的练习后，Vim 会是 Developer 手上的瑞士军刀。
