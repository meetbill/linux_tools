---
layout: post
title:
subtitle:
date: 2018-07-03 11:15:39
category:
author: meetbill
tags:
   -
---

## tcpcopy

> * 此工具用于远程管理 tcpcopy 和 intercept 

## 使用

> * (1) 本地编译 tcpcopy [编译 tcpcopy 工具](https://github.com/meetbill/shell_menu),将生成后的目录 /root/tcp_copy 中的所有文件放到本目录下的 tcp_copy
> * (2) 使用 run.sh

```
Usage: run.sh {start|stop|restart|status}
 start  source_ip_port dest_ip_portStart  processes.
 copy_stop    source_ip_port Kill all  processes.
 copy_status  source_ip_port Show  processes status.
 cept_stop    dest_ip_port Kill all  processes.
 cept_status  dest_ip_port Show  processes status.
```
## 附录
最后的目录结构如下
```
├── run.sh
└── tcp_copy
    ├── bin
    ├── cept.sh
    ├── conf
    ├── copy.sh
    ├── include
    ├── lib
    ├── logs
    ├── sbin
    ├── share
```
