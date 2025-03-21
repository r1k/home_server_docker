#!/bin/bash

git clone https://github.com/BerriAI/litellm.git

# create env file
RANDOM_KEY=$(head /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 16)
echo "LITELLM_MASTER_KEY=sk-$RANDOM_KEY" >> litellm/.env

RANDOM_KEY=$(head /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 16)
echo "LITELLM_SALT_KEY=sk-$RANDOM_KEY" >> litellm/.env