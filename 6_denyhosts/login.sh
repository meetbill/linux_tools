#########################################################################
# File Name: login.sh
# Author: Bill
# mail: XXXXXXX@qq.com
# Created Time: 2016-08-06 01:25:55
#########################################################################
#!/bin/bash
cat /var/log/secure | awk '/Accepted password/{print $0 $(NF-3)}' |awk 'BEGIN{split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec",k," ");for(i=1;i<13;i++){m[k[i]]=i}}{$1=m[$1];print "/"$1"/"$2" "$3" ["$(NF-3)"] ""Password"}'
cat /var/log/secure | awk '/Accepted publickey/{print $0 $(NF-3)}' |awk 'BEGIN{split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec",k," ");for(i=1;i<13;i++){m[k[i]]=i}}{$1=m[$1];print "/"$1"/"$2" "$3" ["$(NF-3)"] ""Key"}'
