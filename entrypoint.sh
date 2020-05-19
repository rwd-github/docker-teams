#!/bin/bash

# locale
locale-gen ${TEAMS_LOCALE}
update-locale LANG=de_DE.UTF-8

# timezone
if [ -f /etc/localtime ]; then rm /etc/localtime; fi
if [ -h /etc/localtime ]; then rm /etc/localtime; fi
ln -s /usr/share/zoneinfo/${TEAMS_TIMEZONE} /etc/localtime

cd /root
if [ -f "createuser.sh" ]; then
	./createuser.sh
fi

cd /home/${TEAMS_USERNAME}
if [ "$1" == "--debug" ]; then
	su -c "/usr/bin/xterm &" ${TEAMS_USERNAME}
else
	su -c teams ${TEAMS_USERNAME}
fi

# Stop script
stop_script() {
	echo "killing teams ..."
	pkill --signal SIGINT teams
	exit 0
}
# Wait for supervisor to stop script
trap stop_script SIGINT SIGTERM SIGKILL

while true
do
    #uptime
    sleep 10
	if [ "$1" == "--debug" ]; then
		echo "to stop container: CTRL-C or docker stop ..."
	else
		pgrep teams > /dev/null || exit 0
	fi
done
