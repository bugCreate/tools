#!/usr/bin/env bash
# 收集java 必要的debug 信息
PID=$1
if test -z "$PID"; then
    echo "pid parameter is missing"
    exit 1
fi
echo "start collect info on pid" ${PID}
DIR_NAME="java-collect-${PID}"
echo ${DIR_NAME}
mkdir -p ${DIR_NAME}
echo "start collect jstack info.."
jstack -l ${PID} > ${DIR_NAME}/jstack.log

echo "start collect gc info...."
jstat -gc ${PID} 1000 20 > ${DIR_NAME}/gc.log
jstat -gccause ${PID} > ${DIR_NAME}/gccause.log

echo "start collect dump  info..."
jmap -dump:format=b,file=${DIR_NAME}/heapdump ${PID}