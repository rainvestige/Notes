# V2RAY SETUP

## 1. Windows Install
Ref:
* [www.v2ray.com](https://www.v2ray.com/)

#
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
  
## 2. Android Install

#
1. Download the `v2rayNG` from 
  [here](https://github.com/2dust/v2rayNG/releases) and install the `.apk` file

2. 点击左上角菜单按钮展开菜单->订阅设置->点击右上角
  “+”，remarks随便填，URL填写你的v2ray订阅地址并点击右上角“√”保存

3. 回到软件主界面->点击右上角“更多”按钮->更新订阅

4. 选择一个节点，点击右下角按钮订阅

## 3. Linux Install

#
1. Download the `Qv2ray.***.AppImage` from 
  [here](https://github.com/Qv2ray/Qv2ray/releases)

2. Bash command
    ```bash
    chmod +x Qv2ray.***.AppImage
    ./Qv2ray.***.AppImage
    ```

3. Configure the `Qv2ray`
    
    TODO: subscription setting and proxy setting
