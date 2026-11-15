#!/bin/bash

# backup local container to /mnt/nfs/docker-persist

CONTAINER_NAME=host_jellyfin-config

docker run --rm -v "$CONTAINER_NAME":/data -v /mnt/nfs/docker-persist:/backup alpine  tar czf /backup/"$CONTAINER_NAME".tar.gz -C /data .
