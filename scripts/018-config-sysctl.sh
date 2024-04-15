#!/bin/bash


LOG "========================================================="
LOG "===== Config SYSCTL"
LOG "========================================================="

cp ${RESOURCE_PATH}/sysctl-custom.conf /etc/sysctl.d/10-sysctl-custom.conf
if (( $? != 0 ))
then
	DIE "failed to install custom sysctl config"
fi

EXEC "sysctl --system"

