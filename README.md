# linux_tools

* 1_parted_mkfs 批量对硬盘进行分区和格式化
* 2_raid_monitor 对raid进行监控
* 3_keepalived_check 对keepalived的配置文件进行检查
* 4_linux_iptables 配置iptables
* 5_change_hostname 对hostname进行修改
* 6_denyhosts 简单防止ssh暴力破解脚本
* 7_audit_action linux操作审计

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
