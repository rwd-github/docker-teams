#!/bin/bash

cd /root
if [ -f "createuser.sh" ]; then
	./createuser.sh
fi
myuser=$(cat /tmp/1stuser.txt)


cd /home/${myuser}
su -c teams ${myuser}
#/usr/bin/xterm &

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
	pgrep teams > /dev/null || exit 0
done
