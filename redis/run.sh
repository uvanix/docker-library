#!/bin/sh

echo "mkdir -p conf logs data and copy redis.conf"
mkdir -p conf logs data
cp -rf redis.conf conf

echo "docker run --name redis ... -d redis:latest"
docker run \
  --name redis \
  --privileged \
  -p 6379:6379 \
  -v $PWD/conf/redis.conf:/usr/local/etc/redis/redis.conf \
  -v $PWD/logs:/var/log/redis \
  -v $PWD/data:/data \
  -d redis:latest \
  redis-server /usr/local/etc/redis/redis.conf
