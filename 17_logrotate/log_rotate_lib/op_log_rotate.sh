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

    #clear log
    find ./ -type f -name "${log_file}.20*" -mtime +"${LOG_KEEP_TIME}" |xargs rm -f &
    #exec reload cmd
    if [[ -n "${END_CMD}" ]];then
        log_info "END_CMD=\"${END_CMD}\",start exec..."
        ${END_CMD}
    fi
    log_info "[${NOW}] [log_file:$LOG_PATH] log_cut exec success!!!!"
}

function log_clear(){
    if [ ! ${LOG_KEEP_TIME} ] || [ ! ${LOG_BACK_DIR} ] || [ ! ${LOG_PATH} ];then
            log_error "error! Variable not assigned,please check LOG_KEEP_TIME,LOG_BACK_DIR,LOG_PATH"
            exit 2
    fi
    log_info "[${NOW}] [log_file:$LOG_PATH] [backdir:$LOG_BACK_DIR] [keep_day:$LOG_KEEP_TIME] [end_cmd:$END_CMD] start log_clear..."
    log_dir=$(dirname $LOG_PATH)
    log_file=$(basename $LOG_PATH)
    cd ${log_dir}
    if [ $? -ne 0 ];then
            log_error "dir not exist:${log_dir}"
            exit 2
    fi
    #clear log
    find ./ -type f -name "${log_file}.20*" -mtime +"${LOG_KEEP_TIME}" |xargs rm -f &
    #exec reload cmd
    if [[ -n "${END_CMD}" ]];then
        log_info "END_CMD=\"${END_CMD}\",start exec..."
        ${END_CMD}
    fi
    log_info "[${NOW}] [log_file:$LOG_PATH] log_clear exec success!!!!"
}
