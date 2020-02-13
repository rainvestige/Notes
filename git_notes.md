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
$ ssh git@github.com
```

#
# Git Chart
![git](/home/xinyu/Pictures/git_chart.png "Git")
