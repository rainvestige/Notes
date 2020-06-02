# Vim Install From Source Code
> add new features from src code install
## Ref: 
1. [Linux 下源码编译安装vim](https://www.jianshu.com/p/48749100614d)
2. [源码编译安装vim](https://segmentfault.com/a/1190000017785173)
#

1. Download the source file from [vim repository](https://github.com/vim/vim "vim")
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
#
# Configure .vimrc file
## REF: 
1. syntax highlight and shortcuts setting 
   [.vimrc](https://github.com/VundleVim/Vundle.vim)

2. plugin setting 
   [my .vimrc file](https://github.com/rainvestige/Notes/blob/master/vim/.vimrc)

# Plugins Install

1. Download plugin manager

    Both [vim-plug](https://github.com/junegunn/vim-plug) and 
    [vundle](https://github.com/VundleVim/Vundle.vim) is ok.

    When you install the vim-plug, you may meet the connection refused problem.
    To solve the problem, change the `/etc/hosts`, add the pair
    (ip_address hostname)

2. Configure your .vimrc file in __$HOME__ directory to download plugins.

3. Plugin install

4. Configure your plugin setting in your .vimrc file

#
# vim user doc
## REF: 
1. [user_doc](http://vimcdoc.sourceforge.net/doc/usr_toc.html#usr_toc.txt)


# Configure Plugins
1. UltiSnips

    [Slove UltiSnips and YouCompleteMe \<tab> mapping collision](
    https://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme)


# Custom workspace
mksession [filename]
