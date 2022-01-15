#!/bin/sh
#
# check if docker is running
if ! (docker ps >/dev/null 2>&1) ; then
  echo "docker daemon not running, will exit here!"
  exit
fi
echo "Preparing folder init and creating ./init/initdb.sql"
mkdir -p /mnt/storage1/docker-persist/guacamole/init >/dev/null 2>&1
chmod -R +x /mnt/storage1/docker-persist/guacamole/init
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > /mnt/storage1/docker-persist/guacamole/init/initdb.sql
echo "done"
