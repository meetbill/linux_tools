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
if [ x$LOG_LEVEL = "x" ];then
	LOG_LEVEL=$LOG_LEVEL_ALL
fi
# 日志文件目录
if [ x$SIMPLE_LOG_DIR = "x" ];then
	SIMPLE_LOG_DIR=/tmp/slog # 避免不同的用户部署时公用文件
fi



# # 获取logger名称
loggerName=$0




# 根据日期获取当天日志名称
getLogFile()
{
	if [ ! -e $SIMPLE_LOG_DIR ];then
		mkdir -p $SIMPLE_LOG_DIR
	fi 
	local logDate=$(date +"%Y%m%d")
	local todayLogFile=$SIMPLE_LOG_DIR/log_${logDate}.log
	if [ ! -e $todayLogFile ];then
		touch $todayLogFile
	fi 
	echo $todayLogFile
}



# 抛异常
throw ()
{
	if [ $# -ne 0 ];then
		myEchoError "$*"
		logError "$*"
	fi  
  	exit 1
}

# 代替echo，输出到标准输出
myEcho()
{
	echo "$*"
	echo `date +%Y-%m-%d\ %H:%M:%S` [$loggerName]' (ECHO) '"$*" >> `getLogFile`

}

# 代替echo，输出到标准错误输出
myEchoError()
{
	echo "(ERROR)" "$*" >&2
	echo `date +%Y-%m-%d\ %H:%M:%S` [$loggerName]' (ECHO_ERROR) '"$*" >>  `getLogFile`
}






logDebug()
{	
	if [ $LOG_LEVEL -le $LOG_LEVEL_DEBUG ];then
		echo `date +%Y-%m-%d\ %H:%M:%S` [$loggerName]' (DEBUG) '"$*" >>  `getLogFile`
	fi
}



logInfo()
{
	
	if [ $LOG_LEVEL -le $LOG_LEVEL_INFO ];then
		echo `date +%Y-%m-%d\ %H:%M:%S` [$loggerName]' (INFO) '"$*" >>  `getLogFile`
	fi
}

logWarn()
{

	if [ $LOG_LEVEL -le $LOG_LEVEL_WARN ];then
		echo `date +%Y-%m-%d\ %H:%M:%S` [$loggerName]' (WARN) '"$*" >>  `getLogFile`
	fi
}


logError()
{
	
	if [ $LOG_LEVEL -le $LOG_LEVEL_ERROR ];then
		echo `date +%Y-%m-%d\ %H:%M:%S` [$loggerName]' (ERROR) '"$*" >>  `getLogFile`
	fi
}



#
##############################

