## shell 服务管理
<!-- vim-markdown-toc GFM -->

* [1 场景](#1-场景)
    * [1.1 简易版服务管理程序](#11-简易版服务管理程序)
    * [1.2 远端执行耗时命令](#12-远端执行耗时命令)
* [2 使用](#2-使用)
    * [2.1 修改文件](#21-修改文件)
    * [2.1 使用](#21-使用)

<!-- vim-markdown-toc -->

## 1 场景
### 1.1 简易版服务管理程序

用于将服务进行启动，停止，重启，查看运行状态

### 1.2 远端执行耗时命令

比如要在远程的服务器上执行 `sleep 120`，直接执行`ssh ip command`(直接这样执行时，会等待子进程退出) 无法批量操作效果

这个时候可以将 `sleep 120` 放到 run.sh 中完成

## 2 使用

### 2.1 修改文件

将 run.sh 中 `MAIN_FILE="sleep 120"` 中，`MAIN_FILE=执行的命令`

### 2.1 使用

```
Usage: run.sh {start|stop|restart|status}
 start   Start cherry_app processes.
 stop    Kill all cherry_app processes.
 restart Kill all cherry_app processes and start again.
 status  Show cherry_app processes status.
```



