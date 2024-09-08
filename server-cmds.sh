#!/usr/bin/env bash

export IMAGE=$1
docker login
echo "composing ${IMAGE}"
docker compose -f docker-compose.yaml up --detach
echo "success"
