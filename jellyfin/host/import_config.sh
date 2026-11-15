#!/bin/bash

CONTAINER_NAME=host_jellyfin-config

docker volume create "$CONTAINER_NAME" && \
docker run --rm -v "$CONTAINER_NAME":/data -v /mnt/nfs/docker-persist:/backup alpine \
  tar xzf /backup/"$CONTAINER_NAME".tar.gz -C /data

