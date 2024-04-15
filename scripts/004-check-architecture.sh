#!/bin/bash

LOG "=========================================================";
LOG "===== Check CPU architecture for amd64"
LOG "=========================================================";

arch=`dpkg --print-architecture`
LOG "Architecture: ${arch}"

if [[ $arch != "amd64" ]]
then
	DIE "wrong architecture ${arch} : expecting amd64"
fi

