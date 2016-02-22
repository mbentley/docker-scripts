#!/bin/bash

set -e

# get list of containers that are in an 'exited' status
REMOVABLE_CONTAINERS=$(docker ps -f status=exited -f status=created -qa)

# if removablecontainers are in the list; remove them but leave any docker managed volumes
if [ -z "${REMOVABLE_CONTAINERS}" ]
then
  echo "No stopped docker containers to remove"
else
  echo "Removing stopped docker containers:"
  docker rm ${REMOVABLE_CONTAINERS}
fi
