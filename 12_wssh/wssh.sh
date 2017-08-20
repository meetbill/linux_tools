#!/bin/bash

#{{{ array_check
####循环检查pids数组中的pid是否运行结束的函数
array_check () {
    if [  ${pids} == 0 ] ;then
       echo "pids error"
       echo NULL >/dev/null
    else 
       ####通过/proc目录动态检查pid是否结束,执行成功说明进程还没有结束
       ls /proc | grep  ^${pids}$ 2>&1 >/dev/null
       pidstatus=$?
       # echo pidstatus=$pidstatus
       ###if pids is not exists in /proc,that indecates the process is over,and display execute result,clean respective array elements
       if [ $pidstatus != 0 ] ;then
          ####进程结束后，打印执行结果log
          echo
          echo  "****************************** remote screen results for pids[${pids}]  ip[${ip}] ********************************"
          sed -n '1,3p' $tmp_dir/${ip}.log|cut -d" " -f1|grep Linux >/dev/null 2>&1
          cmd_excute_status=$?
          if [  ${cmd_excute_status} == 0 ] ;then
             ####绿色闪烁
             echo -e "\033[32m\033m ${ip} ok\033[0m"
             echo -e "\033[32m\033m $(grep ERROR $tmp_dir/${ip}.log)\033[0m"
             complete_num_success=$((${complete_num_success}+1))
          else
             echo -e "\033[31m\033m login ${ip} failure\033[0m"
             echo -e "\033[31m\033m $(cat $tmp_dir/${ip}.log)\033[0m"
        fi
          #####同时pids数组中对应pid重置为0
          pids=0
          ####进程结束，返回200供后续判断
          return 200
          break
       fi
   fi
    ###wait for 1 seconds to check whether the pids is over
   sleep 3
}
#}}}
CUR_DIR=$(cd `dirname $0`; pwd)
cd ${CUR_DIR}

if [ $# != 2 ]
then
    echo "usage:$0 IP remote_cmd_file"
    exit 0
fi


wssh_root_dir=./
tmp_dir=$wssh_root_dir/tmp
mkdir -p $tmp_dir

####指定远程主机列表或主机列表文件
ip=$1
cmd=$2

####加载ssh连接用户名及密码文件
source ./.userpass.sh

####指定ssh相关参数
####普通ssh选项，相同任务每次执行时间基本相同 (OpenSSH 5.6之前版本使用)
#ssh_options=" -o StrictHostKeyChecking=no"
ssh_options="  -o StrictHostKeyChecking=no -o PubkeyAuthentication=no "
ssh_cmd="/usr/bin/sshpass -p${remote_ssh_user_pass} /usr/bin/ssh ${ssh_options}"
echo ============results report:================
${ssh_cmd} ${remote_ssh_user}@$ip bash < $cmd > $tmp_dir/$ip.log 2>&1 &
# Shell最后运行的后台Process的PID
pids=$!
complete_num=0
#echo complete_num:${complete_num}
while [ ${complete_num} != 1 ] ;do
   array_check 
   ####根据array_check函数返回值是否成功来确定complete_num数的增加
   if [ $? == 200 ] ;then
      complete_num=1
   fi
   #sleep 1
done
echo ========================================================================

