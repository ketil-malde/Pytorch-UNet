#!/bin/bash

. config.sh

USERCONFIG="--user ${USERID}:${GROUPID}"

docker run ${USERCONFIG} --rm -it ${IMAGENAME}
