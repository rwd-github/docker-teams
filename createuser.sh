#!/bin/bash
set -o errexit -o pipefail -o nounset

echo "---  add user ${TEAMS_USERNAME}"
if [ ! $(id -u ${TEAMS_USERNAME} 2>/dev/null) ]; then
	nohome=""
	if [ -d /home/${TEAMS_USERNAME} ]; then nohome=--no-create-home; fi
	addgroup --gid ${TEAMS_GID} ${TEAMS_USERNAME}
	adduser --uid ${TEAMS_UID} --gid ${TEAMS_GID} --disabled-password ${nohome} --gecos "" ${TEAMS_USERNAME}
	pushd /home/${TEAMS_USERNAME}
#	usermod -a -G adm ${myuser}
#	usermod -a -G sudo ${myuser}

	chown -R ${TEAMS_UID}:${TEAMS_GID} .
	popd
else
	echo "  user already exists."
fi


