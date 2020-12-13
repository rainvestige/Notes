[toc]
# CMake Notes


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


# Modern CMake Guide

## Introduction
CMake is an __open-source, cross-platform__ family of tools designed to build,
test and package software.


## Using CMake

### A. Using the CMake Command Line
1. The command line is the central way to use cmake

2. Commands:
    - `cmake [<options>] (<path-to-source> | <path-to-existing-build>)`\
       configure a build system for the specified cmake project dir
    - `cmake [(-D<var>=<value>)...] -P <cmake-script-file>`\
       execute a cmake script file
    - `cmake --build <dir> [<options>] [-- <build-tool-options>...]`\
       executes the build process through a generic interface
    - `cmake -E <command> [<options>...]`\
       gives you cross platform commands


### B. CMake Syntax
1. CMake's Syntax
    - is very simple, designed for lists of source files
    - also more powerful than you might think
2. every line is a command invocation
3. commands do not return values
4. commands cannot be nested
5. all arguments are strings `abc "abc" 1;2;3;4`
6. variables can be scoped but inherit their parent scope
7. variables can be evaluated using `${<var-name>}`
8. control structures: `if(...) | elseif(...) | else() | endif()`,
   `foreach(...) | endforeach()`, `while(...) | endwhile()`, `break()`,
   `function(...) | endfunction()`, `return(), ...`


### C. CMake Commands
1. CMake provides a lot of scripting functionality out of the [cmake-commands](https://cmake.org/cmake/help/v3.5/manual/cmake-commands.7.html)
   - string(...)
   - file(...)
   - math(...)
   - ...
2. using `include(<module-name>)` you can also add a lot of [functionality by
   contributers](https://cmake.org/cmake/help/v3.5/manual/cmake-modules.7.html)
   - GenerateExportHeader
   - TestBigEndian
   - (you can also contribute yourself)


### D. Useful Variables
1. You have access to a very large list of Variables inside a CMake file
2. Almost every aspect of your build is available in variables
3. Examples:
   - UNIX, WIN32, APPLE, MSYS, ...
   - CMAKE_CURRENT_LIST_DIR
   - CMAKE_CURRENT_SOURCE_DIR
   - CMAKE_CURRENT_BINARY_DIR
   - ...


### E. Create and run a CMake Script file
1. create a file called `fizzbuzz.cmake`
    ```cmake
    # fizzbuzz in cmake
    function(fizzbuzz last)
        foreach(i RANGE 0 ${last})
            math(EXPR notFizz "${i} % 3")
            math(EXPR notBuzz "${i} % 5")
            if(NOT notFizz AND notBuzz)
                message("fizz")
            elseif(notFizz AND NOT notBuzz)
                message("buzz")
            elseif(NOT notFizz AND NOT notBuzz)
                message("fizzBuzz")
            else()
                message("${i}")
            endif()
        endforeach()
    endfunction()

    fizzbuzz(${n})
    ```
2. execute with `cmake -Dn=15 -P fizzbuzz.cmake`


### F. Download, Build and Install Google Test
> _Date: 2020.08.20 Thursday_
```bash
git clone httlps://github.com/google/googletest.git
cd googletest
mkdir build | cd
cmake .. [-G "Visual Studio 14 2015"] -DCMAKE_INSTALL_PREFIX=stage \
-DBUILD_SHARED_LIBS=On
cmake --build . --target install --config Release
```
Results:
    - Downloaded teh gtest repository
    - Created a "out of source" build folder
    - Configured Build System Visual Studio 15 in Shared Library mode
    - Compiled it in Release Configuration and installed it to 
      `CMAKE_INSTALL_PREFIX`
    - Compiling Result is in `googletest/build/stage`


## Anatomy of a CMake Project
> When writing your project configuration never assume to know on which
> toolchain/platform you are building. Keep your Project definitions Explicit.

### A. Anatomy of a CMake Project - Scaffolding
1. `CMakeLists.txt` is the description of your project
2. Always starts with `cmake_minimum_required(VERSION x.x)`
    - This allows CMake to be backwards compatible
3. Always should contain `project(<project-name>)`
    - Names the Solution, does a bit off setup
    - Never assume that your project is the root project
4. Afterwards you may write whatever you like.
    - You should probably define a target else you will not build anything
5. `add_subdirectory(<dir>)`
    Allows you to add subprojects
    - This allows you to easily create a recursive project structure
    - Subdirectory must contain a `CMakeLists.txt`
    - __All paths specified are evaluated from the dir of the current__
      `CMakeLists.txt`
    - Never assume that your project is the root project


### B. Anatomy of a CMake Project - Targets
1. A target is a __node__ inside the dependency graph of your project
2. A target is an executable, static lib, shared lib, header only lib or custom
    - `add_executable(<name> <sourcefile>...)`
    - `add_library(<name> [SHARED|STATIC|INTERFACE]<sourcefile>...)`
    - `add_custom_target(<name> ...)`
    - `(install)`
3. `add_library(<name> [SHARED|STATIC|INTERFACE]<sourcefile>...)`
    - no option `->` creates either shared or static depending on 
      `BUILD_SHARED_LIBS`
    - `SHARED` `->` creates a shared library
    - `STATIC` `->` creates a static library
    - `INTERFACE` creates a header only library
4. `add_library(<name> ALIAS <original>)`
    Allows you to put a library into a custom namespace
5. `add_library(<name> <SHARED|STATIC|MODULE|UNKNOWN> IMPORTED [GLOBAL])`
    Allows you to define a library target for a external library
6. You should use the following functions to control your targets
    - `target_include_directories(<target-name> [PUBLIC|INTERFACE|PRIVATE] 
      <include-dir>...)`\
      adds directories to the include search path
    - `target_compile_definitions(<target-name> [PUBLIC|INTERFACE|PRIVATE]
      <definition>...)`\
      adds preprocessor definitions
    - `target_compile_options(<target-name> [PUBLIC|INTERFACE|PRIVATE]
      <include-dir>...)`\
      adds compiler options(`-Wall, /bigobj ...`)
    - `target_compile_features(<target-name> [PUBLIC|INTERFACE|PRIVATE]
      <include-dir>...)`\
      adds necessary compiler features. (`cxx_constexpr, cxx_variadic_templates`)
    - `target_sources(<target-name> [PUBLIC|INTERFACE|PRIVATE] 
      <source-file>...)`\
      adds more source file
    - `target_link_libraries(<target-name> [PUBLIC|INTERFACE|PRIVATE] 
      <other-target>...)`\
      adds library dependency
7. Scoping
    - `PUBLIC` causes the preperty to be available in current target and in all
      targets depending on it
    - `INTERFACE` causes the property to be available only in targets depending
      on it.
    - `PRIVATE` causes the property to be available only in the current target
8. Examples of Scoping
    - `target_include_directories(myTarget PUBLIC ./include)`\
      __causes the directory `./include` to be searched for include files by
      `myTarget` and in all targets which depend on it via 
      `target_link_libraries`__
    - `target_include_directories(myTarget PRIVATE ./src)`\
      causes the directory `./src` to be searched for include files only by 
      `myTarget`
    - `target_compile_definitions(myTarget INTERFACE USE_MYTARGET)`\
      causes the preprocessor definition `USE_MYTARGET` to be defined in all
      targets depending on `myTarget` but not in `myTarget` itself


### C. Anatomy of a CMake Project - Tests
1. CMake allows you to wrap executables as test cases
2. It allows you or your Build Server to simply execute tests
3. It is possible to enables upload of test results to CDash
    - CDash can collect all build information and test run results from every
      client that builds a project
4. Usage
    - to enable, add `enable_testing()` to your `CMakeLists.txt`
    - Create an executable which runs your test using `add_executable()`
    - Create a test by using `add_test(<testname> <commond> [arg...])`
    - Unit testing Frameworks like gtest are easily integrated
5. On Command Line:
    - `ctest`


### D. Anatomy of a CMake Project - Installation
1. After the build process is complete you want to deploy your application
2. An installation is normally a collection of files in a specific directory
   structure
3. Installing is the transformation of build results to this specific structure
4. ie
    - deploy include files
    - deploy binaries (shared libs and executables)
    - deploy libs
    - deploy resources / docs
5. CMake provides a mechanism which creates an installation target
6. `install(...)`
    causes the build system to do something when the install target is executed
7. `install(FILES <file>... DESTINATION <dir>)`
    copies the file from the source directory to the prefix directory
8. `install(EXPORT <target> NAMESPACE <name> DESTINATION <dir>)`
    creates an import file for your installation that other cmake projects can
    use.


### E. Anatomy of a CMake Project - External Dependency
1. The Export file we created in the installation step can now be include in a
    different project
2. Copy the installed files to another project (or Create a package)
3. `include(<path-to-export-file>)`
    in another CMake project to have all installed targets available
4. or use `add_library(<name> IMPORTED)`
    - `set_property(TARGET <name> INTERFACE_INCLUDE_DIRECTORIES <include-dir>...)`
    - `set_property(TARGET <name> IMPORTED_LOCATION <path-to-lib-or-dll>...)`
    - `set_property(TARGET <name> IMPORTED_IMPLIB <path-to-lib-or-dll>...)`
    - ...


[cmake source code]: https://gitlab.kitware.com/cmake/cmake
[cmake find package]: https://blog.csdn.net/bytxl/article/details/50637277


[cmake build guide]: https://img-blog.csdnimg.cn/20200724150839350.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE3NDUyMjg=,size_16,color_FFFFFF,t_70
[ccmake dependency]: https://img-blog.csdnimg.cn/20200725213352473.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE3NDUyMjg=,size_16,color_FFFFFF,t_70
[srslte FindUHD.cmake before change]: https://img-blog.csdnimg.cn/20200730204546360.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE3NDUyMjg=,size_16,color_FFFFFF,t_70
[srslte FindUHD.cmake after change]: https://img-blog.csdnimg.cn/20200730204607959.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE3NDUyMjg=,size_16,color_FFFFFF,t_70
[srslte build after modify FindUHD.cmake]: https://img-blog.csdnimg.cn/2020073020494418.png
