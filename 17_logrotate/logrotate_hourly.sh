#!/bin/bash
#########################################################################
# File Name: logrotate_hourly.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2019-09-07 14:27:19
#
# [1] required parameter:
#   LOG_KEEP_TIME="10"
#   LOG_BACK_DIR="/home/work/test/log/"
#   LOG_PATH="/home/work/test/log/access.log"
#   END_CMD="echo kakaka"
#
# [2] function:log_cut  log_clear
#   log_cut contain log_clear
#
# [3] tips:you have ro redefine all required parameter before add a new task!(otherwise the parameter will use the old one)
#########################################################################

CUR_DIR=$(cd `dirname $0`; pwd)
cd ${CUR_DIR}

EXE_LOG=${CUR_DIR}/log
export SIMPLE_LOG_DIR=${EXE_LOG}

APP_HOME=${CUR_DIR}/..
# NGINX_PID_PATH=${APP_HOME}/log
ADAPTER_LOG_PATH="${APP_HOME}/log"
NUTCRACKER_LOG_PATH="${APP_HOME}/log"

source ${CUR_DIR}/log_rotate_lib/log.sh
source ${CUR_DIR}/log_rotate_lib/op_log_rotate.sh

if [[ $? -ne 0 ]];then
    echo "[`date +"%Y-%m-%d %H:%M:%S"`] source ./op_log_rotate.sh fail !"
    exit 2;
fi
#########################################################
# task demo1
#LOG_KEEP_TIME="7"
#LOG_PATH="${NGINX_LOG_PATH}/nginx.access_log"
#LOG_BACK_DIR=$(dirname ${LOG_PATH})
#END_CMD=""
#log_cut
# task demo2
#LOG_KEEP_TIME="7"
#LOG_PATH="${NGINX_LOG_PATH}/nginx.error_log"
#LOG_BACK_DIR=$(dirname ${LOG_PATH})
#END_CMD="kill -USR1 `cat ${NGINX_PID_PATH}/nginx.pid`"
#log_cut
#########################################################

#task 1
LOG_KEEP_TIME="2"
LOG_PATH="${ADAPTER_LOG_PATH}/demo.log"
LOG_BACK_DIR=$(dirname ${LOG_PATH})
END_CMD=""
log_cut
sleep 10
#task 2
LOG_KEEP_TIME="2"
LOG_PATH="${ADAPTER_LOG_PATH}/demo.log.wf"
LOG_BACK_DIR=$(dirname ${LOG_PATH})
END_CMD=""
log_cut
sleep 10
#task 3
LOG_KEEP_TIME="2"
LOG_PATH="${NUTCRACKER_LOG_PATH}/nutcracker.log"
LOG_BACK_DIR=$(dirname ${LOG_PATH})
END_CMD="kill -1 `ps -ef | grep ${APP_HOME} | grep nutcracker | grep -v grep | awk '{print $2}'`"
log_cut

