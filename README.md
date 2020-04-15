# linux_tools

> * 安全
>   * [denyhosts](./06_denyhosts/) 简单防止 ssh 暴力破解脚本
>   * [audit_action](./07_audit_action/) linux 操作审计
>   * [linux_iptables](./04_linux_iptables/) 配置 iptables
> * 磁盘
>   * [parted_mkfs](./01_parted_mkfs/) 批量对硬盘进行分区和格式化
>   * [mount_file](./13_mount_file) 将文件进行挂载
> * 监控
>   * [raid_monitor](./02_raid_monitor/) 对 raid 进行监控
> * 配置
>   * [keepalived_check](./03_keepalived_check/) 对 keepalived 的配置文件进行检查
>   * [change_hostname](./05_change_hostname/) 对 hostname 进行修改
> * 易用
>   * [rm](./08_rm/) 开启 linux 回收站
>   * [screen](./09_screen/) 开启 screen 状态栏
>   * [opmv](./18_opmv/) 类似 Linux 回收站，将文件移动到特定备份目录
> * 工具
>   * [rebuild_centos](./10_rebuild_centos/) 构建 centos 系统程序
>   * [shell_common](./11_shell_common/) 相关模板
>   * [daemon](./14_daemon) 管理程序工具
>   * [tcpcopy 管理工具](./15_tcpcopy)
> * 日志
>   * [blogger](./12_blogger/) 记录 shell 运行日志
>   * [truncate](./16_truncate) 使用 truncate 安全地删除大文件
>   * [logrotate](./17_logrotate) 通用日志切割和清理，按照时间切割

## 相关项目

> * [shell_menu](https://github.com/meetbill/shell_menu)
> * [op_practice_code](https://github.com/meetbill/op_practice_code)

## 参加步骤

* 在 GitHub 上 `fork` 到自己的仓库，然后 `clone` 到本地，并设置用户信息。
```
$ git clone https://github.com/meetbill/linux_tools.git
$ cd linux_tools
$ git config user.name "yourname"
$ git config user.email "your email"
```
* 修改代码后提交，并推送到自己的仓库。
```
$ #do some change on the content
$ git commit -am "Fix issue #1: change helo to hello"
$ git push
```
* 在 GitHub 网站上提交 pull request。
* 定期使用项目仓库内容更新自己仓库内容。
```
$ git remote add upstream https://github.com/meetbill/linux_tools.git
$ git fetch upstream
$ git checkout master
$ git rebase upstream/master
$ git push -f origin master
```


## Stargazers over time

[![Stargazers over time](https://starchart.cc/meetbill/linux_tools.svg)](https://starchart.cc/meetbill/linux_tools)

