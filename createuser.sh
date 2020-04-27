#!/bin/bash
set -o errexit -o pipefail -o nounset

echo "===  createuser start"
for myuser in $(ls /home); do
	echo "---  add user ${myuser}"
    if [ ! -f /tmp/1stuser.txt ]; then echo ${myuser} > /tmp/1stuser.txt; fi
	if [ ! $(id -u ${myuser}) ]; then
		adduser --disabled-password --no-create-home --gecos "" ${myuser}
		pushd /home/${myuser}
		if [ -f .mypass ]; then
			mypass=$(cat .mypass)

			#echo ${myuser}:${mypass} | chpasswd
			usermod -p "${mypass}" ${myuser}
		else
			echo " no password found"
		fi
		usermod -a -G adm ${myuser}
		usermod -a -G sudo ${myuser}

		chown -R ${myuser}:${myuser} .
		popd
	else
		echo "  user already exists."
	fi
done
echo "===  createuser stop"

