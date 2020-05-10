# Install the anaconda
Download the installer from [here](https://www.anaconda.com/products/individual)
```bash
bash ~/Downloads/Anaconda*-linux-x86_64.sh
```
Follow the instructions to continue the installation.


# Configure file
`~/.condarc`


# Copying the env
1. conda env copying

    ```bash
    conda env export > environment.yml
    conda env create -f environment.yml 
    ```
    When create the new environment, the env name in environment.yml must not exist
    in your conda env.

2. pip copying

    Enter the conda env(source)
    ```bash
    conda activate py3
    ```
    
    Export the pip libraries to requirements.txt
    ```bash
    pip freeze > requirements.txt
    ```
    
    Enter the conda env(destination) and install the pip libraries
    ```bash
    conda activate py3
    
    pip install -r requirements.txt
    ```


# Ref
1. [Anaconda介绍、安装及使用教程](https://www.jianshu.com/p/62f155eb6ac5)
2. [conda环境和pip包的转移复制](https://blog.csdn.net/a970973835/article/details/88929966)
