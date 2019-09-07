#!/bin/bash
#########################################################################
# File Name: test.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2019-06-12 22:54:51
#########################################################################

# 导入log.sh
source ./b_lib/log.sh
# 设置日志存储路径
export SIMPLE_LOG_DIR=./log

# 调用方法
log_info [LINE]:${LINENO} hello, world
log_debug "[LINE]:${LINENO} hello, log_debug"
log_info "[LINE]:${LINENO} hello, log_info"
log_warn "[LINE]:${LINENO} hello, log_warn"
log_error "[LINE]:${LINENO} hello, log_error"

my_echo "[LINE]:${LINENO} hello, my_echo"
my_echo_error "[LINE]:${LINENO} hello, my_echo_error"

throw "[LINE]:${LINENO} Arguments Number Error"
