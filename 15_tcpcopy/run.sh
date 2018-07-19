#!/bin/bash
#########################################################################
# File Name: run.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2018-06-27 14:23:26
#########################################################################
#set -e
#source ./config

source_ip_port=$1
dest_ip_port=$2
multiple=10

CUR_DIR=$(cd `dirname $0`; pwd)
cd ${CUR_DIR}
RED='\e[1;91m'
GREN='\e[1;92m'
WITE='\e[1;97m'
NC='\e[0m'
f_yellow='\e[00;33m'
f_red='\e[00;31m'
f_green='\e[00;32m'
f_reset='\e[00;0m'

function p_warn {
    echo -e "${f_yellow}[wrn]${f_reset} ${1}"
}

function p_err {
    echo -e "${f_red}[err]${f_reset} ${1}"
}

function p_ok {
    echo -e "${f_green}[ok ]${f_reset} ${1}"
}
function start_procs()
{
    source_ip_port=$1
    dest_ip_port=$2
    [[ -z ${dest_ip_port} ]] && p_err "not found dest_ip_port" && exit 1

    dest_ip=$(echo ${dest_ip_port} | awk -F : '{print $1}')
    dest_port=$(echo ${dest_ip_port} | awk -F : '{print $2}')
    cept_status=$(ssh root@${dest_ip} "ls -l | grep tcp_copy|wc -l")
    if [[ "w${cept_status}" == "w0" ]]
    then
        scp -qr ./tcp_copy root@${dest_ip}:~
    fi
    cept_status=$(ssh root@${dest_ip} "ps -ef | grep intercept | grep -v grep | wc -l")
    if [[ "w${cept_status}" == "w0" ]]
    then
        ssh root@${dest_ip} "bash /root/tcp_copy/cept.sh start ${dest_port}"
    fi


    [[ -z ${source_ip_port} ]] && p_err "not found source_ip_port" && exit 1
    [[ -z ${multiple} ]] && p_err "not found multiple" && exit 1
    source_ip=$(echo ${source_ip_port} | awk -F : '{print $1}')
    source_port=$(echo ${source_ip_port} | awk -F : '{print $2}')
    copy_status=$(ssh root@${source_ip} "ls -l | grep tcp_copy|wc -l")
    if [[ "w${copy_status}" == "w0" ]]
    then
        scp -qr ./tcp_copy root@${source_ip}:~
    fi
    ssh root@${source_ip} "bash /root/tcp_copy/copy.sh start ${source_port} ${dest_ip} ${dest_port} ${multiple}"
}

function copy_status_procs()
{
    source_ip_port=$1
    [[ -z ${source_ip_port} ]] && p_err "not found source_ip_port" && exit 1
    source_ip=$(echo ${source_ip_port} | awk -F : '{print $1}')
    source_port=$(echo ${source_ip_port} | awk -F : '{print $2}')
    copy_status=$(ssh root@${source_ip} "ls -l | grep tcp_copy|wc -l")
    if [[ "w${copy_status}" == "w0" ]]
    then
        scp -qr ./tcp_copy root@${source_ip}:~
    fi
    ssh root@${source_ip} "bash /root/tcp_copy/copy.sh status"
}
function copy_stop_procs()
{
    source_ip_port=$1
    [[ -z ${source_ip_port} ]] && p_err "not found source_ip_port" && exit 1
    source_ip=$(echo ${source_ip_port} | awk -F : '{print $1}')
    source_port=$(echo ${source_ip_port} | awk -F : '{print $2}')
    copy_status=$(ssh root@${source_ip} "ls -l | grep tcp_copy|wc -l")
    ssh root@${source_ip} "bash /root/tcp_copy/copy.sh stop"
}
function cept_status_procs()
{
    dest_ip_port=$1
    [[ -z ${dest_ip_port} ]] && p_err "not found dest_ip_port" && exit 1
    dest_ip=$(echo ${dest_ip_port} | awk -F : '{print $1}')
    dest_port=$(echo ${dest_ip_port} | awk -F : '{print $2}')
    copy_status=$(ssh root@${dest_ip} "ls -l | grep tcp_copy|wc -l")
    if [[ "w${copy_status}" == "w0" ]]
    then
        scp -qr ./tcp_copy root@${source_ip}:~
        sleep 3
    fi
    ssh root@${dest_ip} "bash /root/tcp_copy/cept.sh status"
}
function cept_stop_procs()
{
    dest_ip_port=$1
    [[ -z ${dest_ip_port} ]] && p_err "not found dest_ip_port" && exit 1
    dest_ip=$(echo ${dest_ip_port} | awk -F : '{print $1}')
    dest_port=$(echo ${dest_ip_port} | awk -F : '{print $2}')
    copy_status=$(ssh root@${dest_ip} "ls -l | grep tcp_copy|wc -l")
    ssh root@${dest_ip} "bash /root/tcp_copy/cept.sh stop"
}

MODE=${1}
source_ip_port=${2}
dest_ip_port=${3}
case ${MODE} in
    "start")
        start_procs $source_ip_port $dest_ip_port
        ;;

    "copy_stop")
        copy_stop_procs $source_ip_port
        ;;

    "copy_status")
        copy_status_procs $source_ip_port
        ;;
    "cept_stop")
        cept_stop_procs $source_ip_port
        ;;

    "cept_status")
        cept_status_procs $source_ip_port
        ;;
    
    *)
        # usage
        echo -e "\nUsage: $0 {start|stop|restart|status}"
        echo -e ${WITE}" start  source_ip_port dest_ip_port "${NC}"Start $DISP_NAME processes."
        echo -e ${WITE}" copy_stop    source_ip_port "${NC}"Kill all $DISP_NAME processes."
        echo -e ${WITE}" copy_status  source_ip_port "${NC}"Show $DISP_NAME processes status."
        echo -e ${WITE}" cept_stop    dest_ip_port "${NC}"Kill all $DISP_NAME processes."
        echo -e ${WITE}" cept_status  dest_ip_port "${NC}"Show $DISP_NAME processes status.\n"
        exit 1
        ;;
esac
