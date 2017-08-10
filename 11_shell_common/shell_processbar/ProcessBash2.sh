#!/bin/bash

######################## --------------variable--------------###############
g_SEQ_PROGRESSBAR=0

# You may need to change the variable
g_SUM_PROGRESSBAR=10

g_START_TIME=`date +%s`;

######################## --------------function--------------###############
#{{{ProcessBar
function ProcessBar()
{
	local A_SP  PER N_SP
	# The total lenght of the bar
	A_SP=50;
	g_SEQ_PROGRESSBAR=`expr ${g_SEQ_PROGRESSBAR} + 1`
	PER=$(echo "($g_SEQ_PROGRESSBAR)/${g_SUM_PROGRESSBAR}*100"|bc -l);
	N_SP=$(echo "$PER*$A_SP/100"|bc);
	printf "\r[Process]:\033[45m%${N_SP}s\033[00m%$[A_SP-N_SP]s%.2f%%" "" "" $PER;
	
	TIME_ELAPSE_M=$[(`date +%s`-g_START_TIME)/60];
	TIME_ELAPSE_S=$[(`date +%s`-g_START_TIME)%60];
	echo -n "Time:${TIME_ELAPSE_M} m ${TIME_ELAPSE_S} s";
	sleep 0.1;
}
#}}}
#{{{main
function main
{
	echo "Testing..."
	ProcessBar
	ProcessBar
	ProcessBar
	ProcessBar
	ProcessBar
	ProcessBar
	ProcessBar
	ProcessBar
	ProcessBar
	ProcessBar
	echo
}
#}}}
main
