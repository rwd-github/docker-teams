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
	--name ${imagetag} --hostname ${imagetag} ${additionalparams} ${imagetag} 
#	-v ${mypath}/../home:/home \
#	-p 33890:3389 \
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
	*)
	echo "unbekanntes Kommando: $1"
	;;
esac



