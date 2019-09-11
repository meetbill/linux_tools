#!/bin/bash
#########################################################################
# File Name: op_log_rotate.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2019-09-07 14:28:07
# user defile,required
# LOG_KEEP_TIME="15"
# LOG_BACK_DIR="/home/work/test/log/"
# LOG_PATH="/home/work/test/log/access.log"
#########################################################################

END_CMD=""
#default
TODAY=`date +"%Y%m%d%H"`
NOW=`date +"%Y-%m-%d %H:%M:%S"`

function log_cut(){
    if [ ! ${LOG_KEEP_TIME} ] || [ ! ${LOG_BACK_DIR} ] || [ ! ${LOG_PATH} ];then
            log_error "error! Variable not assigned,please check LOG_KEEP_TIME,LOG_BACK_DIR,LOG_PATH"
            exit 2
    fi
    log_info "[${NOW}] [log_file:$LOG_PATH] [backdir:$LOG_BACK_DIR] [keep_day:$LOG_KEEP_TIME] [end_cmd:$END_CMD] start log_cut..."
    log_dir=$(dirname $LOG_PATH)
    log_file=$(basename $LOG_PATH)
    cd ${log_dir}
    if [ $? -ne 0 ];then
            log_error "dir not exist:${log_dir}"
            exit 2
    fi
    #cut log
    if [ ! -f ${log_file} ]; then
        touch ${log_file}.${TODAY}
    else
        mv "${log_file}" "${log_file}.${TODAY}"
        if [ $? -ne 0 ];then
            log_error "mv ${log_file} ${log_file}.${TODAY} fail!"
            exit 4
        fi
    fi

    #exec reload cmd
    if [[ -n "${END_CMD}" ]];then
        log_info "END_CMD=\"${END_CMD}\",start exec..."
        ${END_CMD}
    fi

    #clear log
    for old_log_file in `find ./ -type f -name "${log_file}.20*" -mtime +"${LOG_KEEP_TIME}" `
    do
        log_clear $old_log_file
    done
    log_info "[${NOW}] [log_file:$LOG_PATH] log_cut exec success!!!!"

    # 如果磁盘使用率超过 90 %，则将所有带时间戳日志进行清理
    #################################################
    #home_used=$(df -h | grep "/home"| awk '{print $(NF-1)}' | tr -d '%')
    #if [[ ${home_used} -gt 90 ]];then
    #    log_info "[${NOW}] [/home used]${home_used}% start rm Timestamped logs"
    #    for old_log_file in `find ./ -type f -name "${log_file}.20*"`
    #    do
    #        log_clear $old_log_file
    #    done
    #fi
    #################################################
}

# 删除日志
function log_clear(){
    old_log_file=$1
    old_log_file_size=`du -k ${old_log_file}|awk '{print $1}'`
    # 日志超过 200G,则使用 truncate 进行逐渐删除
    if [[ ${old_log_file_size} -gt 200000000 ]];then
        for i in `seq 200 -10 10`
        do
           truncate -s ${i}G ${old_log_file}
           sleep 5
        done
        log_info "[${NOW}] [old_log_file:$old_log_file] [old_log_size:${old_log_file_size}] truncate success!!!!"
    fi
    [[ -f ${old_log_file}  ]] && rm -rf ${old_log_file}
    log_info "[${NOW}] [old_log_file:$old_log_file] [old_log_size:${old_log_file_size}] rm success!!!!"
    sleep 2
}
