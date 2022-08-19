#!/bin/bash

THIS_SCRIPT_PATH=$(dirname $(readlink -f $0))
#echo "$THIS_SCRIPT_PATH"

source ${THIS_SCRIPT_PATH}/install_help

function help()
{
	echo_info " "
	echo_info "Usage: build_allinone -I"
	echo_info " "
	echo_info "Options:"
	echo_info "Mandatory arguments to long options are mandatory for short options too."
	echo_info "  -I, --install-deps                      Check installed software necessary to build and run Docker."
	echo_info "  -h, --help                              Print this help."
	echo_info " "
}

function main()
{
	if [ $# -lt 1 ]; then
		echo_error "$0 \"-h\" Or \"--help\""
	fi

	until [ -z "$1" ]
    	do
    	case "$1" in
			-I | --install-deps)
			dv=$(docker -v)
			until [ "${dv:0:14}" = "Docker version" ]
			do
				apt-get update
				apt-get install -y docker.io
				dv=$(docker -v)
			done
			echo "already installed docker"

			#       install curl
			cv=$(curl -V)
			until [ "${cv:0:4}" = "curl" ]
			do
				apt-get install -y curl
				cv=$(curl -V)
			done
			echo "already installed curl"

			#       install docker-compose
			dcv=$(docker-compose --version)
			until [ ${dcv:23:6} == 1.28.2 ]
			do
			#	curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
				cp $THIS_SCRIPT_PATH/../libs/docker-compose /usr/local/bin/docker-compose
				chmod +x /usr/local/bin/docker-compose
				ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
				dcv=$(docker-compose --version)
			done
			echo "already installed docker-compose"
			shift
			;;
			-h | --help)
				help
				shift
				return 0
				;;
			*)
        		echo_error "Unknown option $1"
				help
        		return 1
        		;;
		esac
	done
}

main "$@"
