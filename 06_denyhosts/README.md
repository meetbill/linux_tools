
## ssh 暴力破解

### ssh暴力破解检测方法

输出尝试密码失败IP列表
```
# cat /var/log/secure | awk '/Failed/{print $(NF-3)}' | sort | uniq -c | awk '{print $2" = "$1;}'| sort -n -k 2 -t = -r
```

### ssh防暴力破解方法

(1)简单脚本操作

原理就是定时检查/var/log/secure中尝试密码登陆IP，超过10次后，将此IP放到/etc/hosts.deny中，禁止ssh登陆

通过crontab来执行，每天的1点0分执行一次。

0 1 * * * sh /root/bin/denyhosts.sh

下载方式
```
#curl -o denyhosts.sh https://raw.githubusercontent.com/BillWang139967/linux_tools/master/6_denyhosts/denyhosts.sh
```

(2)DenyHosts

据说有点坑，就不详细介绍了

## 提升ssh安全

### 修改sshd服务器的配置文件/etc/ssh/sshd_config

* Port 5555  #系统缺省使用22号端口
* ListenAddress 192.168.0.1 #设定sshd只在其中一个指定的接口地址监听，这样可以减少sshd的入口，降低入侵的可能性。
* PermitRootLogin no #禁止root用户登录
* PermitEmptyPasswords no #禁止空密码登陆
* Protocol 2 #禁止使用版本1协议，因为其存在设计缺陷，很容易使密码被黑掉。

### 修改sshd服务器的配置文件/etc/ssh/sshd_config的读写权限，

对所有非root用户设置只读权限，防止非授权用户修改sshd服务的安全设置。
```
chmod 644 /etc/ssh/sshd_config
```
### 设置TCP Wrappers

使用TCPWrappers可以阻止或允许应用服务仅对某些主机开放，给系统在增加一道安全屏障。

这部分设置共涉计到两个文件：hosts.allow和hosts.deny。
   
如系统仅允许IP地址为192.168.0.15和10.0.0.11的主机使用sshd服务，
```
   在/etc/hosts.allow中添加
   sshd:192.168.0.15 10.0.0.11

   在/etc/hosts.deny中添加
   sshd:All
```
注意：系统对上述两个文件的判断顺序是先检查hosts.allow文件再查看hosts.deny文件

### 尽量关闭一些系统不需要的启动服务

## 其他

检测用户登录脚本
```
sh login_ip.sh
```
下载方法
```
#curl -o login.sh https://raw.githubusercontent.com/BillWang139967/linux_tools/master/6_denyhosts/login.sh
#curl -o login_ip.sh https://raw.githubusercontent.com/BillWang139967/linux_tools/master/6_denyhosts/login_ip.sh
```
