# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# proxy
#export http_proxy="http://127.0.0.1:12333"
#export https_proxy="http://127.0.0.1:12333"


# set cuda path
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda:$CUDA_TOOLKIT_ROOT_DIR
#export CUDNN_PATH="/usr/local/cuda/lib64/libcudnn.so.6"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/xy/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/xy/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/xy/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/xy/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# torch bin directory
. /home/xy/Programs/torch/install/bin/torch-activate

# set matlab path
export PATH=/usr/local/MATLAB/R2018a/bin:$PATH
alias mrun="matlab -nodesktop -nosplash -r"
################################################################################
# set vim path
export PATH=$PATH:/usr/local/vim8/bin
# set athame bash path
export PATH=$PATH:/home/xy/local/bin/
# set default bash
#bash_xy
# vim editor in many contexts
export EDITOR=/usr/local/vim8/bin/vim

################################################################################

# Map Capslock to Escape
#xmodmap -e 'clear Lock' -e 'keycode 0x42=Escape'
#setxkbmap -option caps:escape

# set texlive bin path
export PATH=$PATH:/usr/local/texlive/2019/bin/x86_64-linux


# shut up the bell
#setterm -blength 0
xset -b



# tmux setting
export TERM=xterm-256color

################################################################################
# set Application path
export PATH=$PATH:/home/xy/Applications:/usr/local/srslte/bin/:/opt/ghc/bin
# c/c++ include search dir
#export C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/local/include/
#export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/include/
#export C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/local/srslte/include/
#export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/srslte/include/
# c/c++ library search dir
#export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/srslte/lib/
################################################################################
# python search dir
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3/dist-packages
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages
################################################################################


# Install Ruby Gems to ~/usr/gems
export GEM_HOME=$HOME/usr/gems
export PATH=$PATH:$HOME/usr/gems/bin
# Go path
export GOPATH=$HOME/Application/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

################################################################################
# Alias
# how2 alias
alias how2="HTTPS_PROXY='127.0.0.1:8888' HTTP_PROXY='127.0.0.1:8888' how2"
# sudo alias
alias psudo='sudo env PATH=$PATH'
# todo.sh alias
alias todo="todo.sh"
################################################################################
# custom env variables
export remote1="public@10.12.17.88"
export remote2="xxy@10.81.204.9"


#######################
## User Variables (Edit These!)
#######################
##username="myusername"
##password="mypassword"
#proxy="10.12.17.109:8888"
#
#######################
## Environement Variables
## (npm does use these variables, and they are vital to lots of applications)
#######################
#export HTTPS_PROXY="http://$proxy"
#export HTTP_PROXY="http://$proxy"
#export http_proxy="http://$proxy"
#export https_proxy="http://$proxy"
#export all_proxy="http://$proxy"
#export ftp_proxy="http://$proxy"
#export dns_proxy="http://$proxy"
#export rsync_proxy="http://$proxy"
#export no_proxy="127.0.0.10/8, localhost, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16"
#
#######################
## npm Settings
#######################
#npm config set registry http://registry.npmjs.org/
#npm config set proxy "http://$proxy"
#npm config set https-proxy "http://$proxy"
#npm config set strict-ssl false
#echo "registry=http://registry.npmjs.org/" > ~/.npmrc
#echo "proxy=http://$proxy" >> ~/.npmrc
#echo "strict-ssl=false" >> ~/.npmrc
#echo "http-proxy=http://$proxy" >> ~/.npmrc
#echo "http_proxy=http://$proxy" >> ~/.npmrc
#echo "https_proxy=http://$proxy" >> ~/.npmrc
#echo "https-proxy=http://$proxy" >> ~/.npmrc
#
#######################
## WGET SETTINGS
## (Bonus Settings! Not required for npm to work, but needed for lots of other programs)
#######################
#echo "https_proxy = http://$proxy/" > ~/.wgetrc
#echo "http_proxy = http://$proxy/" >> ~/.wgetrc
#echo "ftp_proxy = http://$proxy/" >> ~/.wgetrc
#echo "use_proxy = on" >> ~/.wgetrc
#
#######################
## CURL SETTINGS
## (Bonus Settings! Not required for npm to work, but needed for lots of other programs)
#######################
#echo "proxy=http://$proxy" > ~/.curlrc


######################
# GIT SETTINGS
######################
export git_token=""
