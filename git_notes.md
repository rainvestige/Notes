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
