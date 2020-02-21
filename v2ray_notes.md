# V2RAY SETUP
Ref:
* [www.v2ray.com](https://www.v2ray.com/)

##
## 1. Windows Install

1. Download the `v2rayN-core.zip` file from [here](https://github.com/2dust/v2rayN/releases)

2. Unzip the `v2rayN-core.zip` into `path_to_v2ray` directory

3. Run the `v2rayN.exe` 

4. 双击任务栏右下角V2RayN图标->订阅->订阅设置->添加->在url栏填入你的
  v2ray订阅地址

5. 在主界面->订阅->更新订阅->服务器列表刷新出地址代表成功更新订阅

6. 在主界面->参数设置->

    core:基础设置->Http代理：开启Http代理，并自动配置代理服务器
  
    core:路由设置->一键设置默认自定义路由规则

7. click any area in `server list`, press Ctrl+A 全选所有服务器，之
    后，主界面->服务器->测试服务器延迟(ping). 所有测试结果大于 
    __0ms__ 的服务器都是可以用的。

8. 右击任务栏右下角v2rayN图标->服务器->选择一个可以用的服务器。接下来
    就可以愉快的上网了。

##
## 2. Android Install

1. Download the `v2rayNG` from 
  [here](https://github.com/2dust/v2rayNG/releases) and install the `.apk` file

2. 点击左上角菜单按钮展开菜单->订阅设置->点击右上角
  “+”，remarks随便填，URL填写你的v2ray订阅地址并点击右上角“√”保存

3. 回到软件主界面->点击右上角“更多”按钮->更新订阅

4. 选择一个节点，点击右下角按钮连接

##
## 3. Linux Install

1. Download the `Qv2ray.***.AppImage` from 
  [here](https://github.com/Qv2ray/Qv2ray/releases)

2. Bash command
    ```bash
    chmod +x Qv2ray.***.AppImage
    ./Qv2ray.***.AppImage
    ```

3. Configure the `Qv2ray`

>  * 主界面->订阅->左下方添加按钮
>  * Subscription Name: 随便取
>  * Subscription Address: 填写你的订阅地址
>  * Update Interval: 更改为1天
>  * 最后点击右下方的 __更新订阅数据__ 并确定
>
>  - 主界面->Preferences-General Setting->V2ray setting
>  - Core Executable Path: `/path/to/v2ray/v2ray` 具体的地址看你把下面的压缩文件解压到哪 
     [v2ray-linux-***.zip](https://github.com/v2ray/v2ray-core/releases) 
>  - V2ray Assets Directory: `/path/to/v2ray` 是上面执行路经的上一级目录
>
>  - 主界面->入站设置->设置系统代理的勾打上，SOCKS 和 HTTP设置的勾也都要打上 

4. 选择一个可以用的节点, 点击主界面上方的连接按钮，如果没有问题就可以科学上网了


5. TODO: 可以使用[AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher/releases)
    进行简化操作，不需要每次都用终端运行程序

    [参考链接](https://itdashu.com/linux/ubuntu/appimage-launcher.html)
