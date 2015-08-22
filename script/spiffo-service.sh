#!/bin/bash

#### PZ SERVER  ####################################################
PZ_USER="pz-server1"				# server name
PZ_ADMIN_PASSWORD="admin"			# admin account password ( needed on first start )
PZ_RESTART_AND_STOP_COUNTER=10 		


### STEAM ACCOUNT ###################
STEAM_ACCOUNT="anonymous"	# anonymous steam account
STEAM_PASS=""				# left empty for anonymous account
STEAM_APP_ID=380870			# steam game appid: server files=380870 / client files=108600 (your account & pass is required)

#############################################################################################################
#	Script by Nightmare @ http://n8m4re.de																	#
#																											#
#									PLEASE DON'T CHANGE SOMETHING BELOW!									#
#																											#
#############################################################################################################

_header_init() {
	clear
	echo ''
	echo -e "\e[38;5;208m++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0;0m ${1}"
	echo -e "\e[38;5;208m+++                                                        +++\e[0;0m ${1}"
	echo -e "\e[38;5;208m+++                                                        +++\e[0;0m ${1}"
	echo -e "\e[38;5;208m+++    Welcome to Spiffo's Zomboid Server Service Center   +++\e[0;0m ${1}"
	echo -e "\e[38;5;208m+++    by Nightmare @ http://n8m4re.de                     +++\e[0;0m ${1}"
	echo -e "\e[38;5;208m+++                                                        +++\e[0;0m ${1}"
	echo -e "\e[38;5;208m+++                                                        +++\e[0;0m ${1}"
	echo -e "\e[38;5;208m++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[0;0m ${1}"
	_spiffo
	_server_info
}

_spiffo(){
cat <<"EOT"
                    -.`
         .--:::--::://o+
         /::s/---------:+
          oo---/syo:::odh+`
         .yo/:/yyss:-ss:-`/
        /:ss+/-````../:.-o.
       smmyyyo+::::/:::+ymh
   -+osdmdyyyyyyoo+++/://+
  `hhmmysdmhyys+:-------+.
   smmhshNNdys+/---------/`
   `omhydNmhyo+/:---------+
    `:o/+mhyyo+////:::-:smmh:
 -:++::-dhyyyysoooo++//dNmmm:
 `+:::.omNddhyso+//+oyyNNmNo
        .-/.          -/+/.

EOT
}

_spiffo_says() {
  echo ''
  echo -e "\e[1;38;5;208m*** Spiffo says:\e[0;0m ${1}\n"
}

spiffo_answer=""
_spiffo_request(){
local answer=""

  if [ "${spiffo_answer}" = "yes" ]; then
	echo -e "\e[1;38;5;208m*** Spiffo asks:\e[0;0m ${1} (yes/no) yes"
    return 0
  elif [ "${spiffo_answer}" = "no" ]; then
    echo -e "\e[1;38;5;208m*** Spiffo asks:\e[0;0m ${1} (yes/no) no"
    return 1
  fi

  while true
  do
    echo -n -e "\e[1;38;5;208m*** Spiffo asks:\e[0;0m ${1} (yes/no) "
    if read -e answer
    then

      if [ "X${answer}" = "Xyes" ]; then
        return 0
      fi

      if [ "X${answer}" = "Xno" ]; then
        return 1
      fi

    else
		_spiffo_says "Quitting.\n"; sleep 1
		_menu_init
		exit 1
    fi
  done
}

_menu_init() {

	_header_init

	_spiffo_says "What should i do? Please enter a number. "

	local options=("Install" "Update" "Start" "Restart" "Save-Stop" "Hard-Stop" "Command-Menu" "Exit")
	select opt in "${options[@]}"
	do
	case ${opt} in
		"Install")		_installer_init ;;
		"Update") 		_zomboid_install_init ;;
		"Start") 		_server_init_start ;;
		"Restart") 		_server_init_restart ;;
		"Save-Stop") 	_server_init_save_stop ;;
		"Hard-Stop") 	_server_init_hard_stop ;;
		"Command-Menu") _admin_command_menu_init ;;
		"Exit") clear; 	_spiffo; _spiffo_says "Goodbye and have a nice day!"; exit 0 ;;
			*) 			_spiffo_says 'invalid option'; sleep 2; _menu_init ;;
	esac
	done

}

_serverMsg(){
	local input=""
	_spiffo_says "now write your message and hit enter: "; sleep 2
	while read -e input && [ -z "${input}" ]; do :; done
	_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"servermsg ${input}\"\015'"
	_spiffo_says "done."; sleep 1
	_admin_command_menu_init
}

#_addUser(){
#	local input1=""
#	local input2=""
#	_spiffo_says "please enter a username: "; sleep 1
#	while read -e input1 && [ -z "${input1}" ]; do :; done
#	_spiffo_says "please enter a password: "; sleep 1
#	while read -e input2 && [ -z "${input2}" ]; do :; done
#	_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"adduser ${input1} ${input2} \"\015'"
#	_spiffo_says "user: ${input1} added, done."; sleep 1
#	_admin_command_menu_init
#}

_saveWorld(){
	_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"save\"\015'"
	_spiffo_says "done."; sleep 1
	_admin_command_menu_init
}

_gunShot(){
	_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"gunshot\"\015'"
	_spiffo_says "peng peng, ..done."; sleep 1
	_admin_command_menu_init
}

_thunder(){
	_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"thunder\"\015'"
	_spiffo_says "BAAABAAABBOOOOMMM, ..done."; sleep 1
	_admin_command_menu_init
}

_chooper(){
	_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"chooper\"\015'"
	_spiffo_says "whop-whop-whop-whop, ..done."; sleep 1
	_admin_command_menu_init
}

_stopRain(){
	_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"stoprain\"\015'"
	_spiffo_says "done."; sleep 1
	_admin_command_menu_init
}

_startRain(){
	_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"stoprain\"\015'"
	_spiffo_says "done."; sleep 1
	_admin_command_menu_init
}

_reloadoptions(){
	_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"reloadoptions\"\015'"
	_spiffo_says "done."; sleep 1
	_admin_command_menu_init
}

_addalltowhitelist(){
	_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"addalltowhitelist\"\015'"
	_spiffo_says "done."; sleep 1
	_admin_command_menu_init
}

_admin_command_menu_init(){
	_header_init
	_spiffo_says "Please select a command:"
	local options=("Write Message" "Save World" "Reload Options" "AddAllToWhiteList" "Stop Rain" "Start Rain" "Gun Shot" "Thunder" "Chooper"   "Back to main")
	select opt in "${options[@]}"
	do
	case ${opt} in
		"Write Message")		_serverMsg ;;
		"Save World")			_saveWorld ;;
		#"Add User")			_addUser ;;
		"Reload Options")		_reloadoptions ;;
		"AddAllToWhiteList")	_addalltowhitelist ;;	
		"Stop Rain")			_stopRain ;;	
		"Start Rain")			_startRain ;;	
		 "Gun Shot")			_gunShot ;;
		"Thunder")				_thunder ;;
		"Chooper")				_chooper ;;
		"Back to main") clear; _menu_init ;;
		*) _spiffo_says 'invalid option'; sleep 1; _admin_command_menu_init ;;
		esac
	done
}

_java_install_init() {

			_header_init

			_spiffo_says 'Looking for Java..'; sleep 1
			
			local JAVA_INSTALLED=$(type java -version 2>/dev/null)
		
		if [ "$JAVA_INSTALLED" ]; then
			local VER=`java -version 2>&1 | grep "java version" | awk '{print $3}' | tr -d \" | awk '{split($0, array, ".")} END{print array[2]}'`	
			if [ ! $VER == 8 ]; then
				_spiffo_says 'Java 7 is installed, but we need Java 8!'; sleep 3
				_spiffo_says 'DeInstall oracle-java7 ...'; sleep 2
				apt-get -y --purge autoremove oracle-java7-installer
				apt-get -y --purge autoremove oracle-java7-set-default
				echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main' | tee /etc/apt/sources.list.d/webupd8team-java.list
				echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main' | tee -a /etc/apt/sources.list.d/webupd8team-java.list
				apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
				apt-get update
				apt-get -y install oracle-java8-installer
				apt-get -y install oracle-java8-set-default
				
			fi
		fi 	
			
		if [ ! "$JAVA_INSTALLED" ]; then
			_spiffo_says 'Damn java is not installed!'; sleep 3
			#_spiffo_says 'Installing oracle-java7 ...'; sleep 2
			_spiffo_says 'Installing oracle-java8 ...'; sleep 2
			echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main' | tee /etc/apt/sources.list.d/webupd8team-java.list
			echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main' | tee -a /etc/apt/sources.list.d/webupd8team-java.list
			apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
			apt-get update
			#apt-get -y install oracle-java7-installer
			apt-get -y install oracle-java8-installer
			#apt-get -y install oracle-java7-set-default
			apt-get -y install oracle-java8-set-default

			_java_install_init
	else

			_spiffo_says 'Java is installed.'; sleep 2
			
			return 1
	fi
}


_server_info(){

		echo -e "\e[1;38;5;208m SYS: ${DIST_DESC} ${CODNAME} \e[0;0m ${1}"
		echo ''
	if ( _server_running ) then
	
		local PID=$( lsof -i  | grep -v grep | grep -i "${PZ_USER}" | awk '{print $2}' | head -1 )
		
		local CPU=$( ps S -p ${PID} -o pcpu= )
		
		local MEM1=$( ps S -p ${PID} -o pmem= )
		
		local MEM2=$( ps -ylp ${PID} | awk '{x += $8} END {print "Memory Usage (MB): " x/1024;}' )
	
		echo -e "\e[1;38;5;208m Running: ${PZ_USER} \e[0;0m ${1}"
		
		echo -e "\e[1;38;5;208m Pid: ${PID} \e[0;0m ${1}"
		
		echo -e "\e[1;38;5;208m Cpu Usage (%): ${CPU} \e[0;0m ${1}"
		
		echo -e "\e[1;38;5;208m Memory Usage (%): ${MEM1} \e[0;0m ${1}"
		
		echo -e "\e[1;38;5;208m ${MEM2} \e[0;0m ${1}"
		
		echo ''
	fi
}

_server_running() {
	if [ ! -n "$(lsof -i  | grep -v grep | grep -i "${PZ_USER}" | awk '{print $2}' | head -1)" ];
	then
		return 1
	else
		return 0
	fi
}


		
_killServerPid(){
		
	if ( _server_running ) then	
		local PID1=$( ps aux | grep -v grep | grep -i "screen -A -m -d -L -S ${PZ_USER}" | awk '{print $2}' )
		local PID2=$( lsof -i  | grep -v grep | grep -i "${PZ_USER}" | awk '{print $2}' )
		
		if [ -n ${PID1} ]; then
			for pid1 in ${PID1};
				do
				kill ${pid1}
			done
		fi
		
		sleep 1
	
		for pid2 in ${PID2};
			do
			kill -9 ${pid2}
		done
	fi
}


_PZUserExec() {
   su - ${PZ_USER} -c "$1" > /dev/null
}
   
_SteamUserExec() {
   su - ${STEAM_USER} -c "$1"
}

_sendMessageAndQuit() {

	local x=1
	local y=${PZ_RESTART_AND_STOP_COUNTER}
		
			_spiffo_says "${2}";
			
			 _PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"servermsg ${2} \"\015'"
			 
			sleep 3
		
			while [ ${y} -ge 0 ]
			do
					_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"servermsg ${y} \"\015'"
					_spiffo_says "${y}";
					sleep 2
					y=$(( ${y} - 1 ))
					
			done
				_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"servermsg ..bye bye \"\015'"
				
			sleep 0.5
			
				_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"quit\"\015'"
			
			while [ ${x} -le 20 ]
			do
				if ( ! _server_running ) then 
					break 
				fi		
				echo -n '. ';	
				sleep 1	
				x=$(( ${x} + 1 ))
			done

		if [ ${x} -lt 20 ]; then

			 if [ "${1}" == "stop" ]; then 
				_spiffo_says "${PZ_USER} is down.."; sleep 1
				break
				return 1
			 fi 
			 
			 if [ "${1}" == "restart" ]; then 
				_spiffo_says "${PZ_USER} is restarting.."; sleep 1
				break
				return 1
			 fi
			 
		else
			_spiffo_says "${PZ_USER} is still running, please try hard-stop."; sleep 1

			_spiffo_says "back to main menu, please press enter.";

			read
			
			_menu_init
	 fi
}


_server_init_restart() {
	
	_header_init
	
	if (_spiffo_request "restart ${PZ_USER} now?"); then	
	
		if (  _server_running ) then
		
				_spiffo_says "prepare to restart of ${PZ_USER} ..";
		
				if ( _sendMessageAndQuit "restart" "server will restart in.." ); then 
					
					if [ -f ${PZ_DIR}/screenlog.0 ]; then
						rm ${PZ_DIR}/screenlog.0;
					fi
					
					_PZUserExec "screen -wipe"
					
					_PZUserExec "cd ${PZ_DIR}; screen -A -m -d -L -S ${PZ_USER} ./start-server.sh"; sleep 1
					
					_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"${PZ_ADMIN_PASSWORD}\"\015'"; sleep 0.1
					
					_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"${PZ_ADMIN_PASSWORD}\"\015'"; sleep 0.1
				
					_spiffo_says "back to main menu, please press enter.";
					
					read
					
					_menu_init
			 fi
		
		else

			_spiffo_says "ooops, there is nothing to restart..!?"; sleep 1

			_spiffo_says "back to main menu, please press enter.";
				
			read

			_menu_init
		fi
		
	else
		_menu_init
	fi
	
}

_server_init_start(){

			_header_init

	if (_spiffo_request "start ${PZ_USER} now?"); then

			if ( ! _server_running ) then

				if [ -f ${PZ_DIR}/screenlog.0 ]; then
					rm ${PZ_DIR}/screenlog.0;
				fi
				
				_PZUserExec "screen -wipe"
				
				_PZUserExec "cd ${PZ_DIR}; screen -A -m -d -L -S ${PZ_USER} ./start-server.sh"; sleep 1
				
				_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"${PZ_ADMIN_PASSWORD}\"\015'"; sleep 0.1
				
				_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"${PZ_ADMIN_PASSWORD}\"\015'"; sleep 0.1
				
				_spiffo_says "${PZ_USER} is starting.."; sleep 0.8

				_spiffo_says "back to main menu, please press enter.";

				read

				_menu_init

			else

				_spiffo_says "${PZ_USER} is already running.."; sleep 1

				_spiffo_says "back to main menu, please press enter.";

				read

				_menu_init
			fi

		else
			_menu_init
		fi
}

_server_init_hard_stop(){

				_header_init

		if (_spiffo_request "hard-stop ${PZ_USER} now?"); then

				_killServerPid

				sleep 1
				
				if ( ! _server_running ) then

					_spiffo_says "${PZ_USER} is down now.."; sleep 1

					_spiffo_says "back to main menu, please press enter.";

					read

					_menu_init
				fi
		else
			_menu_init
		fi
}

_server_init_save_stop(){

		_header_init
	
		if (_spiffo_request "save-stop ${PZ_USER} now?"); then

			if (  _server_running ) then
			
					_spiffo_says "prepare to stopping of  ${PZ_USER} .."
					
				if ( _sendMessageAndQuit "stop" "server will shutdown in.." ); then
				
					_spiffo_says "back to main menu, please press enter.";	
					
					read
					
					_menu_init
				fi
				
			else 
				_spiffo_says "ooops, there is nothing to stop..!?"; sleep 1

				_spiffo_says "back to main menu, please press enter.";
					
				read

				_menu_init
			fi
			
		else
			_menu_init
		fi
}

_zomboid_install_init(){

	_header_init

if [ "$(getent passwd ${STEAM_USER})" ] && [ "$(getent passwd ${PZ_USER})" ]; then

	if [ ! -d "${PZ_DIR}" ]; then
		mkdir ${PZ_DIR}
	fi
	
	chmod -R 0777 ${PZ_DIR}

	if ( _server_running ) then

			_spiffo_says 'running server detected. will be stopping..'; sleep 1

			_PZUserExec "screen -p 0 -S ${PZ_USER} -X eval 'stuff \"quit\"\015'"

			sleep 1
			
			_killServerPid
	fi


	if [ -d "${PZ_DIR}/Zomboid" ]; then

		_spiffo_says 'Please wait, make a backup from configs && world...'; sleep 1

		BF="Zomboid_`date +%F`-`date +%k%M`"

		cp -R ${PZ_DIR}/Zomboid .

		tar cfvz "${BF}".tar.gz Zomboid

		mv "${BF}".tar.gz ${PZ_DIR}

		rm -R Zomboid

		_spiffo_says 'backup done. please press enter to continue..'; sleep 1

		read
	fi

		_header_init

		_spiffo_says 'Please select a version of Zomboid to install/update?';

		local options=("STABLE" "IWBUMS (BETA)")
		select opt in "${options[@]}"
		do
		case ${opt} in

			 "STABLE")

			 if (_spiffo_request "Do you want to install STABLE now?"); then

				_spiffo_says 'Installing PZ - STABLE...'; sleep 2

				_SteamUserExec "cd ${STEAM_DIR}; ./steamcmd.sh +login ${STEAM_ACCOUNT} ${STEAM_PASS} +force_install_dir ${PZ_DIR} +app_update ${STEAM_APP_ID} -beta public validate +quit"

				chown -Rh ${PZ_USER} ${PZ_DIR}

				chmod -R 0775 ${PZ_DIR}

				_spiffo_says "puuh.. i'm done. PZ - STABLE Server is installed now..."; sleep 4

				_spiffo_says "back to main menu, please press enter.";

				read

				_menu_init

			else
				_zomboid_install_init
			fi

			;;

			"IWBUMS (BETA)")

			if (_spiffo_request "Do you want to install IWBUMS (BETA) now?"); then

				_spiffo_says 'Installing PZ - IWBUMS (BETA)...'; sleep 2

				_SteamUserExec "cd ${STEAM_DIR}; ./steamcmd.sh +login ${STEAM_ACCOUNT} ${STEAM_PASS} +force_install_dir ${PZ_DIR} +app_update ${STEAM_APP_ID} -beta iwillbackupmysave -betapassword iaccepttheconsequences validate +quit"

				chown -Rh ${PZ_USER} ${PZ_DIR}

				chmod -R 0775 ${PZ_DIR}

				_spiffo_says "puuh.. i'm done. PZ - IWBUMS (BETA) Server is installed now..."; sleep 4

				_spiffo_says "back to main menu, please press enter.";

				read

				_menu_init

			else
				_zomboid_install_init
			fi
			;;

			*)
				_spiffo_says 'invalid option';
			;;
			esac
	done

else
	_spiffo_says "sorry! ${STEAM_USER} or ${PZ_USER} has no account on this system. press enter and try install..."
	
	read
	
	_menu_init
fi

}


_installer_init() {

	if (_spiffo_request "Do you want to install now?"); then

			if [ "$(uname -m | grep 'x86_64')" ] && [ ! "$(dpkg --list | grep 'lib32gcc1')" ]; then

				_spiffo_says "Please wait, installing lib32gcc1..."; sleep 2

				if [ ${CODNAME} == "jessie" ]; then  
					dpkg --add-architecture i386
					apt-get update
				fi

				apt-get -y install lib32gcc1
			fi
			
	
			_java_install_init
			

			if [ ! "$(getent passwd ${STEAM_USER})" ]; then

				_spiffo_says 'Creating an unix account for SteamCMD'; sleep 2

				if [ "$(getent group ${STEAM_USER})" ]; then

						useradd ${STEAM_USER} -g ${STEAM_USER}

					else
						useradd ${STEAM_USER}
				fi

						usermod ${STEAM_USER} -L  -d ${STEAM_DIR} -s /bin/bash

				_spiffo_says "Account: ${STEAM_USER} created"; sleep 2
			fi


			if [ ! -d "${STEAM_DIR}" ]; then
				mkdir ${STEAM_DIR}
			fi


			if [ ! -e "${STEAM_DIR}/steamcmd_linux.tar.gz" ]; then

				_spiffo_says 'Starting download SteamCMD from "media.steampowered.com"'; sleep 2

				cd ${STEAM_DIR}

				wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz

				_spiffo_says "Extracting SteamCMD ..."; sleep 2

				tar -xvzf steamcmd_linux.tar.gz
			fi

			chown -Rh ${STEAM_USER} ${STEAM_DIR}


			_header_init

			if [ ! "$(getent passwd ${PZ_USER})" ]; then

				_spiffo_says 'Creating an unix account for Project Zomboid'; sleep 2

				if [ "$(getent group ${PZ_USER})" ]; then
				
					useradd ${PZ_USER} -g ${PZ_USER}

					else

					useradd ${PZ_USER}
				fi

					usermod ${PZ_USER} -L  -d ${PZ_DIR} -s /bin/bash

				_spiffo_says "Account: ${PZ_USER} created"; sleep 2
			fi

			if [ ! -d "${PZ_DIR}" ]; then
			
				mkdir ${PZ_DIR}
				
			fi

			chown -Rh ${PZ_USER} ${PZ_DIR}

			_spiffo_says 'Checking SteamCMD..'; sleep 2

			_SteamUserExec "cd ${STEAM_DIR};./steamcmd.sh +login ${STEAM_ACCOUNT} ${STEAM_PASS} +exit"

			_zomboid_install_init

	else

		_menu_init
	fi
}


_run() {

	clear

	if [ "$(id -u)" != "0" ]; then

	   _spiffo_says 'This script must be run as root'

	   exit 1
	fi


	if [ ! "$(type lsb_release -a 2>/dev/null)" ]; then

		_spiffo_says 'lsb-release is not installed. Installing...'; sleep 2

		apt-get -y install lsb-release

		_spiffo_says 'lsb-release is now installed.'; sleep 2
	fi

	local STEAM_USER="steam"

	local PZ_DIR="/home/${PZ_USER}"

	local STEAM_DIR="/home/${STEAM_USER}"

	local DIST_ID=$(lsb_release -a 2>/dev/null | grep "Distributor ID" | cut -d: -f2)

	local DIST_ID=$(echo $DIST_ID | sed 's/^ *//')

	local DIST_DESC=$(lsb_release -a 2>/dev/null | grep "Description" | cut -d: -f2)

	local DIST_DESC=$(echo $DIST_DESC | sed 's/^ *//')

	local CODNAME=$(lsb_release -a 2>/dev/null | grep "Codename" | cut -d: -f2)

	local CODNAME=$(echo $CODNAME | sed 's/^ *//')

	if [ ${DIST_ID} == "Debian" ]; then	
		if [ ${CODNAME} != "jessie" ]; then
			_spiffo_says "Your system is: ${DIST_ID} ${CODNAME} , but Debian 8 Jessie is required!"
			exit 1
		 fi
	fi

	if [ ! "$(type screen 2>/dev/null)" ]; then
		_header_init

		_spiffo_says 'Screen is not installed. Installing...'; sleep 2

		apt-get -y install screen

		_spiffo_says 'Screen is now installed.'; sleep 2

		_header_init
	fi

	_menu_init
}

_run