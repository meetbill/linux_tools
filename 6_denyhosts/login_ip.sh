#########################################################################
# File Name: login.sh
# Author: Bill
# mail: XXXXXXX@qq.com
# Created Time: 2016-08-06 01:25:55
#########################################################################
#!/bin/bash
cat /var/log/secure | awk '/Accepted password/{print $0 $(NF-3)}' |awk 'BEGIN{split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec",k," ");for(i=1;i<13;i++){m[k[i]]=i}}{$1=m[$1];print "/"$1"/"$2" "$3" "$(NF-5)" "$(NF-3)" ""Password"}' >login.log
cat /var/log/secure | awk '/Accepted publickey/{print $0 $(NF-3)}' |awk 'BEGIN{split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec",k," ");for(i=1;i<13;i++){m[k[i]]=i}}{$1=m[$1];print "/"$1"/"$2" "$3" "$(NF-5)" "$(NF-3)" ""Key"}'>>login.log
cat login.log | while read myline
do 
    echo -n $myline
    IP=`echo $myline | awk  '{print $4}'`
    SITE=`curl -s "http://ip138.com/ips138.asp?ip=${IP}&act=2" | iconv -f gb2312 -t utf-8| grep '<ul class="ul1"><li>'| awk -F'[><]+' '{print substr($5,6)}'`
    echo "-----"$SITE
done
