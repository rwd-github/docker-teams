#!/bin/bash

teams
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
