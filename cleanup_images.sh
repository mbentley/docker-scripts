#!/bin/bash

set -e

# get list of untagged images and remove them
if docker images | grep "^<none>" >/dev/null 2>&1
then
  echo "Removing untagged docker images:"
  docker rmi $(docker images --filter "dangling=true" -q) || true
else
  echo "No untagged docker images to remove"
fi
