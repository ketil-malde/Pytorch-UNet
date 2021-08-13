#!/bin/bash

. $(dirname "$0")/config.sh

USERCONFIG="--user ${USERID}:${GROUPID}"

docker run ${OPTIONS} --privileged ${USERCONFIG} --rm -it ${IMAGENAME} $*
