#########################################################################
# File Name: ip_site.sh
# Author: Bill
# mail: XXXXXXX@qq.com
# Created Time: 2016-08-06 01:57:57
#########################################################################
#!/bin/bash

curl -s "http://ip138.com/ips138.asp?ip=$1&act=2" | iconv -f gb2312 -t utf-8| grep '<ul class="ul1"><li>'| awk -F'[><]+' '{print substr($5,6)}'
