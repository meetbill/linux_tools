#!/bin/bash
#########################################################################
# File Name: log.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2019-06-12 22:48:11
#########################################################################

# 日志级别常量，大于这个常量的才会打印
LOG_LEVEL_ALL=-9000
LOG_LEVEL_DEBUG=100
LOG_LEVEL_INFO=200
LOG_LEVEL_WARN=300
LOG_LEVEL_ERROR=400
LOG_LEVEL_OFF=9000

##############################日志工具类
#
# 抛异常

# 日志级别
# 
# -1 所有日志
# 
# 默认不输出。要打开debug，可以在调用时export这个变量
if [[ -z "$LOG_LEVEL" ]];then
	LOG_LEVEL=$LOG_LEVEL_ALL
fi
# 日志文件目录
if [[ -z "$SIMPLE_LOG_DIR" ]];then
	SIMPLE_LOG_DIR=/tmp/slog # 避免不同的用户部署时公用文件
fi

# # 获取logger名称
loggerName=$0

# 根据日期获取当天日志名称
function get_log_file() {
	if [ ! -e $SIMPLE_LOG_DIR ];then
		mkdir -p $SIMPLE_LOG_DIR
	fi
	local log_date=$(date +"%Y%m%d")
	local today_log_file=$SIMPLE_LOG_DIR/log_${log_date}.log
	if [ ! -e $today_log_file ];then
		touch $today_log_file
	fi
	echo $today_log_file
}

# 抛异常
function throw() {
	if [ $# -ne 0 ];then
		my_echo_error "$*"
		log_error "$*"
    fi
  	exit 1
}

# 代替echo，输出到标准输出
function my_echo() {
	echo "$*"
	echo `date +%Y-%m-%d\ %H:%M:%S` [$loggerName]' (ECHO) '"$*" >> `get_log_file`
}

# 代替echo，输出到标准错误输出
function my_echo_error() {
	echo "(ERROR)" "$*" >&2
	echo `date +%Y-%m-%d\ %H:%M:%S` [$loggerName]' (ECHO_ERROR) '"$*" >>  `get_log_file`
}

function log_debug() {
	if [ $LOG_LEVEL -le $LOG_LEVEL_DEBUG ];then
		echo `date +%Y-%m-%d\ %H:%M:%S` [$loggerName]' (DEBUG) '"$*" >>  `get_log_file`
	fi
}

function log_info() {
	if [ $LOG_LEVEL -le $LOG_LEVEL_INFO ];then
		echo `date +%Y-%m-%d\ %H:%M:%S` [$loggerName]' (INFO) '"$*" >>  `get_log_file`
	fi
}

function log_warn() {
	if [ $LOG_LEVEL -le $LOG_LEVEL_WARN ];then
		echo `date +%Y-%m-%d\ %H:%M:%S` [$loggerName]' (WARN) '"$*" >>  `get_log_file`
	fi
}

function log_error() {
	if [ $LOG_LEVEL -le $LOG_LEVEL_ERROR ];then
		echo `date +%Y-%m-%d\ %H:%M:%S` [$loggerName]' (ERROR) '"$*" >>  `get_log_file`
	fi
}
