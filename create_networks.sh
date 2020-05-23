#!/bin/sh

if [ ! $(docker network ls -q -f name=reverse-proxy) ]; then
  docker network create --driver bridge reverse-proxy
fi

