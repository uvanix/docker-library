#!/bin/sh

echo "mkdir -p data"
mkdir -p data
chown -R 200 $PWD/data

echo "docker run --name nexus ... -d sonatype/nexus3"
docker run \
  --name nexus \
  --privileged \
  -p 8081:8081 \
  -v $PWD/data:/nexus-data \
  -d sonatype/nexus3 \
