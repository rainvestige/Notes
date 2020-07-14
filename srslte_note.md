# Mobile Phone setting

- APN(接入点名称): 
    1. 新建APN
    2. 名称设置
    3. APN设置
    4. apn 一定要设置对，否则会循环报错，要重启软件(both epc and enb)。


- Commercial UE can not detect the created LTE newwork
    1. `n_prb`
    2. `dl_earfcn`
    3. performance -- `device_args`
    4. 根据报错信息修改配置文件rr.conf sib.conf
    5. tm
    6. `nof_ports`

    ```
    sudo srsepc --mme.apn cmnet --mme.mnc 00
    sudo srsenb --enb.mnc 00 --rf.dl_earfcn 1300
    ```

- 开启电脑后第一次运行srsepc和srsenb，需要在运行之后进行网络接口伪装
    ```bash
    # enp34s0 是网络接口，需要根据你的电脑确定。
    ifconfig  # 查看网络接口
    sudo srsepc_if_masq.sh enp34s0
    ```


# Experiments

## 1. only change rf.dl_earfcn
when i change `dl_earfcn`, i only restart srsenb.

### A. earfcn 在小米手机上
| dl_earfcn | IsConnected | Describe |
|-----------|-------------|----------|
| 1300      | 1           |          |
| 1400      | 0           | 报错     |

    
### B. earfcn Huawei
| dl_earfcn | IsConnected | Describe                   |
|-----------|-------------|----------------------------|
| 1300      | 1           |                            |
| 1400      | 1           |                            |
| 1500      | 1           | recover from airplane mode |
| 1600      | 1           | recover from airplane mode     | 
| 1700      | 1           |                            |
| 1800      | 1           |                            |
| 1935-1940 | 1           |                            |
