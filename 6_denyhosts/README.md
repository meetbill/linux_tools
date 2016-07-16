
## ssh 暴力破解

### ssh暴力破解检测方法

```
# cat /var/log/secure | awk '/Failed/{print $(NF-3)}' | sort | uniq -c | awk '{print $2" = "$1;}'
```

### ssh防暴力破解方法

(1)简单脚本操作

原理就是定时检查/var/log/secure中尝试密码登陆IP，超过10次后，将此IP放到/etc/hosts.deny中，禁止ssh登陆

通过crontab来执行，每天的1点0分执行一次。
0 1 * * * sh /root/bin/denyhosts.sh

(2)DenyHosts

据说有点坑，就不详细介绍了

