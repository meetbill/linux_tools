# linux_tools

* [01_parted_mkfs](./01_parted_mkfs/) 批量对硬盘进行分区和格式化
* [02_raid_monitor](./02_raid_monitor/) 对raid进行监控
* [03_keepalived_check](./03_keepalived_check/) 对keepalived的配置文件进行检查
* [04_linux_iptables](./04_linux_iptables/) 配置iptables
* [05_change_hostname](./05_change_hostname/) 对hostname进行修改
* [06_denyhosts](./06_denyhosts/) 简单防止ssh暴力破解脚本
* [07_audit_action](./07_audit_action/) linux操作审计
* [08_rm](./08_rm/) 开启 linux 回收站
* [09_screen](./09_screen/) 开启 screen 状态栏
* [10_rebuild_centos](./10_rebuild_centos/) 构建 centos 系统程序
* [11_shell_common](./11_shell_common/) 相关模板

## 相关项目

> * [shell_menu](https://github.com/BillWang139967/shell_menu)
> * [op_practice_code](https://github.com/BillWang139967/op_practice_code)

## 参加步骤

* 在 GitHub 上 `fork` 到自己的仓库，然后 `clone` 到本地，并设置用户信息。
```
$ git clone https://github.com/BillWang139967/linux_tools.git
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
$ git remote add upstream https://github.com/BillWang139967/linux_tools.git
$ git fetch upstream
$ git checkout master
$ git rebase upstream/master
$ git push -f origin master
```
