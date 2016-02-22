#!/bin/bash

set -e

# create temporary files
IMAGES=$(tempfile)
CONTAINERS=$(tempfile)

# get a list of all image on the system and write to temp file
docker images | grep -v ^REPOSITORY | awk '{print $1":"$2}' | sort > ${IMAGES}

# get a list of all images used by existing containers on the system and write to temp file
docker ps -a | grep -v ^'CONTAINER ID' | awk '{print $2}' | sort > ${CONTAINERS}

# compare the two lists to see which images are not used for an existing container; skip untagged
UNUSED_IMAGES="$(comm -13 ${CONTAINERS} ${IMAGES} | grep -v '<none>')"

# remove unused images
docker rmi ${UNUSED_IMAGES}

# remove the temp files
rm ${IMAGES} ${CONTAINERS}
