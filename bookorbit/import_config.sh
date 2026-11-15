#!/bin/bash

for n in bookorbit_bookorbit_app_data bookorbit_bookorbit_postgres_data ; do

  echo "Restoring volume $n from /mnt/nfs/docker_persist/$n.tar.gz"

  docker volume create "$n" 
  docker run --rm -v "$n":/data -v /mnt/nfs/docker-persist:/backup alpine \
      tar xzf /backup/"$n".tar.gz -C /data

  echo "Complete."
	        
done
