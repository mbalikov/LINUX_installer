#!/bin/bash

LOG "========================================================="
LOG "===== APT INSTALL Linux tools";
LOG "========================================================="

declare -a tools=(
	"apt-transport-https"
	"ca-certificates"
	"libnuma-dev"
	"numactl"
	"apache2-utils"
	"unzip"
	"wget"
	"gnupg"
	"curl"
	"joe"
	"jq"
	"lz4"
	"systemd-coredump"
	"net-tools"
	"sudo"
	"htop"
	"psmisc"
	"sysstat"
	"cpulimit"
	"linux-cpupower"
	"lsb-release"
	"ethtool"
	"dnsutils"
	"gdb"
	"openvpn"
	"ffmpeg"
	"php-cli"
	"php-zip"
	"php-curl"
	"php-json"
	"php-fpm"
	"resolvconf"
);
for t in ${tools[*]}
do
	EXEC "apt-get -y install ${t}"
done

LOG "Add temporary static nameservers into /etc/resolv.conf"
echo "nameserver 1.1.1.1"  > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

