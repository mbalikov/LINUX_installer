#!/bin/bash


LOG "========================================================="
LOG "===== Update Linux OS"
LOG "========================================================="

EXEC "apt-get -y update"
EXEC "apt-get -y full-upgrade"

