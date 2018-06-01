#!/bin/sh

echo "mkdir -p conf logs data and copy mongo.conf"
mkdir -p conf logs data
#cp -rf mongod.yml conf

echo "docker run --name mongodb ... -d mongo:latest"
docker run \
  --name mongodb \
  -p 27017:27017 \
  -v $PWD/logs:/var/log/mongodb \
  -v $PWD/data:/data/db \
  -d mongo:latest \
