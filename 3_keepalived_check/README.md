# keepalived-tools
## keepalived_checker.py
### Description
Check duplications or typo of VRRP IDs (vrid), Virtual IP Addresses (vrip) and Virtual Servers (vs) from 'keepalived.conf'.

### Tested on
- CentOS 6.5
- keepalived-1.2.13

### Required
- Python 2.6 or 2.7

### Usage
Simply, run it.

```
$ ./keepalived_checker.py
```

If your config file is located on non default path, add `-f`.

```
$ ./keepalived_checker.py -f CONF_PATH
```

### Output Examples
You will get output like this if NG has found.

```
$ ./keepalived_checker.py
'virtual_server' duplications found:
    192.168.1.1:80
        - /etc/keepalived/keepalived.conf:20
        - /etc/keepalived/conf.d/test.conf:2
```

If no errors found, get this.

```
$ ./keepalived_checker.py
OK
```
