#!/bin/bash

set -e

# get list of volumes that are currently used by a container
for i in $(docker ps -aq)
do
  USED_VOLUMES="${USED_VOLUMES} $(docker inspect ${i} | jq -r '.[].Mounts|.[].Name' | grep -v null || true)"
done

# get a list of all volumes
ALL_VOLUMES="$(docker volume ls -q)"

# compare used vs all and remove appropriately
for i in ${ALL_VOLUMES}
do
  echo ${USED_VOLUMES} | grep -w $i >/dev/null 2>&1 || (echo -n "Removing volume '$i'..."; docker volume rm $i > /dev/null && echo "done")
done
