#!/bin/bash
#########################################################################
# File Name: trap_err.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2018-01-19 09:30:20
#########################################################################
#!/bin/bash
FILENAME=$0
#定义捕捉ERR伪信号的函数
ERRTRAP()
{
    echo "[FILE:${FILENAME}] [LINE:$1] Error: Command or function exited with status $?"
}

fun_will_fail()
{
    #函数返回非零值表示错误
    return 1
}

fun_will_succed()
{
    #返回0表示函数执行成功
    return 0
}

fun_sub_will_fail()
{
    jjjjj
    return 0
}

#命令或者函数产生的每一个错误都将产生一个ERR伪信号
#这里执行trap命令是希望通过函数ERRTRAP扑捉这个ERR伪信号
trap 'ERRTRAP $LINENO' ERR 

#模拟一个失败的命令
command_not_exist 2>/dev/null

#模拟一个成功执行的函数 
fun_will_succed

#模拟一个失败了的函数
fun_will_fail

#模拟一个失败了的子函数 ,需要执行脚本的时候通过 -E 参数进行捕获子程序的 ERR
fun_sub_will_fail

exit 0
