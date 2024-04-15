#!/bin/bash

LOG "=========================================================";
LOG "===== Check if running as root"
LOG "=========================================================";

uid=`id -u`
LOG "User id : ${uid}"

if (( ${uid} != 0 ))
then
	DIE "not root";	
fi

EXEC "chown -R root:root ${RESOURCE_PATH}"