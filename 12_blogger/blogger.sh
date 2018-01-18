#!/bin/bash
#########################################################################
# File Name: log.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2016-10-24 17:45:41
# version: 1.6
#########################################################################

#	_debug_=10    #测试是否正确使用
#	_info_=20     #输出程序信息
#	_notice_=30   #输出重要步骤信息
#	_warn_=40     
#	_error_=50
#	_crit_=60

g_LOG_GRADE=/tmp/blogger_grade.log
g_LOG_DEBUG=/tmp/blogger_grade_debug.log

#-----------------------------------------------------
#debug的提示等级
#_LOG_LEVEL="_info_"
_LOG_LEVEL="10"
#-----------------------------------------------------
#{{{ERRTRAP
function ERRTRAP()
{
	echo "[LINE:$1] Error: Command or function exited with status $?"
}
#}}}
#{{{Logit
function Logit()
{
	_debug_=10
	_info_=20
	_notice_=30
	_warn_=40
	_error_=50
	_crit_=60

	_F_LOG_LEVEL=$1

	##enter the log name or number ,convert it to log level number or name
	function get_loglevel()
	{
		_TMP_LOG_LEVEL=$1
		case ${_TMP_LOG_LEVEL} in
    	    _debug_ | 10 )
                _TMP_LOG_LEVEL_NUM=10
                _TMP_LOG_LEVEL_NAME=_debug_;;
    	    _info_ | 20 )
                _TMP_LOG_LEVEL_NUM=20
                # green
                _TMP_LOG_LEVEL_NAME="\033[42;37m_info_\033[0m";;
        	_notice_ | 30 )
                # yellow
                _TMP_LOG_LEVEL_NUM=30
                _TMP_LOG_LEVEL_NAME="\033[43;37m_notice_\033[0m";;
       		_warn_ | 40)
                # yellow
                _TMP_LOG_LEVEL_NUM=40
                _TMP_LOG_LEVEL_NAME="\033[43;37m_warn_\033[0m";;
        	_error_ | 50 )
                # red
                _TMP_LOG_LEVEL_NUM=50
                _TMP_LOG_LEVEL_NAME="\033[41;37m_error_\033[0m";;
        	_crit_ | 60 )
                # red
                _TMP_LOG_LEVEL_NUM=60
                _TMP_LOG_LEVEL_NAME="\033[41;37m_crit_\033[0m";;
        	*)
                # blue
                _TMP_LOG_LEVEL_NUM=255
                _TMP_LOG_LEVEL_NAME="\033[44;37mwronglevel\033[0m";;
		esac

		echo ${_TMP_LOG_LEVEL_NUM} ${_TMP_LOG_LEVEL_NAME}
	}

	#convert
	_F_LOG_LEVEL_NUM=`get_loglevel ${_F_LOG_LEVEL} | awk '{print $1}'`
	_F_LOG_LEVEL_NAME=`get_loglevel ${_F_LOG_LEVEL} | awk '{print $2}'`
	_LOG_LEVEL_NUM=`get_loglevel ${_LOG_LEVEL} | awk '{print $1}'`
	_LOG_LEVEL_NAME=`get_loglevel ${_LOG_LEVEL} | awk '{print $2}'`
	#decide whether to dispaly it or not
	#if the global _LOG_LEVEL config level is less then user configed level
	#then display it
    
	if [ "${_LOG_LEVEL_NUM}" -le "${_F_LOG_LEVEL_NUM}" ]
	then
		if [ "${_F_LOG_LEVEL_NUM}" = "30" ]
		then
			echo "[notice]=====================================================" 2>&1 | tee -a ${g_LOG_GRADE}
		fi
		#define the output prefix format here.
        local DATE_CUR
		DATE_CUR=`date +%F" "%H:%M`
		if [  "${_F_LOG_LEVEL_NUM}" = "10" ]
		then
			echo -ne "${DATE_CUR} LOG_LEVEL[${_F_LOG_LEVEL_NAME}]:" 2>&1 >> ${g_LOG_DEBUG}
        	echo -e  "$_MSG_INFO" 2>&1 >> ${g_LOG_DEBUG}
		else
			echo -ne "${DATE_CUR} LOG_LEVEL[${_F_LOG_LEVEL_NAME}]:" 2>&1 | tee -a ${g_LOG_GRADE}
        	echo -e  "$_MSG_INFO" 2>&1 | tee -a ${g_LOG_GRADE}
		fi
	fi
}
#}}}
#{{{Help
function Help(){
	#use $FUNCNAME to show the function name in the output,so we can know that who 
	#output the message
	Logit _crit_ "function[${FUNCNAME}]: help msg"
}
#}}}
#{{{Test
function Test(){
	Logit 10 "line:[${LINENO}]:Function [${FUNCNAME}]10"
	Logit 20 "line:[${LINENO}]:Function [${FUNCNAME}]20"
	Logit 30 "line:[${LINENO}]:Function [${FUNCNAME}]30"
	Logit 40 "line:[${LINENO}]:Function [${FUNCNAME}]40"
	Logit 50 "line:[${LINENO}]:Function [${FUNCNAME}]50"
	Logit 60 "line:[${LINENO}]:Function [${FUNCNAME}]60"
}
#}}}

#Test

if [[ $# != 2 ]]
then
    echo "usage:$0 10/20/30/40/50/60 'msg'"
else
    _MSG_INFO=$2
    Logit $1
fi
