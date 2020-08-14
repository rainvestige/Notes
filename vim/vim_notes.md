[toc]
# I. Vim Install From Source Code
> Ref: 
- [Linux 下源码编译安装vim]
- [源码编译安装vim]


> If we want to enable almost all features of vim, we must build and install 
> the vim from source code.

1. Download the source file from [vim repository]
    ```
    git clone https://github.com/vim/vim.git
    ```
2. Download the dependencies

3. Configure the vim

    You should change the python-config-dir according to your environment
    ```bash
    cd vim/
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp=yes \
                --enable-pythoninterp=yes \
                --with-python-config-dir=/usr/lib/python2.7/config \
                --enable-python3interp=yes \
                --with-python3-config-dir=/usr/lib/python3.6/config \
                --enable-perlinterp=yes \
                --enable-luainterp=yes \
                --enable-gui=gtk2 --enable-cscope \
                --prefix=/usr/local/vim8
    ```
    ```
    --with-features=huge：支持最大特性
    --enable-rubyinterp：打开对ruby编写的插件的支持
    --enable-pythoninterp：打开对python编写的插件的支持
    --enable-python3interp：打开对python3编写的插件的支持
    --enable-luainterp：打开对lua编写的插件的支持
    --enable-perlinterp：打开对perl编写的插件的支持
    --enable-multibyte：打开多字节支持，可以在Vim中输入中文
    --enable-cscope：打开对cscope的支持
    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ 指定python 路径
    --with-python-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/ 指定python3路径
    --prefix=/usr/local/vim：指定将要安装到的路径(自行创建)
    ```
4. Build and install the vim
    ```bash
    make && sudo make install
    ```

# II. Configure .vimrc file
> Ref: 
- syntax highlight and shortcuts setting [.vimrc]
- plugin setting [my .vimrc file]


# III. Plugins Install
1. Download plugin manager

    Both [vim-plug] and [vundle] is ok.

    When you install the vim-plug, you may meet the connection refused problem.
    To solve the problem, change the `/etc/hosts`, add the pair
    (ip_address hostname)

2. Configure your .vimrc file in __$HOME__ directory to download plugins.

3. Plugin install

4. Configure your plugin setting in your .vimrc file



# IV. Usage

## A. vim user doc
> Ref:
- [user_doc]

| Description      | Command(mode)         |
|------------------|-----------------------|
| help             | h [name]              |
| Custom workspace | :mksession [filename] |
| sudo in vim      | :w !sudo tee %        |

## B. markdown-preview.nvim examples ( _Date: 2020.08.08 Saturday_ )
> Markdown-preview.nvim is the vim plugins i used for enable markdown vim 
> support

The picture below show some special usages of this markdown plugin.
![markdown-preview.nvim custom examples]

@startuml
Bob -> Alice : hello
@enduml

```plantuml
Alice -> Bob : hello
```

katex $\sqrt{x+1} + x^2$


# V. Problems

## A. Problems when configure plugins
1. UltiSnips

   [Slove UltiSnips and YouCompleteMe \<tab> mapping collision]




# syntax highlight customize
> I want to highlight the content surrounded by squared brackets.

The `mkdp highlight css` only change the rendered markdown pages shown in the
browser, they will not change the code highlight syntax for markdown edited by
`vim`.

The `vim` colorscheme will defines the colors shown in  your code block.

change the `syntax/markdown.vim`
1. Define syntax region
   ![define syntax region of group name markdownParentheses]
2. Highlight link the defined group\
   ![highlight link the defined ]\
   some help doc for highlight link
   ![vim help for highlight link]
3. Solve some collision caused by order of the code(the later will override the former)
   ![change position of the added code ]






[Linux 下源码编译安装vim]: https://www.jianshu.com/p/48749100614d
[源码编译安装vim]: https://segmentfault.com/a/1190000017785173
[vim repository]: https://github.com/vim/vim "vim"
[.vimrc]: https://github.com/VundleVim/Vundle.vim
[my .vimrc file]: https://github.com/rainvestige/Notes/blob/master/vim/.vimrc
[user_doc]: http://vimcdoc.sourceforge.net/doc/usr_toc.html#usr_toc.txt
[Slove UltiSnips and YouCompleteMe \<tab> mapping collision]: https://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
[vim-plug]: https://github.com/junegunn/vim-plug
[vundle]: https://github.com/VundleVim/Vundle.vim
[markdown-preview.nvim custom examples]: https://raw.githubusercontent.com/rainvestige/PicGo/master/20200808105618.png
[mkdp highlight css]: https://raw.githubusercontent.com/rainvestige/PicGo/master/20200808112828.png
[change markdown syntax color]: https://raw.githubusercontent.com/rainvestige/PicGo/master/20200808205221.png
[define syntax region of group name markdownParentheses]: https://raw.githubusercontent.com/rainvestige/PicGo/master/20200809102924.png
[highlight link the defined ]: https://raw.githubusercontent.com/rainvestige/PicGo/master/20200809103143.png
[vim help for highlight link]: https://raw.githubusercontent.com/rainvestige/PicGo/master/20200809162428.png
[change position of the added code ]: https://raw.githubusercontent.com/rainvestige/PicGo/master/20200809172821.png
