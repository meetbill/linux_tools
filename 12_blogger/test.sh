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
logInfo [LINE]:${LINENO} hello, world
logDebug "[LINE]:${LINENO} hello, logDebug"
logInfo "[LINE]:${LINENO} hello, logInfo"
logWarn "[LINE]:${LINENO} hello, logWarn"
logError "[LINE]:${LINENO} hello, logError"

myEcho "[LINE]:${LINENO} hello, myEcho"
myEchoError "[LINE]:${LINENO} hello, myEchoError"

throw "[LINE]:${LINENO} Arguments Number Error"
