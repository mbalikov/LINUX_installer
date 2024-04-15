#!/bin/bash


LOG "========================================================="
LOG "===== Config SSHD";
LOG "========================================================="

LOG "\n\t append config to sshd_config"
cat ${RESOURCE_PATH}/sshd/sshd_config--append >> /etc/ssh/sshd_config
if (( $? != 0 ))
then
	DIE "sshd_config append failed"
fi

if [[ ! -d /root/.ssh ]]
then
	EXEC "mkdir /root/.ssh"
	EXEC "chmod 700 /root/.ssh"
fi
EXEC "cp ${RESOURCE_PATH}/sshd/authorized_keys /root/.ssh/"
EXEC "systemctl reload sshd"

