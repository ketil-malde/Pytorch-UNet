#!/bin/bash

. $(dirname "$0")/config.sh

USERCONFIG="--build-arg user=${USERNAME} --build-arg uid=${USERID} --build-arg gid=${GROUPID}"

docker build ${USERCONFIG} -t ${IMAGENAME} $(dirname "$0")
