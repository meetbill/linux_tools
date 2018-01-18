## blogger 使用
<!-- vim-markdown-toc GFM -->
* [1 使用](#1-使用)
    * [1.1 命令行使用](#11-命令行使用)
    * [1.2 日常脚本中使用方法](#12-日常脚本中使用方法)
        * [调试日志](#调试日志)
* [2 日志级别说明](#2-日志级别说明)
* [3 version](#3-version)

<!-- vim-markdown-toc -->

## 1 使用
### 1.1 命令行使用
```
bash ./blogger.sh 10 "ceshi"
bash ./blogger.sh 20 "ceshi"
```
> * 执行后，debug 记录只记录到日志
> * info 及以上的记录记录到日志中并输出到屏幕上

### 1.2 日常脚本中使用方法

#### 调试日志

比如程序运行时进入某个函数时，将日志记录到 debug 日志 

```
# 在脚本文件开始出获取脚本文件名
FILE_NAME=$0

# 在函数中记录调试信息，将 [文件名] [函数名] [行数] 记录到日志中
bash ./blogger.sh 10 "File:[${FILE_NAME}] Function:[${FUNCNAME}] line:[${LINENO}]"
```
## 2 日志级别说明

```
#	_debug_=10    #测试是否正确使用
#	_info_=20     #输出程序信息
#	_notice_=30   #输出重要步骤信息
#	_warn_=40     
#	_error_=50
#	_crit_=60
```
## 3 version 

v1.6:增加输出颜色 
