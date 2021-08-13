#!/bin/bash

. $(dirname "$0")/config.sh

USERCONFIG="--user ${USERID}:${GROUPID}"

docker run ${OPTIONS} ${USERCONFIG} --rm -it ${IMAGENAME} $*
