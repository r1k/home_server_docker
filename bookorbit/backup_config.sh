#!/bin/bash

# backup local container to /mnt/nfs/docker-persist

for n in bookorbit_bookorbit_app_data bookorbit_bookorbit_postgres_data ; do

  echo "Backing upi volume $n to /mnt/nfs/docker_persist/$n.tar.gz"

  docker run --rm -v "$n":/data -v /mnt/nfs/docker-persist:/backup alpine  tar czf /backup/"$n".tar.gz -C /data .

  echo "Complete."

done
