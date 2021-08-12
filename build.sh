#!/bin/bash

. config.sh

USERCONFIG="--build-arg user=${USERNAME} --build-arg uid=${USERID} --build-arg gid=${GROUPID}"

docker build ${USERCONFIG} -t ${IMAGENAME} .
