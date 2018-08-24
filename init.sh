#!/bin/bash
set -eux
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

mkdir -p certs
mkdir -p log
touch log/syslog

docker-compose run --rm \
	-e HUID=$(id -u) \
	-e HGID=$(id -g) \
mail copy-snakeoil

