## shell 服务管理
<!-- vim-markdown-toc GFM -->

* [1 场景](#1-场景)
    * [1.1 简易版服务管理程序](#11-简易版服务管理程序)
    * [1.2 远端执行耗时命令](#12-远端执行耗时命令)
* [2 使用](#2-使用)
    * [2.1 修改文件](#21-修改文件)
    * [2.2 使用](#22-使用)
    * [2.3 外部调用此脚本查询进程状态](#23-外部调用此脚本查询进程状态)
* [3 版本](#3-版本)

<!-- vim-markdown-toc -->

## 1 场景
### 1.1 简易版服务管理程序

用于将服务进行启动，停止，重启，查看运行状态

### 1.2 远端执行耗时命令

比如要在远程的服务器上执行 `sleep 120`，直接执行`ssh ip command`（直接这样执行时，命令会等待子进程退出） 无法批量操作效果，其原因是 ssh 需要确定命令不再有任何的输入输出，并且能有确切的返回值

这个时候可以将 `sleep 120` 放到 run.sh 中完成

## 2 使用

### 2.1 修改文件

> * 将 run.sh 中 `DISP_NAME="cherry_app"` 部分修改为启动程序应用名
> * 将 run.sh 中 `MAIN_FILE="sleep 120"` 部分修改为 `MAIN_FILE= 执行的命令`
> * 将 run.sh 中 `MAIN_FILE_current=${MAIN_FILE}` 检测进程是否存在的关键字（默认与 MAIN_FILE 变量相同）

### 2.2 使用

```
Usage: run.sh {start|stop|restart|status}
 start   Start cherry_app processes.
 stop    Kill all cherry_app processes.
 restart Kill all cherry_app processes and start again.
 status  Show cherry_app processes status.
 version Show run.sh script version.
```
### 2.3 外部调用此脚本查询进程状态

> status 输出的信息包含颜色，是隐藏字符
```
$sh run.sh status | cat -v
^[[1;91m0^[[0m cherry_app processes runing.
```
> 查询方法
```
bash run.sh status | grep processes | grep m0  > /dev/null && echo ERR || echo OK
```

## 3 版本

> * 1.0.0.3 2019-06-13 『更新』启动脚本兼容绝对路径启动
> * 1.0.0.2 2018-07-02 『更新』将启动进程程序与进程标识符进行分离，以适配执行程序与进程标识不同的场景以及需要更换启动路径时场景
> * 1.0.0.1 2018-04-27 初始版本
