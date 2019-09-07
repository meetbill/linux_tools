#!/bin/bash
#########################################################################
# File Name: logrotate_loop.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2019-09-07 16:09:18
#########################################################################

#执行一次后，sleep的时间(300 s)
LOGROTATE_SLEEP=300

#每次判断当前分钟数的时间间隔(60 s)
CHECK_SLEEP=60

function logrotate_loop()
{
    while true;
    do
        current_minute=`date +%M`
        # 08的时候会报错，转成10进制
        current_minute=$((10#$current_minute))
        if  [[ $current_minute -ge 0 && $current_minute -le 2  ]]
        then
            bash ./logrotate_exe.sh
            sleep $LOGROTATE_SLEEP
        fi
        sleep $CHECK_SLEEP
    done

}

logrotate_loop
