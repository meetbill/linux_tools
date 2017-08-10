#!/bin/bash
#########################################
#Function:    
#Usage:       
#Author:      wangbin
#Company:     
#Version:     1.1
#########################################
#{{{Update_filelog
#}}}
#{{{read_library
. ./lib_sh/debug_grade.sh

#}}}
#{{{useage
#	_debug_=10    #测试是否正确使用
#	_info_=20     #输出程序信息
#	_notice_=30   #输出重要步骤信息
#	_warn_=40     
#	_error_=50
#	_crit_=60

#}}}


#{{{Test
function Test()
{
	AUTHOR=wangbin
	Logit 30 "line:[${LINENO}] function:[${FUNCNAME}]"
	Logit 10 "line:[${LINENO}] Function:[${FUNCNAME}] AUTHOR=${AUTHOR}"
}
#}}}
#{{{main
function main ()
{
	Logit 10 "*******************************************************"
	#----------------------------------------------------------
	if [ 0 == 0 ]  #这个地方“0=0”是表示执行某服务。
	then
		#删除旧日志
		rm -rf /tmp/SHELLWHEEL*
	fi
	
	#如何执行没有报错，执行更新服务命令
	if [ $? -eq 0 ]
	then
		Test
	else    #同上
		exit 1
	fi
}
#}}}
#{{{X_help
function X_help(){
	
	clear
	echo -e            "==========================help==============================" 
    echo 
    echo               "------------------------------------------------------------"
    echo
    echo               "   sh test.sh -m           #Executing the main program"
    echo
    echo               "------------------------------------------------------------"
    echo -e "\033[42;37m                      version 0.1                           \033[m"
    echo -e "\033[42;37m                      Time:2015-08-15                       \033[m"
    echo               "------------------------------------------------------------"
}
#}}}
# See how we were called.
case "$1" in
  -m)
    main
    ;;
  *)
    X_help
    exit 2
esac

exit $?
