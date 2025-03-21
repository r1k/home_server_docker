#!/bin/bash

if [[ ! -d "litellm" ]]; then
    git clone https://github.com/BerriAI/litellm.git
fi

source .env

rm litellm/.env || true

echo "DOCKER_PERSIST=$DOCKER_PERSIST" >> litellm/.env

# create env file
RANDOM_KEY=$(head /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 16)
echo "LITELLM_MASTER_KEY=sk-$RANDOM_KEY" >> litellm/.env

RANDOM_KEY=$(head /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 16)
echo "LITELLM_SALT_KEY=sk-$RANDOM_KEY" >> litellm/.env

# store data on the file system
sed -i -E 's/postgres_data:\/var\/lib\/postgresql\/data/\$DOCKER_PERSIST\/LiteLLM:\/var\/lib\/postgresql\/data/gm;t' litellm/docker-compose.yml