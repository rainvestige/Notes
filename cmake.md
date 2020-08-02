## CMake Notes


## A. Build and Install

1. Get the [cmake source code]
    ```bash
    git clone https://gitlab.kitware.com/cmake/cmake.git
    ```

2. Prepare the dependency for ccmake
    ```bash
    sudo apt-get install build-essential git
    ```
    ![ccmake dependency]

2. Build and Install
    ![cmake build guide]

3. Configure the Env
    ```bash
    # Set soft link
    sudo ln -s cmake_version cmake

    sudo vim /etc/profile
    export PATH=$PATH:/path/to/cmake/bin
    ```


## B. Command Line
1. `cmake --help-module FindBoost`

2. ctest
    ```bash
    cd $YOUR_BUILD_DIRECTORY
    ctest -R name_of_your_test
    # note that `-R` matches a regular expression
    ```

3. ccmake


## C. FIND_PACKAGE

1. References
    - [cmake find package]

2. srsLTE couldn't find uhd\
    Default `CMakeLists.txt` can not find the UHD include path and library path,
    because i change the `CMAKE_INSTALL_PREFIX` of UHD from the default 
    `/usr/local/` to `/usr/local/opt/uhd_VER_SION/` where the `VER_SION` 
    indicates the version of UHD. 
    
    So we should add some content in the `FindUHD.cmake` file contained in the 
    folder `srsLTE/cmake/modules/`.
    `FindUHD.cmake`原始内容如下图所示:\
    ![srslte FindUHD.cmake before change]
    `FindUHD.cmake`添加的内容如下:\
    ![srslte FindUHD.cmake after change]\
    修改了`FindUHD.cmake`之后, 重新编译srsLTE, cmake的结果显示已经找到UHD
    ![srslte build after modify FindUHD.cmake]


[cmake source code]: https://gitlab.kitware.com/cmake/cmake
[cmake find package]: https://blog.csdn.net/bytxl/article/details/50637277


[cmake build guide]: https://img-blog.csdnimg.cn/20200724150839350.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE3NDUyMjg=,size_16,color_FFFFFF,t_70
[ccmake dependency]: https://img-blog.csdnimg.cn/20200725213352473.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE3NDUyMjg=,size_16,color_FFFFFF,t_70
[srslte FindUHD.cmake before change]: https://img-blog.csdnimg.cn/20200730204546360.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE3NDUyMjg=,size_16,color_FFFFFF,t_70
[srslte FindUHD.cmake after change]: https://img-blog.csdnimg.cn/20200730204607959.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE3NDUyMjg=,size_16,color_FFFFFF,t_70
[srslte build after modify FindUHD.cmake]: https://img-blog.csdnimg.cn/2020073020494418.png
