# Install and Configure
user configure file ~/.gitconfig




# Generating a new SSH key and adding it to the ssh-agent
## ENV: Linux + ssh + git
This part is aim to associate our local repositories to remote github

### 1.Generating a new SSH key
```bash  
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
Generating public/private rsa key pair.
Enter a file in which to save the key (/home/you/.ssh/id_rsa): [Press enter]
Enter passphrase (empty for no passphrase): [Type a passphrase]
Enter same passphrase again: [Type passphrase again]
```  

### 2.Adding your SSH key to the ssh-agent

1.start the ssh-agent in the background
```bash
$eval "$(ssh-agent -s)"
Agent pid 59566
```

2.Add your SSH private key to the ssh-agent. If you created your key with a different name, or if you are adding an existing key that has a different name, replace id_rsa in the command with the name of your private key file.
```bash
$ssh-add ~/.ssh/id_rsa
```

### 3.Adding a new SSH key to your GitHub account

This part should be done in the github setting 

### 4.Check 
```bash
ssh git@github.com
ssh: connect to host github.com port 22: Connection timed out
```

To solve the port 22 timed out problem, edit the file at ~/.ssh/config, add the
content below:
```
Host github.com
User xinyuloveslife@163.com
Hostname ssh.github.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa
Port 443
```


# Git Patch

## Generate Patch File
1. 某次提交(包含本次)之后的`n`次提交打包成一个`patch`
    ```bash
    # commit sha1 id 就是 git log 显示的每次提交都会生成的一串非常长的字符串
    git format-patch [commit sha1 id] -n

    # e.g.
    git format-patch c5deb6f37 -1
    git format-patch c5deb6f37 -2
    ```

2. 某两次提交之间所有内容打包成一个`patch`
    ```bash
    git format-patch [commit sha1 id]..[commit sha1 id]

    # e.g.
    git format-patch c892ae56d..c5deb6f37
    ```

## Apply Patch
1. check the patch 检查补丁是否能正常打入
    ```bash
    git apply --check [path/to/xxx.patch]
    ```

2. apply patch
    ```bash
    git apply [path/to/xxx.patch]

    # or
    git am [patch/to/xxx.patch]
    ```


## Problems

### A. gnutils_handshake failed: The TLS connection was non-properly terminated
> - Reference
> - [gnutls_handshake failed]

#### 1) Problem Description
我是在运行一个安装脚本时遇到这个问题的, 脚本使用`git clone`克隆远端gitlab下
的一个库, 结果显示连接不上.
![git TLS connection terminated problem 1]\
下面这副图是用浏览器直接打开gitlab官网的结果.
![git TLS connection terminated problem 2]

#### 2) Solutions

1. 安装一些必要的环境和依赖
    ```bash
    sudo apt-get install build-essential fakeroot dpkg-dev
    ```

2. 获取git源文件
    ```bash
    mkdir ~/git-rectify
    cd ~/git-rectify
    apt-get source git
    ```

3. 安装git依赖
    ```bash
    sudo apt-get build-dep git
    sudo apt-get install libcurl4-openssl-dev
    ```

4. 修改文件
    ```bash
    cd git-2.17.1/
    vim ./debian/control    # 把libcurl4-gnutls-dev修改为libcurl4-openssl-dev
    vim ./debian/rules      # 把TEST=test整行删除
    ```

5. 编译和构建安装包
    ```bash
    sudo dpkg-buildpackage -rfakeroot -b
    ```
    这里我遇到了一个error, 不过不用管, 可以接着运行下一句.

6. 安装编译好的安装包
    ```bash
    cd ..
    sudo dpkg -i git_2.17.1-1ubuntu0.7_amd64.deb  # Note: `0.7`这里可能会不同
    ```


    









[gnutls_handshake failed]: https://zhuanlan.zhihu.com/p/53961303
[git TLS connection terminated problem 1]: https://raw.githubusercontent.com/rainvestige/PicGo/master/20200804180047.png
[git TLS connection terminated problem 2]: https://raw.githubusercontent.com/rainvestige/PicGo/master/20200804180129.png
