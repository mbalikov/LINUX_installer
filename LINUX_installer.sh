#!/bin/bash

# ===============================================
# Default config
###
INSTALL=0
YES=0
SCRIPTS_PATH="./scripts";
RESOURCE_PATH="./resources";

USER="www-data";
HOSTNAME=`hostname`;

LOG_FILE="linux_installer_$(date +%Y%m%d%H%M%S).log";

# ===============================================

function USAGE() {
cat << EOF
Usage: ./AMY_install.sh --install [--yes] [--scripts_path=PATH] [--resource_path=PATH] [--user=USERNAME] [--host=HOSTNAME] [--log=FILENAME]

--install		Mandatory keyword to start installation

--yes			Apply default values and don't stop between scripts

--scripts_path PATH	Where to look for scripts to execute, default: ./scripts

--resource_path PATH	Where to look for scripts resources, default: ./resources

--user USERNAME		Default, default: www-data

--hostname HOSTNAME	Hostname to use in the scripts, default: servers name

--environment FILE	Load environment variables from file, default: ./env

--log FILENAME		Where to store installation logs, default: ./linux_installer_$(date +%Y%m%d%H%M%S).log

EOF
exit 0;
}
(( $# == 0 )) && USAGE;

## Parse cli arguments
while getopts ":h-:" ch; do
   if [[ $ch == "-" ]]
   then
	case "${OPTARG}" in
   		install)
   			INSTALL=1
   			;;
		yes)
			YES=1
			;;
		scripts_path)
			SCRIPTS_PATH="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
			;;
		resource_path)
			RESOURCE_PATH="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
			;;
		user)
			USER="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
			;;
		hostname)
			HOSTNAME="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
			;;
		environment)
			ENV_FILE="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
			;;
		log)
			LOG_FILE="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
			;;
		*)
			#USAGE
			USAGE
			exit 0
			;;
	esac
   else
   	USAGE
   	exit 0
   fi
done

# ===============================================
function LOG () {
	msg="$*"
	printf "${msg}\n" >> $LOG_FILE
	printf "${msg}\n"
}
function DIE () {
	msg="$*"
	printf "\n\n !!! DIE: ${msg}" >> $LOG_FILE
	printf "\n\n !!! DIE: ${msg}"
	exit 1
}
function EXEC () {
	cmd="$*";
	LOG "\nEXEC: ${cmd}\n";
	
	$cmd >> $LOG_FILE 2>&1
	if (( $? != 0 )) 
	then
		DIE "command failed! stop!\n"
	fi
	printf "\n" >> $LOG_FILE
}
# ===============================================

## Load env file
if [[ -f ENV_FILE ]]; then
	set -a;
	source ENV_FILE;
	set +a;
fi

# ===============================================

LOG "========================================\n";
LOG "========== LINUX INSTALLER =============\n";
LOG "========================================\n";
LOG "Output and errors will be logged into ${LOG_FILE}\n";
LOG "\n";

LOG "========== options:"
LOG "INSTALL=${INSTALL}"
LOG "YES=${YES}";
LOG "SCRIPTS_PATH=${SCRIPTS_PATH}";
LOG "RESOURCE_PATH=${RESOURCE_PATH}";
LOG "USER=${USER}";
LOG "HOSTNAME=${HOSTNAME}";
LOG "LOG_FILE=${LOG_FILE}";
LOG "==============\n"

mkdir DONE 2>&1 > /dev/null

LOG "Execute scripts into ${SCRIPTS_PATH}";
for src in `ls -1 ${SCRIPTS_PATH}`
do
	LOG "\n\n>>>>>>>>>>>> SCRIPT: ${src} <<<<<<<<<<<<<<<<";
	if (( $YES != 1 ))
	then
		LOG "Continue?"; read;
	fi

	source "${SCRIPTS_PATH}/$src"
	mv "${SCRIPTS_PATH}/$src" DONE/
done
