#!/bin/bash
set -o errexit -o pipefail -o nounset

mypath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

imagetag=teams
stdparams=""
additionalparams=""

function build {
#	docker system prune
	docker build ${stdparams} -t ${imagetag} ${mypath}
}

function run {
	docker run -it --rm ${stdparams} \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /home/user1/alternativHome/teams/:/home \
	--name ${imagetag} --hostname ${imagetag} ${additionalparams} ${imagetag} 
}


case $1 in
	b)
	echo "build"
	build
	;;
	r)
	echo "run"
	run
	;;
	br)
	build && run
	;;
	bash)
	additionalparams="--entrypoint /bin/bash"
	run
	;;
	xterm)
	additionalparams="--entrypoint /usr/bin/xterm"
	run
	;;
	*)
	echo "unbekanntes Kommando: $1"
	;;
esac



