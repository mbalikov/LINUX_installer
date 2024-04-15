#!/bin/bash


LOG "=========================================================";
LOG "===== INSTALL NGINX/OPENRESTY";
LOG "=========================================================";

LOG  "\n\t remove/disable nginx if installed";
systemctl stop nginx | tee $LOG_FILE 2>&1
systemctl disable nginx | tee $LOG_FILE 2>&1

LOG  "\n\t download nginx/openresty public key";
EXEC "wget -O /tmp/openresty-pubkey.gpg https://openresty.org/package/pubkey.gpg"
output=$(cat /tmp/openresty-pubkey.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/openresty.gpg)
if (( $? != 0 ))
then
        DIE "GPG failed: ${output}"
fi

LOG  "\n\t set up apt source";
codename=`grep -Po 'VERSION="[0-9]+ \(\K[^)]+' /etc/os-release`
echo "deb http://openresty.org/package/debian ${codename} openresty" | tee /etc/apt/sources.list.d/openresty.list
#echo "deb http://openresty.org/package/debian bullseye openresty" | tee /etc/apt/sources.list.d/openresty.list

LOG  "\n\t install nginx/openresty";
EXEC "apt-get -y update"
EXEC "apt-get -y install openresty"

EXEC "mkdir /var/www/"
EXEC "chown -R www-data:www-data /var/www"

