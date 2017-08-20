## 使用[PROMPT_COMMAND]变量 实现审计操作行为功能

### 安装
```
#curl -o audit_action.sh https://raw.githubusercontent.com/BillWang139967/linux_tools/master/07_audit_action/audit_action.sh
#bash audit_action.sh
```
### 提示

此日志文件如果需要删除时，在执行删除操作时，会提示没有权限，这个就是chattr对文件实现的保护功能了，如果需要删除此文件，需要执行

```
chattr -a /var/log/Command_history.log
chmod 777 /var/log/Command_history.log
```

然后对日志文件进行删除操作

### 相关

[ssh_menu](https://github.com/BillWang139967/shell_menu)
